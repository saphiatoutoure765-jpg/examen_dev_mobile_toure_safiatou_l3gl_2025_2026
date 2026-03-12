import 'package:flutter/material.dart';
import 'package:sunu_task/core/constants/app_colors.dart';

// === PARTIE 4.5 ===
// Profil utilisateur

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          const CircleAvatar(
            radius: 40,
            child: Text(
              "U",
              style: TextStyle(fontSize: 24),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Utilisateur",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text("user@email.com"),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("Projets"),
              subtitle: const Text("0 projets"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.task),
              title: const Text("Tâches"),
              subtitle: const Text("0 tâches"),
            ),
          ),
        ],
      ),
    );
  }
}