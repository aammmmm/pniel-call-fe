import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pniel_call/home.dart';
import 'enum/app_colors.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase menggunakan konfigurasi dari firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PnielCallApp());
}

class PnielCallApp extends StatelessWidget {
  const PnielCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pniel Call',
      theme: ThemeData(
        fontFamily: 'SFProRounded',
        scaffoldBackgroundColor: AppColor.background.color,
        primarySwatch: Colors.blue,
        
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // Menghilangkan border default
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.background.color,
          foregroundColor: AppColor.textPrimary.color,
          elevation: 0, // Menghilangkan bayangan AppBar
        ),
      ),
      home: const AuthWrapper(), // Menggunakan AuthWrapper untuk mengelola status login
    );
  }
}

// AuthWrapper untuk mengelola apakah pengguna sudah login atau belum
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // Pengguna sudah login, arahkan ke HomePage (dengan BottomNavigationBar)
          return HomePage();
        } else {
          // Pengguna belum login, arahkan ke LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
