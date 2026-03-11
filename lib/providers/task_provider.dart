import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {

  // ===== Propriétés privées =====

  List<Task> _tasks = [];
  bool _isLoading = false;

  // ===== Getters =====

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  int get taskCount => _tasks.length;

  // ===== Charger les tâches d'un projet =====

  Future<void> loadTasks(String projectId) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _tasks = _tasks.where((task) => task.projectId == projectId).toList();

    _isLoading = false;
    notifyListeners();
  }

  // ===== Créer une tâche =====

  Future<void> createTask(Task task) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _tasks.add(task);

    _isLoading = false;
    notifyListeners();
  }

  // ===== Modifier une tâche =====

  Future<void> updateTask(Task task) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    final index = _tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      _tasks[index] = task;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ===== Supprimer une tâche =====

  Future<void> deleteTask(String taskId) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _tasks.removeWhere((task) => task.id == taskId);

    _isLoading = false;
    notifyListeners();
  }

  // ===== Mettre à jour le statut =====

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {

    final index = _tasks.indexWhere((task) => task.id == taskId);

    if (index != -1) {

      final task = _tasks[index];

      _tasks[index] = task.copyWith(status: status);

      notifyListeners();
    }
  }

}