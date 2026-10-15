# Network & Infrastructure Issues

Covers server, hardware, and network outages affecting plant systems.

---

### Entry: Ignition server down — hard disk / RAID failure (Lampang site)
- **ID:** NI-001
- **Status:** Closed
- **Priority:** H
- **Problem:** The Ignition server at the Lampang site went down, cutting off
  live process monitoring.
- **Symptom:** Ignition screens inaccessible on desktop and mobile; repair
  team lost visibility into Vibration readings; LAB team lost visibility into
  process parameters (had to walk to Operations to ask directly); Engineering
  and other users lost their usual production-monitoring view.
- **Root Cause:** Server hard disk failure combined with RAID array failure.
- **Fix:**
  1. Source a spare server and do a fresh Windows install (IT).
  2. Install the spare server at CCR to replace the failed unit.
  3. Have the DX team remotely install Ignition on the new server.
  4. Restore Ignition parameters/configuration from the central backup.
  5. Note: replacing the physical machine may require the overseas vendor to
     reactivate the Ignition license — expected to be covered under the
     maintenance agreement (MA).
- **Verification:** Confirm Ignition is reachable again on desktop and
  mobile, and that restored parameters match the pre-outage backup.
- **Estimated resolution time:** Same weekend as the outage.
- **Source:** Issued_Log #2, Feb 2026.

---

### Entry: Ignition ไม่เก็บค่า Historical เนื่องจาก Disk เต็ม
- **ID:** NI-002
- **Status:** Closed
- **Priority:** M
- **Problem:** Ignition ไม่เก็บค่า Historical ทำให้ดู Trend ย้อนหลังไม่ได้
  เริ่มมีอาการตั้งแต่วันที่ 14/4
- **Symptom:** กราฟ Trend ของหลาย Tag ไม่มีข้อมูลในช่วงเวลาที่เกิดปัญหา
- **Root Cause:** Disk ของเครื่อง EC เต็ม ทำให้ Ignition ไม่สามารถเขียน
  ข้อมูล Historical ลงได้
- **Fix:**
  1. เช็คพื้นที่ว่างของ Disk บนเครื่อง EC
  2. เคลียร์พื้นที่ Disk ที่เต็มอยู่
- **Verification:** หลังเคลียร์ Disk ข้อมูลบาง Tag เริ่มไหลกลับเข้ามา —
  ข้อมูลจะทยอย Flush เข้าระบบตามคิว ไม่ได้กลับมาเป็นปัจจุบันทันที ควรรอ
  เวลาให้คิวข้อมูลไล่ทันก่อนสรุปผล
- **Source:** Teams chat, 4/16

---

### Entry: Gateway LP ดู Realtime/History/Browse Tag ไม่ได้ (Error deserializing data)
- **ID:** NI-003
- **Status:** Open — not yet resolved
- **Priority:** M
- **Problem:** ดูข้อมูล Realtime, History data และ Browse Tag ของ Gateway LP
  ไม่ได้ ทั้งฝั่ง Client และ Designer
- **Symptom:** Error log ใน Web service ของ Gateway LP ขึ้น "Error
  deserializing data from data store" ซ้ำต่อเนื่องไม่หยุด
- **Root Cause:** ยังไม่ทราบสาเหตุแน่ชัด — จาก Error log ใน Web service ของ
  Gateway LP พบข้อความ "Error deserializing data from data store" เกิดขึ้น
  ซ้ำๆ ต่อเนื่องไม่ยอมหยุด
- **Fix (ที่ลองแล้วยังไม่สำเร็จ):** ลอง Reset Gateway Network และ Restart
  Network แล้ว (มีโอกาสที่อาการยังไม่ฟื้นทันที ให้ลองอีกครั้งหลังจากนั้น)
- **Source:** Teams chat, 11/3/20
