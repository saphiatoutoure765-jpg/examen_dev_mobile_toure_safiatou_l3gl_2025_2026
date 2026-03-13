import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/project_provider.dart';
import '../../../providers/task_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider = context.watch<AuthProvider>();
    final projectCount = context.watch<ProjectProvider>().projectCount;
    final taskCount = context.watch<TaskProvider>().tasks.length;

    final user = authProvider.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          CircleAvatar(
            radius: 40,
            child: Text(
              user != null
                  ? user.name.substring(0, 1).toUpperCase()
                  : "U",
              style: const TextStyle(fontSize: 24),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            user?.name ?? "Utilisateur",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(user?.email ?? "user@email.com"),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("Projets"),
              subtitle: Text("$projectCount projets"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.task),
              title: const Text("Tâches"),
              subtitle: Text("$taskCount tâches"),
            ),
          ),
        ],
      ),
    );
  }
}