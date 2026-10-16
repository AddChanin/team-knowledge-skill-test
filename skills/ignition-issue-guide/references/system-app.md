# System & Application Issues

Covers Ignition Designer/SCADA screens, DCS displays, BI reporting, sensor
calibration, and inventory calculation logic.

---

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
- **Source:** Teams chat, 4/23/20 (Q2)

---

### Entry: Auto Report ส่งอีเมลพร้อมไฟล์แนบมากกว่า 1 ไฟล์ได้หรือไม่
- **ID:** SA-007
- **Status:** Closed
- **Priority:** L
- **Problem:** ต้องการทราบว่า Auto Report สามารถส่ง Email ครั้งเดียวพร้อมไฟล์
  แนบมากกว่า 1 ไฟล์ได้หรือไม่
- **Symptom:** N/A — เป็นคำถามเรื่อง Feature ไม่ใช่ Bug
- **Root Cause:** N/A
- **Fix:** ไม่ได้ครับ — ระบบรองรับการส่งเป็น 1 Report ที่มีหลายหน้า (Multi-page)
  แทน ไม่สามารถแนบหลายไฟล์แยกกันในอีเมลเดียวได้
- **Verification:** N/A
- **Source:** Teams chat, 4/23/20 (Q1)

---

### Entry: Schedule Save Action ไม่เจอไฟล์ — User ไม่มีสิทธิ์เข้าถึงเครื่อง Server
- **ID:** SA-008
- **Status:** Closed
- **Priority:** M
- **Problem:** ตั้งค่า Schedule ให้ Save Report ไปที่ Path บนเครื่อง Local (เช่น
  Link C:) แล้วกด Run แต่ไม่มีไฟล์เข้ามาใน Folder ที่กำหนดไว้
- **Symptom:** รัน Schedule แล้วไม่เห็นไฟล์ Report ถูก Save ลงใน Folder ที่
  ผู้ใช้กำหนดไว้บนเครื่อง Local/Client
- **Root Cause:** Save Action ใน Schedule จะบันทึกไฟล์ลงเครื่อง Server เท่านั้น
  ไม่ใช่เครื่อง Client/User ที่ตั้งค่า Schedule นั้น และเครื่อง Server ตัวจริง
  (Virtual Machine ที่บางซื่อ) ไม่ได้เปิดสิทธิ์ให้ User เข้าถึง — เครื่องที่ CCR
  ที่ลง Ignition นั้นเป็นเพียง Client ไม่ใช่ Server
- **Fix:**
  1. เข้าใจว่า Save Action ใน Schedule จะเขียนไฟล์ไปที่ระบบไฟล์ของเครื่อง
     Server เท่านั้น ไม่ใช่เครื่องที่ User Login อยู่
  2. เนื่องจาก User ไม่มีสิทธิ์เข้าถึงเครื่อง Server โดยตรง ให้ใช้วิธีส่ง
     Report ผ่าน Email แทนการ Save ลง Folder
  3. ถ้าจำเป็นต้องได้ไฟล์จริงในเครื่องอื่น พิจารณาใช้ FTP
- **Verification:** ตั้งค่า Schedule ให้ส่ง Report ทาง Email แทน แล้วตรวจสอบว่า
  ได้รับอีเมลพร้อมไฟล์แนบตามรอบเวลาที่ตั้งไว้
- **Reference Link:** https://docs.inductiveautomation.com/display/DOC80/Scheduling+Actions
- **Source:** Teams chat, 4/23/20 (Q3)

---

### Entry: ค่า QIS ไม่อัพเดทบนเครื่อง Operator (แต่เครื่อง Notebook ปกติ)
- **ID:** SA-009
- **Status:** Closed
- **Priority:** M
- **Problem:** ค่าคุณภาพจาก QIS ที่ดูผ่าน Ignition จากเครื่องคอม Operator
  ไม่อัพเดท แต่ดูผ่าน Notebook ไม่มีปัญหา
- **Symptom:** ข้อมูลจาก Table ที่ดึงค่ามาจาก Database QIS ไม่อัพเดทตามปกติ
  และข้อมูลที่แสดงในแต่ละเครื่องไม่ตรงกัน
- **Root Cause:** ไม่ได้ Set Polling ที่ Table ซึ่งดึงข้อมูลจาก Database QIS
  ทำให้ค่าที่ Query มาไม่ถูก Refresh ตามรอบเวลาที่ควรจะเป็น
- **Fix:**
  1. เช็ค Table/Query ที่ผูกกับข้อมูล QIS ว่ามีการตั้งค่า Polling หรือไม่
  2. ตั้งค่า Polling ของ Table ดังกล่าวเป็นทุก 10 นาที
- **Verification:** ติดตามผลหลังปรับ Polling — ผู้แจ้งยืนยันว่าค่าอัพเดทถูกต้อง
  แล้ว (แก้ไขเรียบร้อย)
- **Source:** Teams chat, 5/29/20

---

### Entry: หา Tag ของ KCC ไม่เจอใน Tag Browser
- **ID:** SA-010
- **Status:** Closed
- **Priority:** L
- **Problem:** ผู้ใช้มองหา Tag ของ KCC ผ่าน Property Binding > Tag Browser
  แต่ไม่พบ
- **Symptom:** Browse ผ่าน "Tags" folder ใน Tag Browser แล้วไม่เห็น Tag ของ kcc
- **Root Cause:** "Tags" folder ถูกตั้ง Default ให้ชี้ไปที่ Provider เดียวคือ
  EC_Tag เท่านั้น ไม่ได้รวม Provider อื่น เช่น KCC_Tag, KCL_Tag ฯลฯ
- **Fix:** ให้ค้นหา Tag ผ่าน **All Providers** แทน "Tags" folder จะเห็น Tag
  จากทุก Provider (EC_Tag, KCC_Tag, KCL_Tag, KK_Tag, KW_Tag, LP_Tag,
  MCL_Tag, SG_Tag, SJW_Tag, SWCC_Tag, TL_Tag, TS_Tag, VCM_Tag)
- **Verification:** Browse ผ่าน All Providers แล้วพบ Tag ของ KCC_Tag ตามที่
  ต้องการ
- **Source:** Teams chat, 6/22/20

---

### Entry: %Bin Copper Slag sensor value jerking / erratic
- **ID:** SA-002
- **Status:** Open — not yet resolved
- **Priority:** M
- **Notes:** Investigation into what causes erratic sensor readings for
  Copper Slag bin %. See `open-issues.md` (Issued_Log #4) — move here once a
  confirmed root cause and fix are documented.

---

### Entry: %Error Copper Slag — acceptable jerk range / threshold
- **ID:** SA-003
- **Status:** Open — not yet resolved
- **Priority:** M
- **Notes:** Related to SA-002. Approach under discussion: use historical
  average data to define an acceptable jerk range and set a Max threshold for
  what counts as normal fluctuation vs. an error. See `open-issues.md`
  (Issued_Log #5) — move here once finalized.

---

### Entry: RM Pile overlap — calculating remaining pile volume
- **ID:** SA-004
- **Status:** Open — not yet resolved
- **Priority:** M
- **Notes:** Question on how to calculate/view remaining old pile volume when
  a new pile is stacked on top of (overlapping) an old one. See
  `open-issues.md` (Issued_Log #6) — move here once a documented method
  exists.

---

### Entry: BI report graph fails to load — capacity limit reached
- **ID:** SA-005
- **Status:** In Progress — partial workaround only
- **Priority:** M
- **Problem:** A BI dashboard/report graph failed to render.
- **Symptom:** Error message "Unable to load model due to reaching capacity
  limits"; report data does not load or display.
- **Root Cause (suspected, not confirmed):** The BI system resource usage
  exceeded its capacity limit during high-usage periods; may be related to
  the system scaling down resources during off-hours (lower spec during
  non-working hours).
- **Workaround applied so far:** Deleted some data to free up working space
  — this is a temporary mitigation, not a root-cause fix.
- **Verification:** Not yet confirmed as permanently resolved.
- **Source:** Issued_Log #3 — revisit and move to Closed once a permanent
  fix is confirmed.

---

### Entry: Ignition แจ้ง Java Heap Space (Memory ไม่พอ)
- **ID:** SA-011
- **Status:** Closed
- **Priority:** M
- **Problem:** ไม่สามารถใช้งาน Ignition ได้ ขึ้น Error "Java Heap Space" เมื่อ
  Login
- **Symptom:** Login เข้า Ignition แล้วเจอ Error Java Heap Space ซ้ำ แม้จะ
  ปิดแล้ว Login ใหม่ในภายหลัง
- **Root Cause:** ค่า Memory Allocation (Heap Size) ที่ตั้งไว้สำหรับ Ignition
  Client/Designer ไม่เพียงพอต่อการใช้งาน
- **Fix:** ให้ลองปรับการตั้งค่าตามลิ้งค์นี้ก่อน หากยังไม่ได้ ให้ปรับเพิ่ม
  ค่า Heap Size เป็น Minimum 64M และ Maximum 1024M
- **Verification:** Login เข้า Ignition ใหม่แล้วไม่พบ Error Java Heap Space
  อีก
- **Reference Link:** https://teams.microsoft.com/l/message/19:186ad597609c49b59ca9d8f201c6fd5c@thread.skype/1605233625347?tenantId=5db8bf0e-8592-4ed0-82b2-a6d4d77933d4&groupId=495ad024-62fd-4bec-bd6d-94a0b511cd86&parentMessageId=1605233625347&teamName=Ignition&channelName=General&createdTime=1605233625347
- **Source:** Teams chat, 1/13/20

---

### Entry: OPC Server ของระบบ WHG หายไปจากศูนย์
- **ID:** SA-012
- **Status:** Open — not yet resolved
- **Priority:** M
- **Problem:** ระบบ KW WHG ไม่สามารถใช้งานได้ เนื่องจาก OPC Server ที่เลือก
  เชื่อมต่อไว้ (ที่ศูนย์) หายไป
- **Symptom:** Tag ของ KW WHG ขึ้น Error `Bad_NotConnected` ทั้งระบบ
- **Root Cause:** ยังไม่ทราบสาเหตุ — อยู่ระหว่างตรวจสอบว่าเหตุใด OPC Server
  ที่ศูนย์จึงหายไป
- **Notes:** ยังไม่มีข้อสรุปการแก้ไข ณ เวลาที่บันทึก
- **Source:** Teams chat, 1/13/21

---

### Entry: VCM Plant Ignition/OPC ใช้งานไม่ได้ (สายเชื่อมต่อ DCS-Server มีปัญหา)
- **ID:** SA-013
- **Status:** Closed
- **Priority:** M
- **Problem:** ระบบ Ignition ของ VCM Plant ใช้งานไม่ได้ Tag ทั้งหน้าจอไม่มีค่าหรือขึ้นสีแดง
- **Symptom:** หน้าจอ Ignition ของ VCM Plant ค่า Tag ทั้งหมดขึ้นสถานะ Error
  (ขึ้นสีแดง) ต่อเนื่องหลายวัน; ทีมโรงงานไม่มี User/Password ของ OPC ให้
  ตรวจสอบเพิ่มเติมด้วยตนเอง
- **Root Cause:** สายเชื่อมต่อ (Cable) จาก DCS ไปยังเครื่อง Server Ignition
  มีปัญหา ทำให้ OPC เชื่อมต่อไม่ได้
- **Fix:**
  1. ติดต่อทีม VCM maintenance เพื่อขอตรวจสอบหน้างาน
  2. ตรวจสอบและซ่อมสายเชื่อมต่อ (Cable) จาก DCS ไปยัง Server Ignition
  3. Restart OPC หลังซ่อมสายเสร็จ
- **Verification:** หน้าจอ Ignition ของ VCM Plant กลับมาแสดงค่าปกติ ทีมงาน
  ยืนยันใช้งานได้
- **Source:** Teams chat, 2/26/24

---

### Entry: Ignition TS4/TS5 ดูค่าไม่ได้ — OPC Access Denied จาก OpcEnum (DCOM)
- **ID:** SA-014
- **Status:** Closed
- **Priority:** M
- **Problem:** Ignition มองไม่เห็นค่าจาก OPC DCS ของ TS4 และ TS5
- **Symptom:** หน้า OPC Connections ใน Ignition Gateway ขึ้นสถานะ FAULTED
  สำหรับ TS4/TS5; Error ที่พบคือ `0x80070005; E_ACCESSDENIED (Access is
  denied)` เมื่อ Ignition พยายาม Remote เชื่อมต่อ OPC Server ปลายทาง
- **Root Cause:** Service `OpcEnum` (Windows DCOM) บนเครื่อง OPC Server
  ปลายทาง ไม่รู้จัก/ไม่อนุญาต User Account ที่ Ignition ใช้ Remote เข้ามา
  (ในเคสนี้คือ User "Excellence") ทำให้ Ignition ถูกปฏิเสธการเชื่อมต่อ
- **Fix:**
  1. Remote Desktop เข้าเครื่องที่เป็น OPC Server (เช่น TS4, TS5)
  2. กด Windows+R พิมพ์ `dcomcnfg` แล้ว Enter เพื่อเปิด Component Services
  3. ไปที่ Component Services > Computers > My Computer > DCOM Config
  4. หา `OpcEnum` คลิกขวา > Properties > Tab Security
  5. ที่หัวข้อ "Launch and Activation Permissions" และ "Access Permissions"
     เลือก Customize > Edit > Add > พิมพ์ชื่อ User ที่ Ignition ใช้
     (เช่น "Excellence") > Check Names > OK
  6. เลือกชื่อ User ที่เพิ่ม แล้วติ๊ก Allow ให้ครบทุกช่อง (Local Launch,
     Remote Launch, Local Access, Remote Access) แล้ว OK
  7. ทำซ้ำขั้นตอน 5-6 กับหัวข้อที่เหลือใน Tab Security และแนะนำให้ทำแบบ
     เดียวกันกับ Entry ของโปรแกรม OPC Server จริง (เช่น Yokogawa OPC,
     Kepware) ใน DCOM Config ด้วย เพื่อให้สิทธิ์ครอบคลุม
  8. Apply/OK ปิดหน้าต่างทั้งหมด แล้วกลับไป Refresh หน้า OPC Connections
     ใน Ignition
- **Verification:** สถานะ OPC Connection ของ TS4, TS5 (และ TS6) เปลี่ยนเป็น
  CONNECTED สีเขียวทั้งหมด
- **Source:** Teams chat, 4/22

---

### Entry: วิธีดูสูตรคำนวณ (Expression) เบื้องหลัง Tag
- **ID:** SA-015
- **Status:** Closed
- **Priority:** L
- **Problem:** ต้องการทราบว่า Tag ประเภทคำนวณ (เช่น Total Feed_Cal) มีสูตร
  คำนวณอย่างไร
- **Symptom:** N/A — เป็นคำถามเรื่อง Feature ไม่ใช่ Bug
- **Root Cause:** N/A
- **Fix:** เปิดดู Expression ภายใน Tag ได้โดย (1) Double-click ที่ Tag หรือ
  คลิกขวา > Edit Tag (2) ในช่อง Expression คลิกไอคอนรูปดินสอเพื่อดู
  Expression เต็ม
- **Verification:** เปิด Expression Editor แล้วเห็นสูตรคำนวณของ Tag นั้น
  ครบถ้วน
- **Note:** โปรดระวังอย่าไปแก้ไข Expression เดิมที่มีอยู่โดยเจ้าของ Tag
  ไม่ทราบ
- **Source:** Teams chat, 6/22/20

---

### Entry: Tag TS5 ไม่อัพเดทค่าทั้ง Real-time และ History
- **ID:** SA-016
- **Status:** In Progress
- **Priority:** M
- **Problem:** Tag ของ TS5 ไม่ยอมอัพเดทค่าทั้ง Real-time และ History ข้อมูล
  History หายไปประมาณ 8 ชั่วโมง
- **Symptom:** กราฟ Trend ของ TS5 ค้างไม่ขยับ ทั้งค่าปัจจุบันและข้อมูล
  ย้อนหลัง
- **Root Cause:** ยังไม่สรุปแน่ชัด — อยู่ระหว่างทดสอบแนวทางแก้ไข
- **Fix (แนวทางที่ทดลอง, ยังไม่ยืนยันผล):** ทดลองใช้ Script Function
  `system.opc.setServerEnabled` กับ Tag kiln drive เพื่อ Disable/Enable OPC
  Server แล้วพบว่าใช้ได้ผลในการทดสอบ แต่ยังไม่มั่นใจพอที่จะตั้งให้ทำงาน
  อัตโนมัติ (Auto) หากยังไม่ได้ผล ให้ลองทำตาม Reference Link ด้านล่าง
  ประกอบด้วย
- **Reference Link:** https://docs.inductiveautomation.com/display/DOC81/system.opc.setServerEnabled
- **Source:** Teams chat, 11/13/20

---

### Entry: Dashboard ค้างสถานะ "กำลัง Edit" + Memory ไม่ Release จนกว่าจะ Restart
- **ID:** SA-017
- **Status:** In Progress
- **Priority:** M
- **Problem:** บาง Dashboard จำสถานะว่ามีคนเปิด Edit ค้างอยู่ ทั้งที่ปิด
  Designer ไปแล้ว หาวิธีล้างสถานะนี้ไม่พบ
- **Symptom:** Dashboard ล็อกอยู่ในสถานะ Edit แม้ไม่มี Designer เปิดใช้งาน
  จริง; แยกกันสังเกตว่า Memory ของ Gateway สูงขึ้นเรื่อยๆ (ขึ้น Critical
  Issue: High Memory) และไม่ยอมลดลงเองแม้ปล่อยรันต่อ
- **Root Cause:** ยังไม่ทราบสาเหตุแน่ชัด — สงสัยว่าอาจเกิดจากตอน Windows
  Hang จนต้อง Force Restart Windows ทำให้สถานะ Lock ค้างอยู่ในระบบ
- **Fix (Workaround เท่านั้น ไม่ใช่ Root Cause Fix):** Restart Gateway
  Service (Downtime ประมาณ 3 นาที) ทำให้ Memory ถูก Release กลับมาเป็นปกติ
- **Verification:** หลัง Restart Gateway, Memory ลดลงกลับสู่ระดับปกติ —
  แต่ยังไม่มีวิธียืนยันว่าจะป้องกันไม่ให้เกิดซ้ำ
- **Source:** Teams chat, 12/2/20

---

### Entry: Designer Browse TL Tag ไม่ได้ (ค้างที่ Loading)
- **ID:** SA-018
- **Status:** Open — not yet resolved
- **Priority:** M
- **Problem:** เปิด Designer แล้ว Browse Tag ของ Provider "TL_Tag" ไม่ได้
- **Symptom:** Tag Browser แสดงสถานะ "Loading" ค้างอยู่ใต้ TL_Tag ไม่ขึ้น
  รายการ Tag
- **Root Cause:** ยังไม่ทราบสาเหตุ
- **Fix (ที่ลองแล้วยังไม่สำเร็จ):** ลอง Reset Connection แล้ว ไม่ได้ผล
- **Source:** Teams chat, 12/16/20

---

### Entry: Database Connection สถานะค้างที่ Faulted/Connecting ไม่ยอมเป็น Valid
- **ID:** SA-019
- **Status:** In Progress
- **Priority:** M
- **Problem:** Database Connection ชื่อ "Quality" ใน Ignition ขึ้นสถานะ
  Faulted ไม่ยอมกลับมาเป็น Valid
- **Symptom:** ลอง Disable แล้ว Enable คืนแล้วยังเป็น Faulted เหมือนเดิม;
  ต่อมาสถานะเปลี่ยนเป็น "Connecting" ค้างอยู่ ไม่ยอมเป็น Valid
- **Root Cause:** ยังไม่ทราบสาเหตุแน่ชัด
- **Fix (ที่ลองแล้ว):** ทดลองสร้าง Connection ใหม่บน Gateway เดิม
  (ไม่สำเร็จ); ทดลองสร้าง Connection แบบเดียวกันบน Gateway อื่น (สำเร็จ) —
  ชี้ว่าปัญหาน่าจะเจาะจงที่ Gateway ต้นทาง; อยู่ระหว่างจะลอง Restart
  Service ของ Gateway ต้นทางเพิ่มเติม
- **Source:** Teams chat, 12/31/20

---

### Entry: STS Kiln Shell Scan Pyro Rotor Access Denied เกิดซ้ำบ่อย (Auth Level DCOM ไม่ตรงกัน)
- **ID:** SA-020
- **Status:** In Progress — workaround เท่านั้น
- **Priority:** H
- **Problem:** Kiln Shell Scan TS5, TS6 (Pyro rotor1/rotor2) ต้อง Restart
  Ignition บ่อยเพื่อกู้การเชื่อมต่อ OPC กลับมา
- **Symptom:** Pyro rotor1 (10.28.116.101) และ rotor2 (10.28.116.102) ขึ้น
  Error `0x80070005 (Access is denied)` ตอนที่ Ignition พยายามเชื่อมต่อกลับ
  เป็นระยะ
- **Root Cause:** ฝั่ง OPC Pyro Rotor ตั้งค่า DCOM Auth Level ไว้สูง (Packet
  Integrity) ต่างจาก OPC ตัวอื่นที่ใช้ None ทำให้ทุกครั้งที่มีการเปลี่ยนแปลง
  เกี่ยวกับ Ignition หรือ OPC ตัวใดตัวหนึ่งกระทบกันเอง (rotor1/rotor2 ใช้
  OPC-DA Tunnel ตัวเดียวกัน — `Ttx.OpcDaTunnel.1` — และเสียพร้อมกันเสมอ)
- **Fix (Workaround เท่านั้น):**
  1. เก็บ Event Log (System + Security) ของเครื่อง Pyro เป็น .evtx ไว้ก่อน
     ทุกครั้งที่จะ Restart ซ้ำ (ป้องกันหลักฐานถูกเขียนทับ) และตรวจ Event
     Viewer (Event ID 10016 / 10036 – DistributedCOM) บนเครื่อง OPC ช่วงที่
     OPC หลุด เพื่อยืนยันว่า Application ไหนถูกปฏิเสธสิทธิ์
  2. ปรับ Auth Level DCOM จาก None เป็น Packet Integrity แล้ว Restart
     Ignition (Pyro rotor จะกลับมาต่อได้ แต่ OPC ตัวอื่น เช่น Yogo จะต่อไม่ติด)
  3. ปรับ Auth Level DCOM กลับจาก Packet Integrity เป็น None เหมือนเดิม
     แล้ว Restart Ignition อีกรอบ — OPC ทุกตัวจะกลับมา Connect ได้ปกติ
  (ขั้นตอนข้างต้นมี Manual แยกเรื่องวิธีเปลี่ยน Authen และ Restart Ignition
  TS — หากยังไม่หาย ให้ส่งเรื่องให้ Vendor ตรวจตาม Open items ด้านล่าง)
- **Open items รอ Vendor:** (1) ปรับลด Auth Level ของ Pyro Rotor ให้เป็น
  None แบบถาวรได้หรือไม่ (2) Driver/Software ของ Pyro Rotor
  (Ttx.OpcDaTunnel.1) มีเวอร์ชันใหม่กว่าที่รองรับ Auth Level แบบ None
  หรือไม่
- **Note:** ปัจจุบัน Ignition ที่ TS ใช้ version 8.1 ซึ่งหมดอายุ MA แล้ว จึง
  เปิด Case กับ Inductive Automation โดยตรงไม่ได้ ทีมมีแผน upgrade
  Ignition และต่อ MA ปีหน้า แต่การ upgrade อย่างเดียวจะไม่แก้เคส DCOM นี้
  เพราะต้นเหตุอยู่ที่สิทธิ์การเข้าถึงฝั่ง Windows/OPC ยังต้องแก้ที่ต้นทาง
- **Source:** Teams chat, 8/31 and 9/9

---

### Entry: STS Kiln Shell Scan Pyro Rotor — ตั้งค่าเชื่อมต่อ OPC-UA/OPC-DA ครั้งแรก
- **ID:** SA-021
- **Status:** Open — closed as insufficient information (ยังไม่สรุปผล)
- **Priority:** M
- **Problem:** ต้องการเชื่อมต่อ OPC ของ Kiln Shell Scan Pyro Rotor (STS,
  TS6 rotor1) เข้ากับ Ignition Gateway เป็นครั้งแรก
- **Symptom:** ไม่แน่ใจว่า Pyro Rotor เปิดใช้ OPC-UA (Port 4840) หรือ
  OPC-DA (progID `Ttx.OpcDaTunnel.1`) กันแน่ — ทดสอบ Ping/Port/Telnet
  หลายรอบแต่ผลไม่ชัดเจน
- **Root Cause:** ยังไม่สรุป — Ticket ถูกปิดด้วยเหตุผล "Not enough
  information"
- **Useful reference (ยังไม่ใช่ข้อสรุป):** มี Diagnostic Script (PowerShell)
  สำหรับทดสอบ Reverse Connectivity จากเครื่อง Pyro Rotor ไปยัง Ignition
  Gateway (ping, port scan 4840/4843/62541/8088/8043/135/445, ตรวจ
  Firewall Rule, ตรวจ OPC Service ที่ Listening) — และมี Checklist
  (`Pyro_Rotor_OPC-DA_Complete_Checklist.xlsx`) จากทีมสำหรับให้ Vendor
  กรอกครบก่อนเชื่อมเข้า Ignition
- **Source:** Teams chat, 6/12 (title: "6/12 Test")

---

### Entry: Reconnect Ignition TS4/TS5/TS6, BPT, CFB หลังย้ายจุดวาง Switch Hub
- **ID:** SA-022
- **Status:** Closed
- **Priority:** M
- **Problem:** ย้ายจุดวาง Switch Hub ใหม่แล้ว OPC-DA COM Connection ของ
  TS4/TS5/TS6 (Yoko, Transaction) หลุด ไม่ Reconnect เอง; แยกกันพบว่า OPC
  ของ BPT/CFB ก็ค้างสถานะ CONNECTING เช่นกัน
- **Symptom:** หน้า OPC Connections ขึ้น FAULTED/CONNECTING ค้างสำหรับ
  TS5_Yoko, TS5 (Transaction), TS6_Yoko, TS6 (Transaction); ฝั่ง CFB WHG
  ก็ขึ้น CONNECTING ค้างเช่นกัน (Tag `BF pump 1_Coil_Temp A` ดูค่าไม่ได้)
- **Root Cause:** ไม่สรุปแน่ชัด — สำหรับ TS4/5/6 เกิดจากการย้าย Switch Hub
  ทำให้ Gateway Network ระหว่าง MES กับ OPC หลุด; สำหรับ BPT/CFB ทีมงาน
  พบว่ากลับมา Connect เองหลังทีมไฟฟ้า Restart OPC โดยไม่มีการแก้ไข
  Configuration ใดๆ ฝั่ง Ignition (ทั้ง Gateway EC และเครื่อง MES Local TS)
- **Fix:**
  1. Restart Service ของ Ignition และ Reconnect Gateway Network ระหว่าง
     MES กับ OPC เพื่อฟื้นฟูการเชื่อมต่อ
  2. สำหรับ BPT/CFB ให้ทีมไฟฟ้าเข้าไป Restart OPC เพื่อให้ระบบ Reconnect
     ใหม่
- **General troubleshooting checklist (สรุปจาก Case นี้ สำหรับใช้ครั้งต่อไป):**
  กรณีที่มีการ Switch Network Hub / Network Down หรือปัจจัยอื่น เช่น
  Network Latency/Packet Loss สูงผิดปกติ, Firewall/Port ถูก Block หรือ
  เปลี่ยน Policy, PLC/OPC Server มีการ Restart, IP/Routing เปลี่ยนแปลง,
  Load ของ Network/OPC สูงผิดปกติ — อาจทำให้ OPC Connection หลุดเป็น
  Faulted/Disconnected, OPC Session Reset ทำให้ Tag คุณภาพเป็น Bad/Stale,
  หรือ Endpoint/Route ไปยัง PLC เปลี่ยน ต้องไล่ตรวจสอบทีละจุดตามรายการนี้
- **Verification:** TS5, TS6, BPT, CFB กลับมาแสดงสถานะ CONNECTED ปกติ
- **Source:** Teams chat, 5/6

---

### Entry: SKW Trend Graph ไม่ Update — DB IP เปลี่ยน
- **ID:** SA-023
- **Status:** Closed
- **Priority:** M
- **Problem:** SKW Trend graph ไม่ Update ตั้งแต่วันที่ 9/6
- **Symptom:** กราฟ RM2 Performance Monitoring ค้างไม่ขยับตั้งแต่ 9/6; Error
  `java.sql.SQLException: Cannot create PoolableConnectionFactory
  (Communications link failure)`
- **Root Cause:** Database Connection `KW_DB` เชื่อมต่อไม่ได้ที่ EC เนื่องจาก
  JDBC URL ยังชี้ไป IP เดิม (`10.28.0.130`) ขณะที่ Database ย้ายไปที่ IP
  ใหม่ (`10.28.0.136`)
- **Fix:** แก้ไข JDBC URL ของ Database Connection `KW_DB` จาก
  `jdbc:mysql://10.28.0.130:3306/kw_db` เป็น
  `jdbc:mysql://10.28.0.136:3306/kw_db`
- **Verification:** กราฟสามารถกลับมาดูได้ปกติ
- **Source:** Teams chat, 6/12 SKW

---

### Entry: Ad-hoc Trend Chart (kw-mes:kw_tag) เปิดดูค่าไม่ได้ — Script addPen แบบ Fixed Column
- **ID:** SA-024
- **Status:** Closed
- **Priority:** M
- **Problem:** เปิด Trend ของ `kw-mes:kw_tag` ผ่าน Adhoc แล้วดูค่าไม่ได้
- **Symptom:** กราฟ Trend ไม่ขึ้นข้อมูลเลยเมื่อเปิดผ่าน Adhoc (ทั้งผ่าน COE
  และ SKW_PRO)
- **Root Cause:** Script `addPen` ที่ใช้เพิ่ม Pen เข้ากราฟเดิมอ้างอิง Column
  แบบ Fixed (ตายตัว) ซึ่งไม่ตรงกับ Column จริงของ Dataset ที่เปลี่ยนไป
- **Fix:** แก้ Script `addPen` จากอ้างอิง Column แบบ Fixed ให้เป็นแบบ
  Dictionary ที่อ่านชื่อ Column จริงจาก Dataset โดยตรง
- **Verification:** เปิด Trend ผ่าน Adhoc แล้วกราฟขึ้นข้อมูลปกติ (ทดสอบกับ
  Tag Mill drive_Amp, Mill drive_Power, Mill Bearing-In Temp 1 พร้อมกัน)
- **Source:** Teams chat, 6/19

---

### Entry: STS Tag WHG ขึ้น bad_connected ทั้งที่ OPC Connection ปกติ
- **ID:** SA-025
- **Status:** Closed
- **Priority:** M
- **Problem:** Tag ของ WHG ดูค่าไม่ได้ (bad_connected) แม้ OPC-DA COM
  Connection (TS4_Yoko, TS456 WHG, TS4 (Transaction)) จะขึ้นสถานะ
  CONNECTED ปกติ และค้นหา Tag ใน OPC Browser ก็ขึ้นปกติ
- **Symptom:** ทีมไฟฟ้า Restart OPC WHG ไปแล้ว 2 ครั้งก่อนหน้า อาการยังคง
  อยู่ ฝั่ง OPC ยืนยันว่าไม่ได้ปรับเปลี่ยนอะไร
- **Root Cause:** ไม่ทราบสาเหตุแน่ชัด — อาการหายไปเองหลังรอ/Restart อีก
  รอบ ไม่มีการเปลี่ยน Configuration ใดๆ ที่พบ
- **Fix:** Restart OPC WHG (ครั้งที่ 3) แล้วรอสักครู่ อาการหาย
- **Verification:** ทีมยืนยันว่าใช้งานได้ปกติแล้ว
- **Source:** Teams chat, 6/23

---

### Entry: TS_Acoem Nesti4_Vibratag ข้อมูลจาก OPC มาไม่ต่อเนื่อง
- **ID:** SA-026
- **Status:** Open — not yet resolved
- **Priority:** M
- **Problem:** ข้อมูลค่า Vibration จาก OPC "TS_Acoem Nesti4_Vibratag"
  (เช่น Tag `[TS_Tag]MRO/RM6/Vibration_sparrow/...Ax_overall_velo`) มาไม่
  ต่อเนื่อง
- **Symptom:** ค่าที่ดึงเข้ามาขาดช่วงเป็นระยะ ไม่สม่ำเสมอ
- **Root Cause:** ยังไม่สรุป — อยู่ระหว่างพิจารณาออกแบบ Architecture ใหม่
  สำหรับการดึงค่า
- **Fix:** ยังไม่มี — ส่งต่อให้ทีม cc-room ช่วยออกแบบวิธีดึงค่า (Set
  Architecture) เพิ่มเติม
- **Source:** Teams chat, 8/11

---

### Entry: kw_tag Historian ที่ kw-mes:kw_tag แสดงเฉพาะ Storage Provider Poceidon
- **ID:** SA-027
- **Status:** Closed (วิธีแก้เบื้องต้น)
- **Priority:** L
- **Problem:** ใน kw Tag มี Folder MA Online, Poceidon และ Matrix Medium
  Volt แต่พอไปดูที่ Tag Historian ผ่าน `kw-mes:kw_tag` เห็นข้อมูลเฉพาะกลุ่ม
  Poceidon เท่านั้น
- **Symptom:** Tag กลุ่ม MA Online และ Matrix Medium Volt ไม่ปรากฏใน
  Adhoc Trend ที่เรียกผ่าน kw-mes:kw_tag
- **Root Cause (พบบางส่วน):** แต่ละ Tag ตั้งค่า Storage Provider ไม่ตรงกัน
  — MA Online ส่วนใหญ่เก็บที่ `MRO_ML_EIS` แต่ Poceidon เก็บที่
  `KW_Splitter` (ซึ่งเป็นตัวที่แสดงผลที่ kw-mes:kw_tag) ยังไม่แน่ใจว่าตั้ง
  ค่าแบบนี้มาตั้งแต่แรกหรือไม่; ส่วน Tag กลุ่ม Matrix Medium Motor พบว่า
  History Enabled = false ตั้งแต่ต้น จึงไม่ใช่ Bug แต่เป็นเพราะไม่เคยตั้งค่า
  ให้เก็บ History ไว้เลย
- **Fix (เบื้องต้น):**
  1. ตั้งค่า Storage Provider ให้ตรงกันในแต่ละ Tag
  2. เปลี่ยน History Enabled เป็น true เพื่อให้เก็บข้อมูลย้อนหลังได้
  3. ถ้า Tag ขึ้น Bad_NotConnected หรือไม่แสดงกราฟ ให้ลอง Restart server
- **Source:** Teams chat, 9/16

---

### Entry: KW Power Meter Tag ขึ้น Bad_NotConnected + Tag Historian ดูได้ทีละกราฟ
- **ID:** SA-028
- **Status:** Closed
- **Priority:** M
- **Problem:** ต้องการดูกราฟหลาย Tag ของ kw powermeter ใน Tag Historian
  พร้อมกัน แต่ดูได้เพียงกราฟเดียว
- **Symptom:** เมื่อตรวจสอบ Tag Browser ของกลุ่ม `KW_PowerMeter_Tag` (เช่น
  202_RECLAIMER) พบว่า Tag จำนวนมากขึ้นสถานะ `Bad_NotConnected` เฉพาะ
  กลุ่ม Power Meter เท่านั้น กลุ่ม Tag อื่นปกติดี
- **Root Cause:** สงสัยว่าเป็นปัญหาฝั่ง Server ที่ให้ค่า Tag กลุ่ม Power
  Meter
- **Fix:** Restart ระบบ/Service ที่เกี่ยวข้องฝั่ง Server
- **Verification:** หลัง Restart, Tag กลุ่ม Power Meter กลับมาแสดงค่าปกติ
  และสามารถดู Tag Historian หลาย Pen พร้อมกันได้ตามปกติ (ทดสอบกับ
  amp-n, amp(avr), amp-p2, value พร้อมกัน 4 เส้น)
- **Source:** Teams chat, 9/16

---

### Entry: EIS Tag ดูค่าใน EC ไม่ได้ — Remote Gateway "eis_ignition" Shutdown
- **ID:** SA-029
- **Status:** Closed
- **Priority:** M
- **Problem:** ดูค่า Tag กลุ่ม EIS_Tag ผ่าน EC ไม่ได้ (เกิดซ้ำหลายครั้ง)
- **Symptom:** ครั้งแรกแก้ด้วยการ Browse Tag ผ่าน All Providers ตามปกติ
  แต่อาการกลับมาอีก; ตรวจสอบหน้า Gateway Network พบว่า Remote Gateway
  ชื่อ `eis_ignition` ขึ้นสถานะ Shutdown ขณะที่ Gateway อื่นทั้งหมด Running
  ปกติ
- **Root Cause:** ฝั่ง EIS (Gateway/Server ต้นทาง) ปิดหรือหยุดทำงานอยู่
- **Fix:** แจ้งทีม EIS ให้ตรวจสอบและเปิด Gateway/Server ฝั่งตนเองกลับมา
  ทำงาน พร้อมให้ทดสอบ Ping เข้าเครื่อง EIS
- **Verification:** ค่าจาก EIS Tag กลับมาแสดงผลปกติที่ EC — หมายเหตุ: หน้า
  Gateway Network ของ EC อาจยังคงแสดงสถานะไม่ Connected ต่อไปสักพักแม้
  ข้อมูลจริงจาก EIS DB จะดึงได้แล้ว (เป็นคนละ Layer ของการเชื่อมต่อ) จึง
  ควรเช็คทั้งสถานะ Gateway Network และการดึงค่าจริงแยกกัน
- **Note:** ข้อมูลบางค่าจาก EIS ถูกส่งกลับไปที่ระบบ DCS ด้วย เพื่อให้
  Operator ดูค่า Condition ของเครื่องจักรบางตัว
- **Source:** Teams chat, 8/31 (2)
