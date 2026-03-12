import 'package:flutter/material.dart';
import 'package:sunu_task/core/constants/app_colors.dart';

// === PARTIE 4.2 ===
// DashboardTab : affichage principal avec message de bienvenue

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Bonjour";
    } else if (hour < 18) {
      return "Bon après-midi";
    } else {
      return "Bonsoir";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Text(
            "${_getGreeting()} 👋",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Bienvenue dans SunuTask",
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("Projets"),
              subtitle: const Text("Nombre de projets : 0"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Tâches"),
              subtitle: const Text("Nombre de tâches : 0"),
            ),
          ),
        ],
      ),
    );
  }
}