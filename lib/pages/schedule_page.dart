import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pniel_call/enum/app_colors.dart'; // pastikan import enum AppColor

class SchedulePage extends StatefulWidget { // Ubah menjadi StatefulWidget untuk StreamBuilder
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final List<String> blockoutDates = ["20 Jul", "27 Jul"];

  final List<Map<String, String>> upcomingSchedules = [
    {
      "service": "Worship Leader",
      "date": "3 Aug 2025",
      "practice": "1 Aug 2025, 19:00"
    },
    {
      "service": "Singer",
      "date": "10 Aug 2025",
      "practice": "8 Aug 2025, 19:00"
    },
  ];

  final Map<String, String> serviceInvitation = {
    "service": "Guitarist",
    "date": "17 Aug 2025",
    "practice": "15 Aug 2025, 19:00",
    "from": "Admin"
  };

  // Tambahkan Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = 'Pengguna'; // Default name

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.get('name') ?? 'Pengguna';
          });
        }
      } catch (e) {
        print("Error fetching user name: $e");
        setState(() {
          _userName = user.displayName ?? 'Pengguna'; // Fallback to email if name fetch fails
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ucapan Selamat Datang dan Nama Pengguna
            Text(
              "Hai, $_userName!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary.color, // Menggunakan warna primary
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Selamat datang di jadwal pelayanan Pniel Call.",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.textSecondary.color,
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: AppColor.secondary.color), // Divider yang lebih menarik
            const SizedBox(height: 16),

            // Header title
            Text(
              "My Schedule",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary.color,
              ),
            ),
            const SizedBox(height: 4),
            // User Dropdown Dihapus
            // SizedBox(height: 16), // Dihapus karena dropdown tidak ada

            // Service Invitation Section (ATAS)
            Card(
              color: AppColor.primaryAccent.color, // pastel hijau
              child: ListTile(
                leading: Icon(Icons.mail, color: Colors.orange[800]),
                title: Text(
                  "Service Invitation: ${serviceInvitation["service"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.textSecondary.color,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${serviceInvitation["date"]}",
                      style: TextStyle(color: AppColor.textSecondary.color),
                    ),
                    Text(
                      "Practice: ${serviceInvitation["practice"]}",
                      style: TextStyle(color: AppColor.textSecondary.color),
                    ),
                    Text(
                      "From: ${serviceInvitation["from"]}",
                      style: TextStyle(color: AppColor.textSecondary.color),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Approve logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Approve"),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add blockout logic
                  },
                  icon: Icon(Icons.calendar_today, color: Colors.green),
                  label: Text("Add Blockout"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: BorderSide(color: Colors.green),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Upcoming Schedule Section
            Text(
              "UPCOMING SCHEDULE",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary.color,
              ),
            ),
            SizedBox(height: 8),
            ...upcomingSchedules.map((schedule) => Card(
                  color: const Color(0xFFACC270), // Warna solid
                  child: ListTile(
                    leading: Icon(Icons.event, color: Colors.green[800]),
                    title: Text(
                      "${schedule["service"]} - ${schedule["date"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textSecondary.color,
                      ),
                    ),
                    subtitle: Text(
                      "Practice: ${schedule["practice"]}",
                      style: TextStyle(color: AppColor.textSecondary.color),
                    ),
                  ),
                )),
            SizedBox(height: 16),

            Text(
              "BLOCKOUT DATES",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary.color,
              ),
            ),
            SizedBox(height: 8),
            ...blockoutDates.map((date) => Card(
                  color: AppColor.highlight.color, // pastel merah muda
                  child: ListTile(
                    leading: Icon(Icons.block, color: Colors.red[300]),
                    title: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textTertiary.color,
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}