import 'package:flutter/material.dart';
import '../../models/project.dart';

class ProjectCard extends StatelessWidget {

  final Project project;
  final int taskCount;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    this.taskCount = 0,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(

        onTap: onTap,

        // === Pastille couleur du projet ===
        leading: CircleAvatar(
          backgroundColor: project.color,
          radius: 10,
        ),

        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(project.description),

            const SizedBox(height: 4),

            Text("Tâches : $taskCount"),

          ],
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {

            if(value == "edit"){
              onEdit?.call();
            }

            if(value == "delete"){
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