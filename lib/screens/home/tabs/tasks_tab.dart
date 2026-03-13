import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/task_provider.dart';
import '../../../widgets/cards/task_card.dart';
import '../../../core/constants/app_colors.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {

    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;

    if (tasks.isEmpty) {
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {

        final task = tasks[index];

        return TaskCard(
          task: task,
        );
      },
    );
  }
}