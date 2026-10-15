Keep the field labels in English (ID, Status, Problem, etc.) so the structure
stays consistent and parseable by any AI system. Write the *content* of each
field in a mix of Thai and English — natural Thai sentences, with technical
terms left in English (Resolution, Tag, Group, Project Properties, RAID,
Server, Backup, License, API, Capacity, Threshold, etc.), matching how the
source Teams chats are actually written. Don't translate technical terms
into Thai just for consistency — that makes entries harder to match against
future chats that use the same English terms.

---

### Entry: <Short descriptive title>
- **ID:** <CATEGORY-PREFIX-###> (link back to Issued_Log ID if applicable)
- **Status:** Closed
- **Priority:** <L / M / H, from source log if available>
- **Problem:** <What the user was trying to do, in one or two sentences>
- **Symptom:** <The error, behavior, or visible sign of the problem>
- **Root Cause:** <Why it happened — the underlying technical reason>
- **Fix:**
  1. <Step one>
  2. <Step two>
  3. <...>
- **Verification:** <How to confirm the fix worked>
- **Reference Link:** <Optional — official docs URL, only if the fix points to one, e.g. Inductive Automation docs>
- **Source:** <Teams chat date/thread, or Issued_Log ID>

---

## Worked example (bilingual style)

### Entry: หน้าจอ SCADA ตำแหน่ง Tag เพี้ยนหลัง Upload (Ignition Designer)
- **ID:** SA-001
- **Status:** Closed
- **Priority:** M
- **Problem:** ออกแบบหน้าจอ SCADA ใน Ignition Designer แล้ววาง Tag ไว้ในตำแหน่ง
  ที่ต้องการ แต่พอ Upload ขึ้น Runtime ตำแหน่ง Tag เพี้ยนไปจากที่ออกแบบไว้
- **Symptom:** Component และ Numeric Label แสดงตำแหน่งเลื่อน/เพี้ยนบนหน้าจอ
  Runtime เมื่อเทียบกับหน้าจอ Designer
- **Root Cause:** Resolution ตอนออกแบบ (เช่น 800x640, 4:3) ไม่ตรงกับ
  Resolution จริงของจอที่ใช้ Runtime (เช่น 1366x768, 16:9) ทำให้ Component
  เลื่อนตำแหน่งตาม Window/Container ที่ Resize
- **Fix:**
  1. เช็ค Project Properties / Window Resolution ใน Ignition Designer
     เทียบกับ Resolution ของจอที่ใช้งานจริง
  2. ปรับ Resolution ของ Project/Window ให้ตรงกัน (กรณีนี้ Project ตั้งไว้ที่
     1024x768 — ปรับให้ตรง)
  3. ถ้ายังเพี้ยนอยู่ ให้เลือก Component ที่เกี่ยวข้องแล้วใช้ Group
     (คลิกขวา → Group) เพื่อให้เคลื่อนที่/Scale ไปด้วยกันเป็นก้อนเดียว
- **Verification:** เปิดหน้าจอ Runtime ใหม่ที่ Resolution เป้าหมาย แล้วเช็คว่า
  ตำแหน่ง Tag ตรงกับที่ออกแบบไว้
- **Source:** Teams chat, 4/18/20

---

## Worked example (with a Reference Link)

### Entry: Report แสดงสีตามเงื่อนไข (Conditional Formatting) เหมือน Dashboard
- **ID:** SA-006
- **Status:** Closed
- **Priority:** L
- **Problem:** ต้องการให้ Report แสดงสีของค่าตามเงื่อนไข (Conditional
  Formatting) แบบเดียวกับที่ Dashboard ทำได้ เช่น ถ้า X < 8 ให้แสดงสีขาว
- **Symptom:** N/A — เป็นคำถามเรื่อง Feature ไม่ใช่ Bug
- **Root Cause:** N/A
- **Fix:** ทำได้ครับ ใช้ **Keychain Expressions** ตามเอกสารด้านล่าง — กำหนด
  Expression ที่เช็คเงื่อนไขค่า แล้ว Map ไปเป็นสีที่ต้องการ
- **Verification:** ทดสอบ Report ด้วยค่าที่ตรงและไม่ตรงเงื่อนไข แล้วเช็คว่าสี
  เปลี่ยนตามที่ตั้งไว้
- **Reference Link:** https://docs.inductiveautomation.com/display/DOC80/Keychain+Expressions
- **Source:** Teams chat
