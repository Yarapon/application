import 'package:flutter/material.dart';
import 'home_page.dart';

class MedicineListPage extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(int) onDelete;
  final Function(int, Medicine) onUpdate;

  const MedicineListPage({
    super.key,
    required this.medicines,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: medicines.isEmpty
            ? const Center(child: Text("ยังไม่มีรายการยา"))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// ข้อมูลยา
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${medicine.dose} • ${medicine.time}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        /// ปุ่มแก้ไข + ลบ
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blue),
                              onPressed: () {
                                _showEditDialog(
                                    context, medicine, index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                onDelete(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, Medicine medicine, int index) {
    final nameController =
        TextEditingController(text: medicine.name);
    final doseController =
        TextEditingController(text: medicine.dose);
    final timeController =
        TextEditingController(text: medicine.time);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("แก้ไขยา"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController),
            TextField(controller: doseController),
            TextField(controller: timeController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ยกเลิก"),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedMedicine = Medicine(
                name: nameController.text,
                dose: doseController.text,
                time: timeController.text,
              );

              onUpdate(index, updatedMedicine);
              Navigator.pop(context);
            },
            child: const Text("บันทึก"),
          ),
        ],
      ),
    );
  }
}
