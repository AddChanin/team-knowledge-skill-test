---
description: Update ignition-issue-guide from its official GitHub repository
---

Help the user update the installed `ignition-issue-guide` skill from its official repository:
https://github.com/AddChanin/team-knowledge-skill-test

Follow the "Updating this skill" section of the skill's `SKILL.md`. In short:

1. Find the skill's own folder (the "Base directory" shown when the skill loads). Don't assume `~/.claude/skills`.
2. Preview: run `bash "<base directory>/scripts/update.sh" --check` and tell the user what would change.
3. Ask the user to confirm. If they decline, stop.
4. Apply: run `bash "<base directory>/scripts/update.sh" --yes`.
5. Report the script's actual output. Never claim success if it failed.
6. If GitHub can't be reached (exit 3), say so, don't try other download routes, and offer: run the script on their own computer, or attach the repo ZIP here for comparison.
7. After a successful update, re-read `SKILL.md` before continuing with any skill task.
