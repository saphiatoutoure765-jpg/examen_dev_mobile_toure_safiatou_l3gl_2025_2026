import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class AppProvider extends ChangeNotifier {

  // ===== Propriétés privées =====

  bool _isOnboardingComplete = false;
  bool _isInitialized = false;
  bool _isLoading = false;

  // ===== Getters =====

  bool get isOnboardingComplete => _isOnboardingComplete;

  bool get isInitialized => _isInitialized;

  bool get isLoading => _isLoading;

  // ===== Initialisation =====

  Future<void> init() async {

    _isLoading = true;
    notifyListeners();

    await StorageService.instance.init();

    _isOnboardingComplete =
        StorageService.instance.isOnboardingComplete;

    _isInitialized = true;

    _isLoading = false;
    notifyListeners();
  }

  // ===== Compléter onboarding =====

  Future<void> completeOnboarding() async {

    _isLoading = true;
    notifyListeners();

    await StorageService.instance.setOnboardingComplete(true);

    _isOnboardingComplete = true;

    _isLoading = false;
    notifyListeners();
  }

  // ===== Reset onboarding =====

  Future<void> resetOnboarding() async {

    _isLoading = true;
    notifyListeners();

    await StorageService.instance.setOnboardingComplete(false);

    _isOnboardingComplete = false;

    _isLoading = false;
    notifyListeners();
  }

}