import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {

  final Task? task;
  final String projectId;

  const TaskFormScreen({
    super.key,
    this.task,
    required this.projectId,
  });

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskStatus _status = TaskStatus.todo;
  TaskPriority _priority = TaskPriority.medium;

  DateTime? _dueDate;

  bool get isEdit => widget.task != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {

      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;

      _status = widget.task!.status;
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {

    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  Future<void> _pickDate() async {

    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveTask() {

    if (!_formKey.currentState!.validate()) return;

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    final task = Task(
      id: isEdit ? widget.task!.id : DateTime.now().toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      projectId: widget.projectId,
      status: _status,
      priority: _priority,
      dueDate: _dueDate,
    );

    if (isEdit) {
      taskProvider.updateTask(task);
    } else {
      taskProvider.createTask(task);
    }

    Navigator.pop(context);
  }

  void _deleteTask() {

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

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

              taskProvider.deleteTask(widget.task!.id);

              Navigator.pop(context);
              Navigator.pop(context);

            },
            child: const Text("Supprimer"),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(isEdit ? "Modifier tâche" : "Nouvelle tâche"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Titre",
                ),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Titre obligatoire";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<TaskStatus>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: "Statut",
                ),

                items: TaskStatus.values.map((status) {

                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name),
                  );

                }).toList(),

                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: "Priorité",
                ),

                items: TaskPriority.values.map((priority) {

                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.name),
                  );

                }).toList(),

                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              Row(
                children: [

                  Expanded(
                    child: Text(
                      _dueDate == null
                          ? "Pas de date choisie"
                          : "Date : ${_dueDate!.toLocal()}".split(' ')[0],
                    ),
                  ),

                  TextButton(
                    onPressed: _pickDate,
                    child: const Text("Choisir date"),
                  )

                ],
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saveTask,
                child: Text(isEdit ? "Modifier" : "Créer"),
              ),

              if (isEdit)
                TextButton(
                  onPressed: _deleteTask,
                  child: const Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.red),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}