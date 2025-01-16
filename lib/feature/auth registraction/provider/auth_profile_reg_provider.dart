import 'package:flutter/material.dart';
import 'package:statckmod_app/services/firebase_services.dart';
import 'package:statckmod_app/services/image_service.dart';

class AuthProfileRegProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Image? _image;
  String? _imageUrl;
  String? _imagePath;
  String? _imageError;

  bool _isObscure = true;
  bool _isObsecureCinfirm = false;

  bool _isProfileReg = false;
  String? _profileRegError;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isObscure => _isObscure;
  bool get isoBscureConfirm => _isObsecureCinfirm;

  bool get isProfileReg => _isProfileReg;
  String? get profileRegError => _profileRegError;

  Image? get image => _image;
  String? get imageUrl => _imageUrl;
  String? get imagePath => _imagePath;
  String? get imageError => _imageError;

  final FirebaseAuthService _authService = FirebaseAuthService();

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

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

  Future<void> uploadImage(Image image) async {
    final imageService = ImageService();
    try {
      await imageService.uploadImage();
    } catch (e) {
      _imageError = e.toString();
    }
    notifyListeners();
  }

  Future<void> getImageUrl() async {
    final imageService = ImageService();
    _imageUrl = await imageService.getImageUrl();
    notifyListeners();
  }

  Future<void> profileReg() async {
    final res = await _authService.setDisplayName(_name);
    if (res is String) {
      _profileRegError = res;
      notifyListeners();
    }
    _isProfileReg = true;
    notifyListeners();
  }

  void setProfileRegError(String value) {
    _profileRegError = value;
    notifyListeners();
  }

  void clearProfileRegError() {
    _profileRegError = null;
    notifyListeners();
  }
}
