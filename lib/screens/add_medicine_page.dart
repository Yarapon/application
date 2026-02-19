import 'package:flutter/material.dart';
import 'home_page.dart';

class AddMedicinePage extends StatefulWidget {
  final Function(Medicine) onAdd;

  const AddMedicinePage({super.key, required this.onAdd});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "เพิ่มยา",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              _buildTextField(nameController, "ชื่อยา"),
              const SizedBox(height: 20),

              _buildTextField(doseController, "จำนวน / ขนาด"),
              const SizedBox(height: 20),

              _buildTextField(timeController, "เวลา (เช่น 08:00)"),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2979FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    try {
                      if (nameController.text.trim().isEmpty ||
                          doseController.text.trim().isEmpty ||
                          timeController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("กรุณากรอกข้อมูลให้ครบ"),
                          ),
                        );
                        return;
                      }

                      final newMedicine = Medicine(
                        name: nameController.text.trim(),
                        dose: doseController.text.trim(),
                        time: timeController.text.trim(),
                      );

                      widget.onAdd(newMedicine);
                    } catch (e) {
                      debugPrint("ERROR: $e");
                    }
                  },
                  child: const Text(
                    "บันทึกข้อมูล",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: "กรอก$label",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        // กรอบปกติ
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),

        // ตอนกดเลือก (โฟกัส)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF2979FF), width: 2),
        ),

        // กรอบ default
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    doseController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
