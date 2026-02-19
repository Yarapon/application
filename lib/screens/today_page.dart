import 'package:flutter/material.dart';
import 'home_page.dart';

class TodayPage extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(int) onTaken;
  final Function(int) onSkipped;
  final Function(int) onDelay;

  const TodayPage({
    super.key,
    required this.medicines,
    required this.onTaken,
    required this.onSkipped,
    required this.onDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: medicines.isEmpty
            ? const Center(child: Text("ยังไม่มียาวันนี้"))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text("${medicine.dose} • ${medicine.time}"),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  onTaken(index);
                                },
                                child: const Text("ทานแล้ว"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {
                                  onDelay(index);
                                },
                                child: const Text("เลื่อน"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                onPressed: () {
                                  onSkipped(index);
                                },
                                child: const Text("ข้าม"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
