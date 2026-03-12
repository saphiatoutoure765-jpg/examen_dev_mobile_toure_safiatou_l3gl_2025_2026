import 'package:flutter/material.dart';
import 'package:sunu_task/core/constants/app_colors.dart';

// === PARTIE 4.4 ===
// Liste des tâches

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.task_alt,
            size: 80,
            color: AppColors.textSecondary,
          ),

          const SizedBox(height: 20),

          const Text(
            "Aucune tâche disponible",
            style: TextStyle(fontSize: 18),
          ),

        ],
      ),
    );
  }
}