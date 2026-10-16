# Integration Issues

Covers connections to external systems, meters, and APIs feeding data into
plant reports/dashboards.

---

### Entry: Solar meter API not feeding data into Auto Daily WHG report
- **ID:** IN-001
- **Status:** Open — not yet resolved
- **Priority:** M
- **Notes:** Ignition's API connection to the Solar Down system isn't
  pulling several Solar Tree meter parameters (Total Real Energy Delivered/
  Consumed, for both Main and Floating meters across SKW1_2 and SKW3) into
  the Auto Daily WHG report. Standardization work was in progress as of
  mid-February; steps tried so far include checking the Ignition connection
  and restarting the source server at KW, but the current server owner
  wasn't identified at time of writing. See `open-issues.md`
  (Issued_Log #1) — move here once resolved.

---

### Entry: เชื่อมต่อ OPC UA DeviceXplorer Server 7 กับ Ignition (โรงงานเขาวง)
- **ID:** IN-002
- **Status:** Closed
- **Priority:** M
- **Problem:** ต้องการเชื่อมต่อ OPC UA DeviceXplorer Server 7 (ติดตั้งบน
  เครื่อง Server Cogen Datahub เดิม) เข้ากับ Ignition เพื่อให้ Ignition
  Designer มองเห็นและ Add Tag จาก OPC UA DeviceXplorer ได้
- **Symptom:** หลัง Add OPC UA Connection ใน Ignition แล้ว เจอ Error
  `ConnectTimeoutException: connection timed out` และสถานะ OPC Connection
  ขึ้น FAULTED; ต่อมาแม้แก้ปัญหา Network/Port แล้วก็ยังมองไม่เห็น Tag
- **Root Cause:** (1) เบื้องต้น Endpoint/Port ของ OPC UA Server ปลายทาง
  ตั้งค่าไม่ตรงกับที่ Ignition พยายามเชื่อมต่อ และ (2) หลังแก้ปัญหาแรกแล้ว
  พบว่า Checkbox "Enable OPC UA Server" ในหน้า IoT Interface Property ของ
  DeviceXplorer ไม่ได้ถูก Save ไว้ก่อน Restart เครื่อง ทำให้ค่าเด้งกลับไป
  ปิดอยู่
- **Fix:**
  1. เพิ่ม OPC UA Connection ใน Ignition โดยใช้ IP ของเครื่อง Server
     (Cogen Datahub เดิม)
  2. Trust OPC UA Certificate
  3. Browse Tag จาก DeviceXplorer ผ่านหน้า Connected Devices ใน Ignition
     Gateway แล้ว Import เข้า Provider ที่ต้องการ
  4. แก้ OPC Path ของ Tag จาก OPC DA ให้เป็น OPC UA
  5. ในหน้า IoT Interface ของ DeviceXplorer ให้ติ๊ก Enable OPC UA Server
     แล้วกด Apply/OK ให้เรียบร้อยก่อน Restart เครื่องทุกครั้ง เพื่อไม่ให้
     ค่าเด้งกลับไปปิด
- **Verification:** ฝั่ง Ignition ขึ้นสถานะ Connected และมองเห็น Tag จาก
  DeviceXplorer OPC Server ครบถ้วน
- **Source:** Teams chat, 3/24

---

### Entry: เชื่อมต่อ Ignition กับ PostgreSQL ระยะไกล (Oil Moisture CM2 เขาวง)
- **ID:** IN-003
- **Status:** Closed
- **Priority:** M
- **Problem:** ต้องการให้ Ignition ดึงข้อมูลจากเครื่องวัด Oil Moisture CM2
  ที่โรงงานเขาวง (Database บนเครื่อง OPC IP `172.31.105.30`) มาแสดงที่
  Ignition (IP `10.28.0.142`) เพื่อทำ Dashboard — ทั้งสองเครื่องอยู่คนละ
  วง Network (`172.31.x.x` กับ `10.28.x.x`)
- **Symptom:** เชื่อมต่อไม่ได้หลายรอบ พบ Error `java.net.SocketTimeoutException:
  Connect timed out` และ `SocketTimeoutException` ระหว่างพยายาม Connect
- **Root Cause:** หลายชั้นรวมกัน — (1) PostgreSQL (ไม่ใช่ Microsoft SQL)
  ยังไม่เปิด Remote Access (2) Windows Firewall ทั้ง Inbound/Outbound ของ
  เครื่องปลายทางยังไม่เปิด Port 5432 (3) Firewall ระดับ Network ระหว่างสอง
  วงยังไม่ได้ Allow Port 5432 ข้ามวง (4) `pg_hba.conf` ต้องระบุ IP ต้นทาง
  ที่ Connect เข้ามาจริง (ไม่ใช่ IP ของเครื่อง Ignition ที่คาดไว้แต่แรก แต่
  เป็น IP ของ EC Ignition Server ที่ Query จริง) และ Auth Method ต้องตรง
  กับเวอร์ชัน PostgreSQL (md5 หรือ scram-sha-256)
- **Fix:**
  1. ยืนยันข้อมูลเบื้องต้น: ชนิด Database (Microsoft SQL / MySQL /
     PostgreSQL — เคสนี้คือ PostgreSQL, Port 5432), Firewall ฝั่ง
     `172.31.105.30` เปิด Port ให้ MES วิ่งเข้ามาได้หรือยัง, และ Database
     เปิด Remote Access แล้วหรือยัง (SQL Server: เปิด "Allow Remote
     Connections" + TCP/IP ใน SQL Server Configuration Manager; PostgreSQL:
     ทำตามขั้นตอนใน 2-3 ด้านล่าง)
  2. เปิด Remote Access ของ PostgreSQL (PostgreSQL ไม่มี SQL Server
     Configuration Manager ต้องแก้ไฟล์ Config บนเครื่องปลายทาง — ควรให้ IT
     เช็คก่อนว่าติด Policy หรือไม่):
     - `postgresql.conf` (เช่น `C:\Program Files\PostgreSQL\13\data`): ตั้ง
       `listen_addresses = '*'` และลบ `#` ด้านหน้าออก แล้ว Save
     - `pg_hba.conf` (โฟลเดอร์เดียวกัน): เพิ่มบรรทัดท้ายไฟล์
       `host all all <ip ต้นทางจริง>/32 md5` (เวอร์ชันใหม่ใช้
       `scram-sha-256` แทน `md5`) แล้ว Save
  3. Restart PostgreSQL Service (Windows+R → `services.msc` → หา
     `postgresql...` → คลิกขวา → Restart)
  4. เปิด Windows Firewall Inbound และ Outbound Port 5432 บนเครื่อง
     ปลายทาง (172.31.105.30)
  5. ให้ทีม Network/IT (IT-One) Allow Port 5432 ข้ามวง Network ระหว่าง
     `10.28.x.x` กับ `172.31.x.x` — ทดสอบด้วย
     `Test-NetConnection <IP ปลายทาง> -Port 5432` จากเครื่อง Ignition
  6. เมื่อ Connect ผ่านระดับ Network แล้วแต่ยังไม่เห็น Table ใน Designer
     ให้เช็ค IP ต้นทางจริงที่ Query เข้ามา (ดูจาก Error/Log) แล้วปรับ
     `pg_hba.conf` ให้ตรงกับ IP นั้น (ในเคสนี้คือ IP ของ EC Ignition
     Server `172.18.9.17` ไม่ใช่ IP `10.28.0.142` ที่คาดไว้แต่แรก) แล้ว
     Restart Service อีกครั้ง
  7. หลัง Connect และเห็น Table แล้ว ต้องสร้าง Query ผูกกับ Database
     Connection นี้ในหน้า Vision/Perspective เพื่อดึงค่ามาแสดงเป็น Dashboard
     (ไม่ใช่ Tag/Historian ปกติ)
- **Verification:** Designer เห็น Table ของ Database ครบถ้วน และดึงข้อมูล
  Oil Moisture มาใช้ทำ Dashboard ได้สำเร็จ
- **Source:** Teams chat, 4/23 (ต่อเนื่องถึง 5/6)

---

### Entry: ThingsBoard Cloud API — Tag Air Compressor ไม่ Update (Proxy หลุด)
- **ID:** IN-004
- **Status:** Closed (เกิดซ้ำได้ — ดูหมายเหตุ)
- **Priority:** M
- **Problem:** ข้อมูล Tag Air Compressor ที่ดึงผ่าน ThingsBoard Cloud API
  ไม่ Update (ปกติ Update ทุก 3 นาที)
- **Symptom:** Script เรียก API ไปที่ ThingsBoard แล้วได้ Response เป็น
  Null ทำให้ Script Error (`NullPointerException`); อาการเกิดพร้อมกันกับ
  API อีกเส้นของโรงงานเวียดนาม (VCM) ในเวลาเดียวกัน
- **Root Cause:** Proxy สำหรับ Internet ขาออกของ Server หลุด/ดิสคอนเน็กต์
  ไม่ใช่ปัญหาที่ฝั่ง ThingsBoard (ทดสอบด้วย Postman แล้วปกติ, ทาง
  ThingsBoard ก็ยืนยันว่าระบบปกติ) — การที่ 2 API หลุดพร้อมกันจึงชี้ไปที่
  จุดร่วมคือ Network/Proxy ขาออกของ Server ฝั่งเรา ไม่ใช่ปลายทาง
- **Fix:**
  1. ทดสอบเรียก API ด้วย Postman จากภายนอก ถ้าปกติแสดงว่าปัญหาไม่ได้อยู่ที่
     ThingsBoard
  2. เช็คว่า API อื่นบน Server เดียวกัน (เช่น VCM เวียดนาม) หลุดพร้อมกัน
     หรือไม่
  3. ตรวจสอบและแก้ไข Proxy ขาออก Internet ของ Server ให้กลับมาเชื่อมต่อได้
- **Verification:** ข้อมูลเริ่ม Update กลับมาเป็นปกติหลังแก้ Proxy
- **Note:** อาการเดิมเกิดซ้ำอีกครั้งในภายหลัง (ตั้งแต่ 14/6) และแก้ไขด้วย
  วิธีเดียวกัน — หากเกิดอีก ให้ตรวจ Proxy ขาออกของ Server เป็นจุดแรก
- **Source:** Teams chat, 5/18

---

### Entry: Zycoda API Endpoint เปลี่ยน URL — Tag ดึงข้อมูลไม่ได้
- **ID:** IN-005
- **Status:** Closed
- **Priority:** M
- **Problem:** ระบบ Zycoda (ML/Analytics ภายนอก) ต้องการดึงข้อมูลย้อนหลัง
  อย่างน้อย 3 เดือน แต่ดึงข้อมูล Tag จาก Ignition ไม่ได้/ข้อมูลแปลกๆ ใน
  บางช่วงเวลา
- **Symptom:** ถ้า Query ย้อนหลังไกลเกิน ~15 วัน หรือช่วงก่อนวันที่ 15
  มิถุนายน จะไม่เห็นข้อมูลเลย; ทดสอบดึง Tag บางช่วงวันที่ (1-30/5) ได้
  Error ไม่มีข้อมูล แต่ช่วงใกล้ปัจจุบัน (14-27/6, 2-27/6) ดึงได้ปกติ —
  ตรวจสอบเพิ่มเติมพบ Tag กลุ่ม EIS ดึงผ่าน EC ได้ปกติ (เพราะ EC Remote
  จาก EIS มา ใช้ API เส้นเดียวกัน)
- **Root Cause:** สองส่วนรวมกัน — (1) API เดิมดึงข้อมูลจาก `EC_DB` ซึ่งมี
  Retention จำกัด (เก็บข้อมูลย้อนหลังได้ไม่นาน ~15 วัน) ทำให้ Query ย้อน
  หลังไกลกว่านั้นไม่เจอข้อมูล ต้องดึงจาก `TS_DB` (Database ระดับไซต์ที่มี
  Retention ยาวกว่า) แทนสำหรับช่วงเวลาที่เก่ากว่านั้น (2) URL API ที่ทาง
  Zycoda เรียกใช้เป็น URL เก่า/ไม่เสถียร
  (`http://10.100.12.83:8088/system/ws/rest/regional/ML_call_tagname_last`)
- **Fix:**
  1. ปรับ API ให้ดึงข้อมูลย้อนหลังจาก `TS_DB` แทน `EC_DB` สำหรับ Query
     ช่วงเวลาที่เก่ากว่า Retention ของ EC_DB
  2. เปลี่ยน URL API ที่ Zycoda เรียกใช้ และเปลี่ยน Path การ Query Tag ของ
     แต่ละที่ — ใช้ `https://cemt-bsmesec01.scg.com:8043/system/ws/rest/regional/ML_call_tagname`
     แทน `http://10.100.12.83:8088/system/ws/rest/regional/ML_call_tagname_last`
     ส่วน Path การ Query Tag ขึ้นกับว่า Tag นั้นตั้งค่า Storage Provider ไว้ที่ไหน
     (ตัวอย่างรูปแบบ Tag ที่ใช้ใน Zycoda: `[ts_db/ts:ts_tag]ts6/misc/pan conv1_amp`)
- **Verification:** ทดสอบดึงข้อมูลย้อนหลังจาก Zycoda ใช้งานได้ปกติแล้ว
  ทั้งช่วงเวลาใหม่และเก่า (มี Tag ใช้งานอยู่ที่ Zycoda ขณะนั้นประมาณ
  2,268 Tag)
- **Source:** Teams chat, 6/29 (ต่อเนื่องถึง 6/30)
