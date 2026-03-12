import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../core/constants/app_colors.dart';

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
      color: AppColors.surface,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: InkWell(
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Pastille couleur projet
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              /// Infos projet
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Nom projet
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// Description
                    Text(
                      project.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// Nombre de tâches
                    Text(
                      "$taskCount tâches",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textDisable,
                      ),
                    ),

                  ],
                ),
              ),

              /// Menu contextuel
              PopupMenuButton<String>(
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

            ],
          ),
        ),
      ),
    );

  }

}