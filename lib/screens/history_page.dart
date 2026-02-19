import 'package:flutter/material.dart';
import 'home_page.dart';

class HistoryPage extends StatelessWidget {
  final List<Medicine> history;

  const HistoryPage({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 80, color: Colors.grey),
            SizedBox(height: 12),
            Text('ยังไม่มีประวัติการทานยา'),
            Text('เริ่มบันทึกการทานยาวันนี้'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final medicine = history[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              medicine.status == "taken"
                  ? Icons.check_circle
                  : Icons.cancel,
              color: medicine.status == "taken"
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text(medicine.name),
            subtitle: Text("${medicine.dose} • ${medicine.time}"),
            trailing: Text(
              medicine.status == "taken" ? "ทานแล้ว" : "ข้าม",
              style: TextStyle(
                color: medicine.status == "taken"
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
