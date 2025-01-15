import 'package:flutter/material.dart';
import 'package:statckmod_app/services/firebase_services.dart';

class AuthProfileRegProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phone = '';
  String _address = '';
  String _landmark = '';
  String _street = '';
  String _pincode = '';
  String _city = '';
  String _state = '';
  Image? _image;
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
  String get phone => _phone;
  String get address => _address;
  String get landmark => _landmark;
  String get street => _street;
  String get pincode => _pincode;
  String get city => _city;
  String get state => _state;
  Image? get image => _image;

  final FirebaseAuthService _authService = FirebaseAuthService();
  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  void setLandmark(String value) {
    _landmark = value;
    notifyListeners();
  }

  void setStreet(String value) {
    _street = value;
    notifyListeners();
  }

  void setPincode(String value) {
    _pincode = value;
    notifyListeners();
  }

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  void setState(String value) {
    _state = value;
    notifyListeners();
  }

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

  void clearAll() {
    _name = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _phone = '';
    _address = '';
    _landmark = '';
    _street = '';
    _pincode = '';
    _city = '';
    _state = '';
    _isObscure = true;
    _isObsecureCinfirm = false;
    _isProfileReg = false;
    _profileRegError = null;
    notifyListeners();
  }
}
