import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectProvider extends ChangeNotifier {

  // ===== Propriétés privées =====

  List<Project> _projects = [];
  Project? _selectedProject;

  bool _isLoading = false;

  // ===== Getters =====

  List<Project> get projects => _projects;

  Project? get selectedProject => _selectedProject;

  int get projectCount => _projects.length;

  bool get isLoading => _isLoading;

  // ===== Charger les projets =====

  Future<void> loadProjects(String userId) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    // Pour le moment on simule le chargement
    _projects = _projects.where((p) => p.userId == userId).toList();

    _isLoading = false;
    notifyListeners();
  }

  // ===== Créer un projet =====

  Future<void> createProject(Project project) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _projects.add(project);

    _isLoading = false;
    notifyListeners();
  }

  // ===== Modifier un projet =====

  Future<void> updateProject(Project project) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    final index = _projects.indexWhere((p) => p.id == project.id);

    if (index != -1) {
      _projects[index] = project;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ===== Supprimer un projet =====

  Future<void> deleteProject(String projectId) async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _projects.removeWhere((p) => p.id == projectId);

    if (_selectedProject?.id == projectId) {
      _selectedProject = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // ===== Sélectionner un projet =====

  void selectProject(Project? project) {

    _selectedProject = project;

    notifyListeners();
  }

}