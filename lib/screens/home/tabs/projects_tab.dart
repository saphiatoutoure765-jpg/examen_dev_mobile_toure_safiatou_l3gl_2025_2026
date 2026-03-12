import 'package:flutter/material.dart';
import 'package:sunu_task/core/constants/app_colors.dart';

// === PARTIE 4.3 ===
// Liste des projets

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.folder_open,
            size: 80,
            color: AppColors.textSecondary,
          ),

          const SizedBox(height: 20),

          const Text(
            "Aucun projet pour le moment",
            style: TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 10),

          const Text(
            "Cliquez sur + pour créer un projet",
          ),
        ],
      ),
    );
  }
}