import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../providers/project_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/cards/task_card.dart';
import '../tasks/task_form_screen.dart';

class ProjectDetailScreen extends StatelessWidget {

  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {

    final taskProvider = context.watch<TaskProvider>();
    final projectProvider = context.read<ProjectProvider>();

    final tasks = taskProvider.tasks
        .where((task) => task.projectId == project.id)
        .toList();

    final todoCount =
        tasks.where((t) => t.status.name == "todo").length;

    final inProgressCount =
        tasks.where((t) => t.status.name == "inProgress").length;

    final doneCount =
        tasks.where((t) => t.status.name == "done").length;

    return Scaffold(

      appBar: AppBar(
        title: Text(project.name),

        actions: [

          /// modifier projet
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),

          /// supprimer projet
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              showDialog(
                context: context,
                builder: (context) {

                  return AlertDialog(
                    title: const Text("Supprimer projet"),
                    content: const Text(
                      "Voulez-vous vraiment supprimer ce projet ?",
                    ),

                    actions: [

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler"),
                      ),

                      TextButton(
                        onPressed: () {

                          projectProvider.deleteProject(project.id);

                          Navigator.pop(context);
                          Navigator.pop(context);

                        },
                        child: const Text("Supprimer"),
                      ),

                    ],
                  );

                },
              );

            },
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TaskFormScreen(
                projectId: project.id,
              ),
            ),
          );

        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: project.color,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  project.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  project.description,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 10),

          /// STATISTIQUES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                Chip(label: Text("À faire : $todoCount")),

                Chip(label: Text("En cours : $inProgressCount")),

                Chip(label: Text("Terminées : $doneCount")),

              ],
            ),
          ),

          const SizedBox(height: 10),

          /// DATE CREATION
          Text(
            "Créé le : ${project.createdAt.day}/${project.createdAt.month}/${project.createdAt.year}",
          ),

          const SizedBox(height: 10),

          /// LISTE TACHES
          Expanded(
            child: tasks.isEmpty
                ? const Center(
              child: Text("Aucune tâche pour ce projet"),
            )
                : ListView.builder(
              itemCount: tasks.length,

              itemBuilder: (context, index) {

                final task = tasks[index];

                return TaskCard(
                  task: task,
                  onTap: () {},
                  onEdit: () {},
                  onDelete: () {
                    context
                        .read<TaskProvider>()
                        .deleteTask(task.id);
                  },
                );

              },
            ),
          ),

        ],
      ),
    );
  }
}