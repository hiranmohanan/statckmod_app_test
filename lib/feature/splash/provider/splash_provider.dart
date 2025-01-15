import 'package:flutter/material.dart';
import 'package:statckmod_app/services/firebase_services.dart';

class SplashProvider extends ChangeNotifier {
  bool _isInitialized = false;
  bool _isLoggedIn = false;
  bool _isProfileReg = false;
  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _isLoggedIn;
  bool get isProfileReg => _isProfileReg;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  void initialize() {
    Future.delayed(const Duration(seconds: 2), () async {
      final users = await _firebaseAuthService.getCurrentUser();
      debugPrint('User: $users');
      if (users != null) {
        _isInitialized = true;
        if (users.displayName == null) {
          _isProfileReg = true;
        } else {
          _isLoggedIn = true;
        }
      }
      _isInitialized = true;
      notifyListeners();
    });
  }
}
