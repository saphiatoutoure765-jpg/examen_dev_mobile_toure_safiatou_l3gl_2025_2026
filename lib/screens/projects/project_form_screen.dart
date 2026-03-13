import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../providers/project_provider.dart';
import '../../widgets/cards/project_card.dart';

class ProjectFormScreen extends StatefulWidget {

  final Project? project;

  const ProjectFormScreen({super.key, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

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

    _nameController =
        TextEditingController(text: widget.project?.name ?? "");

    _descriptionController =
        TextEditingController(text: widget.project?.description ?? "");

    _selectedColor = widget.project?.color ?? Colors.blue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProject() {

    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProjectProvider>();

    final project = Project(
      id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      description: _descriptionController.text,
      userId: "user1",
      color: _selectedColor,
      createdAt: widget.project?.createdAt,
    );

    if (widget.project == null) {
      provider.createProject(project);
    } else {
      provider.updateProject(project);
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
      userId: "preview",
      color: _selectedColor,
    );

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.project == null ? "Créer Projet" : "Modifier Projet"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Form(
              key: _formKey,

              child: Column(

                children: [

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Nom du projet",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nom obligatoire";
                      }
                      if (value.length < 3) {
                        return "Minimum 3 caractères";
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Description",
                    ),
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Couleur du projet",
                      style: TextStyle(fontWeight: FontWeight.bold),
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

                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: color,
                          child: _selectedColor == color
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );

                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Aperçu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ProjectCard(
                    project: previewProject,
                  ),

                  const SizedBox(height: 30),

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

          ],
        ),
      ),
    );
  }
}