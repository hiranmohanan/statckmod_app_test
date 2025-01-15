import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../services/firebase_services.dart';

class AuthSignupProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isObscure = true;
  bool _isObsecureCinfirm = false;
  bool _isRememberMe = false;

  bool _isSignup = false;
  String? _signupError;

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isObscure => _isObscure;
  bool get isoBscureConfirm => _isObsecureCinfirm;
  bool get isRememberMe => _isRememberMe;
  bool get isSignup => _isSignup;
  String? get signupError => _signupError;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setIsObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setIsObscureConfirm() {
    _isObsecureCinfirm = !_isObsecureCinfirm;
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

  Future<void> signup() async {
    final signUpResponce = await _firebaseAuthService
        .registerWithEmailAndPassword(_email, _password);
    if (signUpResponce is User) {
      debugPrint('signup response: $signUpResponce');
      _isSignup = true;
      notifyListeners();
    } else {
      _signupError = signUpResponce.toString();
      notifyListeners();
    }
  }
}
