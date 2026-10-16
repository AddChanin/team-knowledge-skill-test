#!/usr/bin/env bash
# Updates the installed ignition-issue-guide skill from its public GitHub repo.
# Repository: https://github.com/AddChanin/team-knowledge-skill-test
#
# Where does it update?
#   By default, the skill folder this script lives in (scripts/.. ), so it works
#   wherever the skill is installed (~/.claude/skills, a plugin folder, etc.).
#   Set CLAUDE_SKILLS_DIR to override with <that dir>/ignition-issue-guide.

set -Eeuo pipefail

OWNER="AddChanin"
REPO="team-knowledge-skill-test"
BRANCH="main"
SOURCE_RELATIVE_PATH="skills/ignition-issue-guide"
SKILL_NAME="ignition-issue-guide"

# Exit codes: 0 ok / up to date, 1 general error, 2 bad usage,
#             3 cannot reach GitHub (network blocked or offline),
#             4 install location is not writable, 5 user declined.

usage() {
  cat <<USAGE
Usage: $(basename "$0") [--check] [--yes]

Updates $SKILL_NAME from the latest commit on GitHub branch '$BRANCH'.

Options:
  --check   Only download and report which files differ. Changes nothing.
  --yes     Skip the interactive confirmation (use only after the user
            has confirmed the update).
  -h        Show this help.

Environment variables (optional):
  CLAUDE_SKILLS_DIR          Parent dir containing $SKILL_NAME to update.
                             Default: the folder this script belongs to.
  SKILL_UPDATE_ARCHIVE_URL   Override the download URL (used for testing,
                             file:// URLs work).
USAGE
}

# Globals so the EXIT trap can still see them after main() returns.
TMP_DIR=""
STAGE_DIR=""
cleanup() {
  [[ -n "$TMP_DIR" && -d "$TMP_DIR" ]] && rm -rf "$TMP_DIR"
  [[ -n "$STAGE_DIR" && -d "$STAGE_DIR" ]] && rm -rf "$STAGE_DIR"
  return 0
}

main() {
  local assume_yes=false check_only=false
  while (($#)); do
    case "$1" in
      --yes) assume_yes=true ;;
      --check) check_only=true ;;
      -h|--help) usage; return 0 ;;
      *) echo "Unknown option: $1" >&2; usage >&2; return 2 ;;
    esac
    shift
  done

  local cmd
  for cmd in curl unzip find cp mv mkdir mktemp diff date; do
    command -v "$cmd" >/dev/null 2>&1 || {
      echo "Error: required command '$cmd' was not found." >&2
      return 1
    }
  done

  # --- Work out where the skill is installed -------------------------------
  local script_dir install_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -n "${CLAUDE_SKILLS_DIR:-}" ]]; then
    install_dir="${CLAUDE_SKILLS_DIR%/}/$SKILL_NAME"
  else
    install_dir="$(dirname "$script_dir")"
  fi

  if [[ ! -f "$install_dir/SKILL.md" ]]; then
    echo "Error: no SKILL.md found in $install_dir" >&2
    echo "Set CLAUDE_SKILLS_DIR to the folder that contains $SKILL_NAME/." >&2
    return 1
  fi

  # --- Download -------------------------------------------------------------
  local backup_dir=""
  TMP_DIR="$(mktemp -d)"
  trap cleanup EXIT

  local archive_url="${SKILL_UPDATE_ARCHIVE_URL:-https://github.com/${OWNER}/${REPO}/archive/refs/heads/${BRANCH}.zip}"
  local zip_file="$TMP_DIR/repo.zip" extract_dir="$TMP_DIR/extracted"

  printf 'Installed skill : %s\n' "$install_dir"
  printf 'Checking latest : %s/%s (%s)\n' "$OWNER" "$REPO" "$BRANCH"

  if ! curl --fail --location --silent --show-error --retry 2 --connect-timeout 15 \
      "$archive_url" --output "$zip_file" 2>"$TMP_DIR/curl.err"; then
    echo "Error: could not download the update." >&2
    sed 's/^/  /' "$TMP_DIR/curl.err" >&2 || true
    echo "This usually means outbound access to GitHub is blocked (for example" >&2
    echo "inside a sandboxed chat workspace) or the machine is offline." >&2
    echo "Nothing was changed. Run this script on a machine with internet access," >&2
    echo "or download the repo ZIP manually and replace the skill folder." >&2
    return 3
  fi

  mkdir -p "$extract_dir"
  unzip -q "$zip_file" -d "$extract_dir"

  local repo_root source_dir
  repo_root="$(find "$extract_dir" -mindepth 1 -maxdepth 1 -type d -print -quit)"
  if [[ -z "$repo_root" ]]; then
    echo "Error: the downloaded archive did not contain a repository folder." >&2
    return 1
  fi
  source_dir="$repo_root/$SOURCE_RELATIVE_PATH"

  if [[ ! -f "$source_dir/SKILL.md" ]]; then
    echo "Error: expected '$SOURCE_RELATIVE_PATH/SKILL.md' was not found in the repository." >&2
    echo "Nothing was changed." >&2
    return 1
  fi
  if [[ ! -f "$source_dir/open-issues.md" || ! -d "$source_dir/references" || ! -d "$source_dir/templates" ]]; then
    echo "Error: the downloaded skill folder is missing expected files or folders." >&2
    echo "Expected SKILL.md, open-issues.md, references/ and templates/. Nothing was changed." >&2
    return 1
  fi

  # --- Compare --------------------------------------------------------------
  local diff_out
  diff_out="$(diff -rq "$install_dir" "$source_dir" || true)"
  if [[ -z "$diff_out" ]]; then
    echo "Already up to date. No files differ from GitHub."
    return 0
  fi

  echo
  echo "Files that differ from GitHub:"
  printf '%s\n' "$diff_out" \
    | sed -e "s#$install_dir#<installed>#g" -e "s#$source_dir#<github>#g" \
    | sed 's/^/  /'
  echo

  if $check_only; then
    echo "Check only: nothing was changed."
    return 0
  fi

  # --- Confirm --------------------------------------------------------------
  if ! $assume_yes; then
    if [[ ! -t 0 ]]; then
      echo "Error: no terminal to ask for confirmation. Re-run with --yes after the user approves." >&2
      return 5
    fi
    local reply
    read -r -p "Replace the installed skill with the GitHub version? [y/N] " reply
    if [[ ! "$reply" =~ ^[Yy]$ ]]; then
      echo "Update cancelled. Nothing was changed."
      return 5
    fi
  fi

  # --- Install (stage, back up, swap, roll back on failure) ----------------
  local parent_dir
  parent_dir="$(dirname "$install_dir")"
  if [[ ! -w "$parent_dir" ]]; then
    echo "Error: $parent_dir is not writable, so the skill cannot be replaced." >&2
    echo "Nothing was changed." >&2
    return 4
  fi

  STAGE_DIR="$(mktemp -d "$parent_dir/.${SKILL_NAME}.stage.XXXXXX")"
  cp -a "$source_dir/." "$STAGE_DIR/"
  [[ -f "$STAGE_DIR/scripts/update.sh" ]] && chmod +x "$STAGE_DIR/scripts/update.sh"

  backup_dir="${install_dir}.bak-$(date +%Y%m%d-%H%M%S)"
  mv "$install_dir" "$backup_dir"
  if ! mv "$STAGE_DIR" "$install_dir"; then
    echo "Error: could not move the new version into place. Restoring the old one." >&2
    mv "$backup_dir" "$install_dir"
    return 1
  fi
  STAGE_DIR=""

  echo "Updated $SKILL_NAME successfully."
  echo "Previous version kept at: $backup_dir"
  echo "Re-read SKILL.md before continuing, the instructions may have changed."
  return 0
}

# Everything is wrapped in main() and run from here, so bash has parsed the whole
# script before the skill folder (which contains this file) is swapped out.
main "$@"
exit $?
