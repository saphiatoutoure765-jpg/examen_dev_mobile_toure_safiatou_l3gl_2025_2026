import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../providers/task_provider.dart';
import 'task_form_screen.dart';

class TaskDetailScreen extends StatelessWidget {

  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {

    final taskProvider =
    Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Détail de la tâche"),

        actions: [

          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskFormScreen(
                    task: task,
                    projectId: task.projectId,
                  ),
                ),
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              showDialog(
                context: context,
                builder: (_) => AlertDialog(

                  title: const Text("Supprimer la tâche"),

                  content: const Text(
                    "Voulez-vous vraiment supprimer cette tâche ?",
                  ),

                  actions: [

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annuler"),
                    ),

                    TextButton(
                      onPressed: () {

                        taskProvider.deleteTask(task.id);

                        Navigator.pop(context);
                        Navigator.pop(context);

                      },
                      child: const Text("Supprimer"),
                    ),

                  ],
                ),
              );

            },
          ),

        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              task.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              task.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                const Text(
                  "Statut : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(task.status.name),

              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                const Text(
                  "Priorité : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(task.priority.name),

              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                const Text(
                  "Date d'échéance : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  task.dueDate == null
                      ? "Aucune"
                      : task.dueDate!.toLocal().toString().split(' ')[0],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}