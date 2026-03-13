import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../core/constants/app_colors.dart';

class TaskCard extends StatelessWidget {

  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return AppColors.warning;
      case TaskStatus.inProgress:
        return AppColors.primary;
      case TaskStatus.done:
        return AppColors.success;
    }
  }

  String _statusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return "À faire";
      case TaskStatus.inProgress:
        return "En cours";
      case TaskStatus.done:
        return "Terminée";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),

      child: ListTile(

        onTap: onTap,

        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (task.description.isNotEmpty)
              Text(task.description),

            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: _statusColor(task.status),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _statusText(task.status),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),

          ],
        ),

        trailing: PopupMenuButton<String>(

          onSelected: (value) {

            if (value == "edit") {
              onEdit?.call();
            }

            if (value == "delete") {
              onDelete?.call();
            }

          },

          itemBuilder: (context) => [

            const PopupMenuItem(
              value: "edit",
              child: Text("Modifier"),
            ),

            const PopupMenuItem(
              value: "delete",
              child: Text("Supprimer"),
            ),

          ],
        ),

      ),
    );

  }

}