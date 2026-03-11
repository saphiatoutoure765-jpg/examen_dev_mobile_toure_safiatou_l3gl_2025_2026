import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {

  // ===== Propriétés privées =====

  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  final Uuid _uuid = const Uuid();

  // ===== Getters =====

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  bool get isLoading => _isLoading;

  String? get error => _error;

  // ===== Initialisation =====

  Future<void> init() async {

    _isLoading = true;
    notifyListeners();

    // Pour le moment on ne charge rien
    // plus tard on pourra charger depuis SharedPreferences

    _isLoading = false;
    notifyListeners();
  }

  // ===== LOGIN =====

  Future<bool> login(String email, String password) async {

    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if(email.isEmpty || password.isEmpty){

      _error = "Email et mot de passe requis";
      _isLoading = false;
      notifyListeners();
      return false;

    }

    _currentUser = User(
      id: _uuid.v4(),
      name: "Utilisateur",
      email: email,
      password: password,
    );

    _isLoading = false;
    notifyListeners();

    return true;
  }

  // ===== REGISTER =====

  Future<bool> register(
      String name,
      String email,
      String password
      ) async {

    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if(name.isEmpty || email.isEmpty || password.isEmpty){

      _error = "Tous les champs sont obligatoires";
      _isLoading = false;
      notifyListeners();
      return false;

    }

    _currentUser = User(
      id: _uuid.v4(),
      name: name,
      email: email,
      password: password,
    );

    _isLoading = false;
    notifyListeners();

    return true;
  }

  // ===== LOGOUT =====

  Future<void> logout() async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;

    _isLoading = false;
    notifyListeners();
  }

  // ===== UPDATE PROFILE =====

  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {

    if(_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(
      name: name,
      email: email,
    );

    notifyListeners();
  }

  // ===== CLEAR ERROR =====

  void clearError(){
    _error = null;
    notifyListeners();
  }

}