import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Song {
  String title;
  String artist;
  String referenceLink;
  String key;
  String notes;

  Song({
    required this.title,
    required this.artist,
    required this.referenceLink,
    required this.key,
    required this.notes,
  });
}

class SongsSection extends StatefulWidget {
  const SongsSection({super.key, required this.date});
  final DateTime date;

  @override
  State<SongsSection> createState() => _SongsSectionState();
}

class _SongsSectionState extends State<SongsSection> {
  final List<Song> songs = [];

  void _showSongModal({Song? song, int? index}) {
    final titleController = TextEditingController(text: song?.title);
    final artistController = TextEditingController(text: song?.artist);
    final linkController = TextEditingController(text: song?.referenceLink);
    final keyController = TextEditingController(text: song?.key);
    final notesController = TextEditingController(text: song?.notes);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(song == null ? 'Add Song' : 'Edit Song'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: "Song Title")),
              TextField(controller: artistController, decoration: const InputDecoration(labelText: "Artist")),
              TextField(controller: linkController, decoration: const InputDecoration(labelText: "Reference Link")),
              TextField(controller: keyController, decoration: const InputDecoration(labelText: "Key")),
              TextField(controller: notesController, decoration: const InputDecoration(labelText: "Notes")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newSong = Song(
                title: titleController.text,
                artist: artistController.text,
                referenceLink: linkController.text,
                key: keyController.text,
                notes: notesController.text,
              );
              setState(() {
                if (song != null && index != null) {
                  songs[index] = newSong;
                } else {
                  songs.add(newSong);
                }
              });
              Navigator.of(context).pop();
            },
            child: Text(song == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open the link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: songs.isEmpty
          ? const Center(child: Text("No songs added yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ExpansionTile(
                    title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(song.artist),
                    children: [
                      ListTile(
                        title: const Text("Reference Link"),
                        subtitle: InkWell(
                          child: Text(
                            song.referenceLink,
                            style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                          onTap: () => _launchURL(song.referenceLink),
                        ),
                      ),
                      ListTile(
                        title: const Text("Key"),
                        subtitle: Text(song.key),
                      ),
                      ListTile(
                        title: const Text("Notes"),
                        subtitle: Text(song.notes),
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () => _showSongModal(song: song, index: index),
                            child: const Text("Edit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSongModal(),
        icon: const Icon(Icons.add),
        label: const Text("Add Song"),
      ),
    );
  }
}
