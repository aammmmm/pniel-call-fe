// filepath: lib/pages/widgets/teams_section.dart
import 'package:flutter/material.dart';
import 'team_category_card.dart';

class TeamsSection extends StatelessWidget {
  const TeamsSection({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        // Text(
        //   "Sunday, 28 July 2025",
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        SizedBox(height: 16),
        TeamCategoryCard(
          title: "Worship Team",
          roles: [
            {"role": "Worship Leader", "name": "Christien"},
            {"role": "Singer", "name": "Naomi, Jessica"},
            {"role": "Guitarist", "name": "Aam"},
            {"role": "Bassist", "name": "Sarah White"},
            {"role": "Keyboardist", "name": "Tom Brown"},
            {"role": "Drummer", "name": "Emma Green"},
          ],
        ),
        SizedBox(height: 16),
        TeamCategoryCard(
          title: "Preacher",
          roles: [
            {"role": "Speaker", "name": "Pastor Alex"},
          ],
        ),
        SizedBox(height: 16),
        TeamCategoryCard(
          title: "Connector",
          roles: [
            {"role": "Usher & Greeter", "name": "Liam Grey"},
            {"role": "MC / Announcement", "name": "Mia Blue"},
          ],
        ),
      ],
    );
  }
}