import 'package:flutter/material.dart';

class FilesSection extends StatelessWidget {
  const FilesSection({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
            title: const Text("Khotbah_28_Juli.pdf"),
            subtitle: const Text("Uploaded by Pastor Alex"),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            // Dummy action
          },
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload File"),
        ),
      ],
    );
  }
}