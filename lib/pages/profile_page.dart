import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pniel_call/enum/app_colors.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser; // Dapatkan pengguna yang sedang login

    if (user == null) {
      return Center(
        child: Text(
          'Pengguna tidak login.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('users').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: AppColor.secondary.color),
                const SizedBox(height: 20),
                Text(
                  'Profil Pengguna',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary.color,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${user.email ?? 'Tidak ada data'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Data profil belum lengkap.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }

        // Data profil ditemukan
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final String userName = userData['name'] ?? 'Tidak ada nama';
        final String userEmail = userData['email'] ?? user.email ?? 'Tidak ada email';
        final String userRole = userData['role'] ?? 'Tidak ada peran';

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline, size: 80, color: AppColor.secondary.color),
              const SizedBox(height: 20),
              Text(
                'Halo, $userName!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary.color,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: $userEmail',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              // Text(
              //   'Peran: $userRole',
              //   style: Theme.of(context).textTheme.bodyLarge,
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  // AuthWrapper akan otomatis mengarahkan kembali ke LoginScreen
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}