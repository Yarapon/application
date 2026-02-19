import 'package:flutter/material.dart';
import 'today_page.dart';
import 'add_medicine_page.dart';
import 'medicine_list_page.dart';
import 'history_page.dart';
import 'settings_page.dart';

class Medicine {
  String name;
  String dose;
  String time;
  String status; // pending, taken, skipped

  Medicine({
    required this.name,
    required this.dose,
    required this.time,
    this.status = "pending",
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Medicine> medicines = [];
  List<Medicine> history = [];

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void addMedicine(Medicine medicine) {
    setState(() {
      medicines.add(medicine);
    });
  }

  void deleteMedicine(int index) {
    setState(() {
      medicines.removeAt(index);
    });
  }

  void updateMedicine(int index, Medicine newMedicine) {
    setState(() {
      medicines[index] = newMedicine;
    });
  }

  void markAsTaken(int index) {
    setState(() {
      medicines[index].status = "taken";
      history.add(medicines[index]);
      medicines.removeAt(index);
    });
  }

  void markAsSkipped(int index) {
    setState(() {
      medicines[index].status = "skipped";
      history.add(medicines[index]);
      medicines.removeAt(index);
    });
  }

  void delayMedicine(int index) {
    setState(() {
      final timeParts = medicines[index].time.split(":");
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      minute += 30;
      if (minute >= 60) {
        hour += 1;
        minute -= 60;
      }

      medicines[index].time =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TodayPage(
        medicines: medicines,
        onTaken: markAsTaken,
        onSkipped: markAsSkipped,
        onDelay: delayMedicine,
      ),
      AddMedicinePage(
        onAdd: (medicine) {
          addMedicine(medicine);
          changeTab(0);
        },
      ),
      MedicineListPage(
        medicines: medicines,
        onDelete: deleteMedicine,
        onUpdate: updateMedicine,
      ),
      HistoryPage(history: history),
      const SettingsPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2979FF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 10,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "วันนี้"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "เพิ่มยา"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "รายการ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "ประวัติ",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ตั้งค่า"),
        ],
      ),
    );
  }
}
