import 'package:flutter/material.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool soundEnabled = true;
  double snoozeMinutes = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ตั้งค่า",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// 🔊 เสียงแจ้งเตือน
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SwitchListTile(
                  value: soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      soundEnabled = value;
                    });
                  },
                  title: const Text("เสียงแจ้งเตือน"),
                  subtitle: const Text("เปิด/ปิดเสียงเมื่อถึงเวลาทานยา"),
                  secondary: const Icon(Icons.volume_up, color: Colors.blue),
                ),
              ),

              const SizedBox(height: 15),

              /// ⏱ เวลาเลื่อนแจ้งเตือน
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            "เวลาเลื่อนการแจ้งเตือน",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Slider(
                        value: snoozeMinutes,
                        min: 5,
                        max: 60,
                        divisions: 11,
                        label: "${snoozeMinutes.toInt()} นาที",
                        onChanged: (value) {
                          setState(() {
                            snoozeMinutes = value;
                          });
                        },
                      ),
                      Center(
                        child: Text(
                          "${snoozeMinutes.toInt()} นาที",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔔 การแจ้งเตือน
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notifications, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            "การแจ้งเตือน",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("• แจ้งเตือนก่อนถึงเวลา 5 นาที"),
                      Text("• แจ้งเตือนเมื่อถึงเวลาทานยา"),
                      Text("• แจ้งเตือนหากยังไม่ได้ทานภายใน 30 นาที"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// ℹ️ เกี่ยวกับแอป
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(
                            "เกี่ยวกับแอป",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("แอปเตือนทานยา"),
                      Text("เวอร์ชัน 1.0.0"),
                      SizedBox(height: 10),
                      Text(
                        "แอปนี้ช่วยแจ้งเตือนเวลาทานยา และบันทึกประวัติการทานยา",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🚪 ออกจากระบบ
              /// 🚪 ออกจากระบบ
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "ออกจากระบบ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("ยืนยันออกจากระบบ"),
                        content: const Text("คุณต้องการออกจากระบบใช่หรือไม่?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("ยกเลิก"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // ปิด dialog

                              // 🔥 ไปหน้า Login และล้าง stack ทั้งหมด
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "ออกจากระบบ",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
