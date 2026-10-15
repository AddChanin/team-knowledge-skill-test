# How to Add or Update an Issue (Manual Edit Guide)

This folder is plain text (`.md` files) — you can open and edit any of these
in Notepad, Word, VS Code, or SharePoint's own text editor. No coding needed.
`SKILL.md` is written for the AI, not for you — this file is your guide.

## Where things live

| If the new/updated ticket is about... | Edit this file |
|---|---|
| SCADA/Ignition screens, DCS, BI reports, sensors, inventory calculations | `references/system-app.md` |
| Server, network, hardware outages | `references/network-infra.md` |
| External systems, meters, APIs feeding reports | `references/integration.md` |
| A ticket that's still open / not yet resolved | `open-issues.md` (not the reference files — don't document an unconfirmed fix) |

## Using an AI to draft the entry text for you

You don't have to write the bilingual entry by hand — you can ask an AI with
this skill loaded to draft it from a resolved ticket or chat thread. By
default it will hand you back a **draft file only** (it won't touch the
real reference files), with the ID left blank for you to fill in yourself
after checking the last-used number in the target file. That draft is what
you paste into the shared file using the steps above — the AI drafting the
text doesn't remove the manual "paste it into SharePoint" step, it just
saves you writing the bilingual entry from scratch.

## Adding a new resolved issue

1. Open `templates/entry-template.md` and copy the empty entry block (the
   one with `<...>` placeholders).
2. Fill in every field. Keep the field labels (Problem, Symptom, Root Cause,
   Fix, Verification) in English — that structure is what makes the file
   usable by any AI reading it. Write the actual content in Thai, keeping
   technical terms in English (Resolution, Tag, Group, RAID, Server, API,
   Threshold, etc.) — see the worked example further down in the same file
   for what this should look like.
3. Give it an ID: next number in that category's prefix (SA-, NI-, or IN-).
   Check the last entry in the file to see what number to use next.
4. Paste your finished entry at the **bottom** of the correct
   `references/<category>.md` file, under a `---` divider line.
5. If this ticket was listed in `open-issues.md`, delete its row from that
   table now — it's no longer open.
6. Open `SKILL.md`, find the **Changelog** heading near the top, and add a new
   line above the others with today's date and a short, mixed Thai/English
   description of what you added, e.g.:
   `- 2026-10-01 — Added SA-006 (Sensor Copper Slag Jerk แก้แล้ว, Issued_Log #4).`
   This is how anyone can tell at a glance whether the file reflects the
   latest tickets, without reading the whole thing.

## Things not to break

- Don't touch the section between the two `---` lines at the very top of
  `SKILL.md` (the `name:`/`description:` block) — that's what tells the AI
  when to use this skill at all.
- Keep one `---` divider between each entry in a reference file — that's
  what keeps entries visually separated and easy to scan.
- Don't move a Pending/In Progress ticket into a `references/` file until
  it's actually Closed with a confirmed fix.

## After editing

If your team installs this as a `.skill` file inside Claude (rather than
just pointing an AI at this shared folder each time), the installed copy
does **not** update itself when you edit these files in SharePoint. Someone
needs to re-zip this folder into a fresh `.skill` file and have people
reinstall it. If everyone instead just points their AI at this SharePoint
folder directly each time, there's nothing to re-package — the folder
itself is always current.
