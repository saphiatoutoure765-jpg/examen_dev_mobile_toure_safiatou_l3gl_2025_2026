import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/project_provider.dart';
import '../../../providers/task_provider.dart';
import '../../../widgets/cards/project_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../projects/project_detail_screen.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {

    final projectProvider = context.watch<ProjectProvider>();
    final taskProvider = context.watch<TaskProvider>();

    final projects = projectProvider.projects;

    if (projects.isEmpty) {
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      itemBuilder: (context, index) {

        final project = projects[index];

        final taskCount = taskProvider.tasks
            .where((task) => task.projectId == project.id)
            .length;

        return ProjectCard(
          project: project,
          taskCount: taskCount,

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProjectDetailScreen(
                  project: project,
                ),
              ),
            );
          },
        );
      },
    );
  }
}