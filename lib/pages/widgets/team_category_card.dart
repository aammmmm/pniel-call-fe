import 'package:flutter/material.dart';

class TeamCategoryCard extends StatelessWidget {
  final String title;
  final List<Map<String, String>> roles;

  const TeamCategoryCard({
    super.key,
    required this.title,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          iconColor: const Color.fromARGB(137, 255, 253, 253),
          collapsedIconColor: const Color.fromARGB(115, 255, 255, 255),
          children: roles.map((role) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage('assets/profile_dummy.png'), // Dummy avatar
              ),
              title: Text(role["name"]!),
              subtitle: Text(role["role"]!),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            );
          }).toList(),
        ),
      ),
    );
  }
}


class PlanDetailModel {
  final String name;
  final String role;
  final String category; // tambahkan ini

  PlanDetailModel({
    required this.name,
    required this.role,
    required this.category,
  });
}


class PlanDetailScreen extends StatelessWidget {
  final List<PlanDetailModel> planDetails;
  final String date;

  const PlanDetailScreen({
    super.key,
    required this.planDetails,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // Kelompokkan berdasarkan category
    final Map<String, List<Map<String, String>>> groupedData = {};

    for (var detail in planDetails) {
      final category = detail.category;
      if (!groupedData.containsKey(category)) {
        groupedData[category] = [];
      }
      groupedData[category]!.add({
        "role": detail.role,
        "name": detail.name,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Plan"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...groupedData.entries.map((entry) {
            return Column(
              children: [
                TeamCategoryCard(
                  title: entry.key,
                  roles: entry.value,
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}