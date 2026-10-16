---
name: ignition-issue-guide
description: Knowledge base of resolved technical issues from the KW plant's Ignition/SCADA, DCS, BI reporting, sensor/instrumentation, and system integration environment, sourced from Microsoft Teams support chats. Use this skill whenever a user asks a troubleshooting question about Ignition Designer/SCADA screens, DCS displays, tag mapping, BI report/dashboard errors, server or network outages at the plant, sensor or Jerk% calibration, RM Pile inventory calculation, or Solar/meter data integration — even if they don't mention "knowledge base" by name. Also use this skill when a user wants to add a newly resolved issue to the KB, or wants the KB (or part of it) exported as a Word document or PDF.
---

# Ignition Issue Guide (KW Plant)

## Changelog

- 2026-10-16 — Fixed self-update: update.sh now complete (was cut off), finds its own install folder, has --check preview, handles blocked network; SKILL.md update steps + offline fallback rewritten, commans/ → commands/
- 2026-09-30 — Renamed skill kw-issue-kb → ignition-issue-guide (ชื่อ Skill/โฟลเดอร์เท่านั้น เนื้อหา Entry ไม่เปลี่ยน)
- 2026-09-30 — Updated SA-008 (ตัด note เรื่อง FTP ออก ตาม Fix ver)
- 2026-09-30 — Updated SA-020 (เพิ่ม Event ID 10016/10036 + ชี้ไป Manual เปลี่ยน Auth Level ตาม Fix ver)
- 2026-09-30 — Updated SA-023 (เหลือแค่ DB IP/JDBC URL, ตัด Easy Chart Resolution Mode ออก ตาม Fix ver)
- 2026-09-30 — Updated SA-027 (Status เป็น Closed, เพิ่ม Fix steps: Storage Provider/History Enabled/Restart server)
- 2026-09-30 — Updated NI-002 (เพิ่ม step เช็ค Disk ก่อนเคลียร์)
- 2026-09-30 — Updated IN-003 (เพิ่ม step ยืนยัน DB type + ขั้นตอนเปิด Remote Access PostgreSQL จาก Manual IN-003_2)
- 2026-09-30 — Updated IN-004 (Fix เป็น 3 steps: Postman → เช็ค API อื่น → แก้ Proxy)
- 2026-09-30 — Updated IN-005 (Fix step 2 ระบุ URL เก่า→ใหม่ + ตัวอย่าง Tag path, ตัด Note ที่รอ Confirm)
- 2026-09-23 — Updated IN-005: root cause was EC_DB's short retention (~15 days), not just the API URL — fix now also routes older queries to TS_DB. SA-025 checked against 6/29 chat, no change needed (already accurate).
- 2026-09-23 — Added SA-020 to SA-029 (Pyro Rotor DCOM recurring, Pyro Rotor OPC-UA/DA setup, Switch Hub reconnect, SKW trend DB IP, addPen script, WHG bad_connected, Vibratag discontinuous, kw_tag storage provider, Power Meter disconnected, EIS gateway shutdown) and IN-003 to IN-005 (PostgreSQL remote DB, ThingsBoard proxy, Zycoda API URL).
- 2026-09-23 — Corrected SA-011 (added Teams Reference Link), SA-013 (added "contact VCM maintenance" step, wording fix), SA-016 (added fallback note to Reference Link), NI-003 (Root Cause/Fix wording refined) per team feedback.
- 2026-09-23 — Added SA-011 to SA-019 (Java Heap, WHG OPC หาย, VCM cable, DCOM OpcEnum, Expression, TS5 update, Dashboard lock, Designer browse, DB Faulted), NI-002/NI-003 (Disk เต็ม, Gateway LP error), IN-002 (DeviceXplorer OPC UA).
- 2026-09-23 — Added SA-009 (QIS ค่าไม่อัพเดท Operator/Polling, 5/29/20), SA-010 (หา Tag KCC ไม่เจอ/All Providers, 6/22/20).
- 2026-09-23 — Added SA-007 (Auto Report แนบไฟล์เดียว/หลายหน้า, Q1), SA-008 (Schedule Save ไม่เจอไฟล์/Server สิทธิ์, Q3). Backfilled SA-006 source date (Q2, 4/23/20).
- 2026-09-23 — Added SA-006 (Report สี Conditional ตามค่า, Keychain Expressions link). Added optional Reference Link field.
- 2026-09-23 — Changelog description field is now short + mixed Thai/English, matching entry style.
- 2026-09-23 — Updated: add/update/remove now covered in one section, with a required changelog line for every change.
- 2026-09-23 — Added Draft-only vs Direct-edit modes for adding new issues.
- 2026-09-23 — Initial version. Documented: SA-001, NI-001. Open/tracked: SA-002 to SA-005, IN-001.

This skill turns resolved Microsoft Teams support-chat threads into a searchable,
categorized reference so recurring plant IT/OT problems can be answered without
re-posting to the team chat.

## How the knowledge base is organized

```
ignition-issue-guide/
├── SKILL.md                     ← this file
├── references/
│   ├── system-app.md            ← SCADA/Ignition screens, BI reports, sensors, inventory logic
│   ├── network-infra.md         ← servers, network, hardware outages
│   └── integration.md           ← external system/API/meter integrations
├── open-issues.md               ← issues logged but not yet resolved (not answerable yet)
└── templates/
    └── entry-template.md        ← template for adding a new resolved issue
```

Every resolved issue is written as a single self-contained entry with five fields:
**Problem, Symptom, Root Cause, Fix, Verification** — plus a Category, an ID
tying it back to the source log, and a Source note. Some entries also carry
an optional **Reference Link** field, when the fix points to an official
external doc (e.g. Inductive Automation documentation) rather than being a
self-contained procedure. This structure is plain Markdown by design, so any
AI system or human reading these files directly (not just Claude) can use
them without special tooling.

## Answering a user's question

1. Identify which category the question most likely falls under (SCADA/App
   issue, Network/Infra outage, or external Integration) and read that
   reference file.
2. Look for an entry whose Symptom or Problem matches what the user describes,
   even if worded differently — plant staff describe the same issue in varied
   ways (e.g. "ตำแหน่ง Tag เพี้ยน" and "tag positions shifted" are the same
   issue).
3. If a match is found: give the Root Cause and Fix steps directly, in plain
   language, matching the user's technical level. Mention the Verification
   step so they know how to confirm it worked. Cite the entry's ID. If the
   entry has a **Reference Link**, include it in the answer — don't just
   name the resource, give the actual URL so the person can go straight to
   it.
4. If no entry matches: say plainly that this isn't in the knowledge base yet,
   and suggest it be raised on the Teams support chat and logged for later
   documentation. Do not guess at a fix for plant SCADA/DCS/hardware issues —
   an incorrect guess in this environment can affect live production systems.
   If you're confident of an official documentation page that would help even
   without a matching KB entry, you may still share that link, but say
   clearly that it isn't a documented KB answer.
5. Check `open-issues.md` too — if the user's issue matches something already
   logged but unresolved, tell them it's a known open issue rather than
   suggesting it's undocumented.

## Changelog format

Whenever an entry is added, updated, or removed (in either mode below), also
output a changelog line in this exact format, so the user can paste it under
the **Changelog** heading at the top of this file:

```
## Changelog

- YYYY-MM-DD — Added <ID> (<short description>, Issued_Log #<n>)
- YYYY-MM-DD — Updated <ID> (<what changed and why>)
- YYYY-MM-DD — Removed <ID> from open-issues.md (resolved, moved to <file>)
```

Use today's date, the real or placeholder ID, and pick the line that matches
the action taken. Keep the `<short description>` / `<what changed and why>`
part short (a few words) and in the same mixed Thai/English style as the KB
entries themselves (see Language style below) — e.g. `Sensor Copper Slag
Jerk แก้แล้ว, Issued_Log #4` rather than a full English sentence. Always
produce this line even in Draft-only mode — it's just as much a draft as the
entry itself, and the user pastes it in at the same time they paste the
entry.

## Adding, updating, or removing an entry

When a user shares a new resolved Teams chat thread (as text, PDF, or a
CSV/log row) and asks to add, update, or remove an entry, first work out
which of the two modes below applies — they produce very different output,
and picking wrong risks overwriting someone else's edits or working from a
stale copy.

**Default to Draft-only mode** unless the user has clearly uploaded the
_current_ SharePoint copy of the reference files into this same
conversation and explicitly asked to edit them directly. The reason for this
default: a chat's file workspace is private and temporary — it is not
connected to SharePoint or to any other device or conversation. Editing the
reference files directly, inside a chat, only produces an edit that lives in
that one chat until someone manually exports and re-uploads it to
SharePoint. Skipping that manual step is the most common way this KB goes
out of sync, so draft-only is the safer default.

### Draft-only mode (default)

**To add a new entry:**

1. Read `templates/entry-template.md` for the exact fields and the bilingual
   style example.
2. Extract Problem / Symptom / Root Cause / Fix / Verification from the
   thread. Paraphrase for clarity — don't just paste the raw chat. Write
   content in the mixed Thai/English style described below; keep field
   labels in English. If the resolution points to an official external doc
   (e.g. a vendor documentation page) rather than being self-contained, add
   a **Reference Link** field with the real URL.
3. Decide the Category (System&App. / Network&Infra / Integration) and say
   which `references/<category>.md` file this belongs in.
4. Leave the **ID as a placeholder** — e.g. `SA-### (check last ID used in
references/system-app.md before assigning)`. Never guess the next number,
   since this mode doesn't have visibility into the live file's current
   contents.
5. Write the finished entry to a **new standalone file**
   (`draft-<short-slug>.md`) — do not edit any file under `references/` or
   `open-issues.md` in this mode.
6. Add the matching **Changelog format** line (Added) to the same draft
   file or your reply.

**To update or remove an existing entry:** the user needs to tell you (or
paste) the existing entry's current text, since this mode can't see the live
file. Produce the corrected/updated entry text (or note that it should be
removed) as a standalone draft, plus the matching Changelog line (Updated or
Removed).

**In all cases:** present the draft and the changelog line together, and
tell the user plainly this is a draft only — they (or whoever maintains the
SharePoint copy) need to open the real file(s), make the change themselves,
and paste the changelog line in under the Changelog heading.

### Direct-edit mode (only when explicitly requested with the current files present)

Only do this when the user has uploaded the live SharePoint files into this
conversation and clearly asked for them to be edited directly (not drafted).
In that case:

- **Add:** follow the same extraction steps above, but append the finished
  entry straight into the correct `references/<category>.md` file (assigning
  the real next ID, since the current file is visible), and remove the
  matching row from `open-issues.md` if present.
- **Update:** edit the existing entry in place in the correct file.
- **Remove:** delete the entry from the correct file (or its row from
  `open-issues.md`).
- In every case, also append the matching **Changelog format** line directly
  under the Changelog heading in `SKILL.md`.
- Remind the user to export the updated file(s) and overwrite the SharePoint
  copy immediately — the edit only exists in this conversation until they do.

## Exporting the knowledge base to a document

When a user asks for the KB (or one category) as a Word document or PDF:

1. Read the relevant `references/*.md` file(s).
2. Follow the **docx** skill (`/mnt/skills/public/docx/SKILL.md`) to produce
   a formatted Word document — one section per category, one subsection per
   entry, using the same five-field structure. Use the **pdf** skill instead
   if the user specifically asks for a PDF.
3. Present the finished file to the user; do not just describe it.

## Language style

Answer in a mix of Thai and English, the way the plant team actually talks in
these chats: natural sentences in Thai, with technical terms left in English
rather than translated — e.g. Resolution, Tag, Group, Project Properties,
RAID, Server, Backup, License, API, Capacity, Threshold. Don't force a fully
English or fully Thai answer; match the register of the original source
chats. This applies to both answering a user's question and writing new KB
entries.

## Notes on scope

- This KB only contains **resolved** issues. Anything still Pending/In
  Progress belongs in `open-issues.md`, not in a reference file, so the
  skill never presents an unverified fix as a confirmed solution.
- Entries are written in mixed Thai/English per the Language style section
  above, with original Thai tag/screen names preserved where they aid
  identification (e.g. tag paths, project names).

## Updating this skill

When the user asks to update this skill, update it from its official GitHub
repository (https://github.com/AddChanin/team-knowledge-skill-test, folder
`skills/ignition-issue-guide`).

**Step 1 — Find the updater.** Don't assume where the skill is installed. The
script lives next to this file, so use the folder `SKILL.md` was loaded from
(shown as "Base directory for this skill" when the skill loads), e.g.
`<base directory>/scripts/update.sh`. Typical locations are
`~/.claude/skills/ignition-issue-guide/` (Claude Code / desktop) or a managed
plugin folder such as `/mnt/skills/plugins/ignition-issue-guide/` (chat).
The script updates the folder it belongs to, so no path override is needed.

**Step 2 — Preview first, then ask.** Run
`bash "<base directory>/scripts/update.sh" --check`. It downloads the latest
version and lists which files differ, and changes nothing. Tell the user in
one or two sentences what would change and that applying the update replaces
the installed files (the old version is kept next to it as a `.bak-<date>`
folder). Ask for confirmation. If the user declines, stop.

**Step 3 — Apply.** After confirmation run
`bash "<base directory>/scripts/update.sh" --yes`.

**Step 4 — Report honestly.**

- Exit 0 with "Updated ... successfully": say it succeeded, summarize which
  files changed, and re-read `SKILL.md` before continuing, since the
  instructions may have changed.
- Exit 0 with "Already up to date": say there is nothing to update.
- Exit 3 (could not download): outbound access to GitHub is blocked here
  (common in sandboxed chat workspaces) or the machine is offline. Say so
  plainly and do not try other download routes (curl variants, mirrors,
  caches). Then use the **fallback** below.
- Exit 4 (not writable) or any other error: relay the script's message
  accurately and tell the user nothing was changed. Never claim success when
  the script reported an error.

**Fallback when the download is blocked.** A chat workspace is temporary and
is not the user's real installation, so even a successful update there would
not persist. Instead:

1. Offer the user two routes: (a) run
   `bash ~/.claude/skills/ignition-issue-guide/scripts/update.sh` on their own
   computer, or (b) download the repo (or just
   `skills/ignition-issue-guide`) as a ZIP from GitHub and attach it here.
2. If they attach it, compare it with the loaded skill (Changelog lines first,
   then the reference files), summarize what is newer, and treat any
   follow-up edits as **Draft-only mode** (see above), reminding them to copy
   the result back to SharePoint or the real install.
3. If the user only wants to know whether a newer version exists, you may
   read the public repo page with WebFetch and compare the top Changelog
   entries with the loaded `SKILL.md`. Say that this is a read-only comparison
   and that nothing was updated.

**Record the update.** After a successful update, add this line under the
Changelog heading if the downloaded `SKILL.md` doesn't already contain it:

```
- YYYY-MM-DD — Updated skill from GitHub (update.sh)
```
