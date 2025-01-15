import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../services/firebase_services.dart';

class AuthLoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';

  bool _isObscure = true;
  bool _isRememberMe = false;

  bool _isLogin = false;
  String? _loginerror;

  String get email => _email;
  String get password => _password;
  bool get isObscure => _isObscure;
  bool get isRememberMe => _isRememberMe;
  bool get isLogin => _isLogin;
  String? get loginerror => _loginerror;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setIsObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setIsRememberMe() {
    _isRememberMe = !_isRememberMe;
    notifyListeners();
  }

  void forgotPassword() {
    if (kDebugMode) {
      print('Forgot Password');
    }
  }

  Future<void> login() async {
    final loginResponce =
        await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    if (loginResponce is User) {
      _isLogin = true;
    } else {
      _loginerror = loginResponce.toString();
    }
  }
}
