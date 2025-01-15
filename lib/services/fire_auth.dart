part of 'firebase_services.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return Exception(e);
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return Exception(e);
    }
  }

  Future forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Kstrings.resendEmailSend;
    } catch (e) {
      return Exception(e);
    }
  }

  Future setDisplayName(String name) async {
    try {
      User user = _auth.currentUser!;
      await user.updateDisplayName(name);
    } catch (e) {
      return Exception(e);
    }
  }

  Future setDisplayImage(String url) async {
    try {
      User user = _auth.currentUser!;
      await user.updatePhotoURL(url);
      return user;
    } catch (e) {
      return Exception(e);
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return Exception(e);
    }
  }

  getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      return Exception(e);
    }
  }
}
