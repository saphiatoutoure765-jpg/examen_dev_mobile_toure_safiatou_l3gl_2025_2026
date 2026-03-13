import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../providers/project_provider.dart';
import '../../widgets/cards/project_card.dart';

class ProjectFormScreen extends StatefulWidget {

  final Project? project; // null = création, non-null = modification

  const ProjectFormScreen({
    super.key,
    this.project,
  });

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Color _selectedColor = Colors.blue;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();

    if (widget.project != null) {
      _nameController.text = widget.project!.name;
      _descriptionController.text = widget.project!.description;
      _selectedColor = widget.project!.color;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProject() {

    if (!_formKey.currentState!.validate()) return;

    final projectProvider =
    Provider.of<ProjectProvider>(context, listen: false);

    final project = Project(
      id: widget.project?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      description: _descriptionController.text,
      userId: "1",
      color: _selectedColor,
    );

    if (widget.project == null) {
      projectProvider.createProject(project);
    } else {
      projectProvider.updateProject(project);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final previewProject = Project(
      id: "preview",
      name: _nameController.text.isEmpty ? "Nom du projet" : _nameController.text,
      description: _descriptionController.text.isEmpty
          ? "Description du projet"
          : _descriptionController.text,
      userId: "1",
      color: _selectedColor,
    );

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.project == null
              ? "Créer un projet"
              : "Modifier le projet",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// FORMULAIRE
            Form(
              key: _formKey,

              child: Column(
                children: [

                  /// NOM
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Nom du projet",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le nom est obligatoire";
                      }

                      if (value.length < 3) {
                        return "Minimum 3 caractères";
                      }

                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 16),

                  /// DESCRIPTION
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                    ),
                    maxLines: 3,
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 20),

                  /// COULEUR
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Couleur du projet",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: _colors.map((color) {

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: _selectedColor == color
                                ? Border.all(
                              color: Colors.black,
                              width: 3,
                            )
                                : null,
                          ),
                        ),
                      );

                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  /// BOUTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveProject,
                      child: Text(
                        widget.project == null
                            ? "Créer"
                            : "Modifier",
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            /// PREVIEW
            const Text(
              "Aperçu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ProjectCard(
              project: previewProject,
              taskCount: 0,
            ),

          ],
        ),
      ),
    );
  }
}