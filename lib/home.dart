import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/schedule_page.dart';
import 'pages/my_plan_page.dart';
import 'pages/profile_page.dart';
import 'enum/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome Flutter for icons


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan di BottomNavigationBar
  final List<Widget> _pages = [
    SchedulePage(),
    MyPlanPage(),
    ProfilePage(),
  ];

  // Fungsi untuk mengubah indeks halaman saat item BottomNavigationBar ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Judul AppBar untuk setiap halaman
  final List<String> _titles = ["Schedule", "My Plan", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), // Judul AppBar sesuai halaman yang dipilih
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // AuthWrapper akan otomatis mengarahkan kembali ke LoginScreen
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Indeks item yang sedang aktif
        onTap: _onItemTapped, // Callback saat item ditekan
        selectedItemColor: AppColor.textPrimary.color,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.calendarCheck), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'My Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}