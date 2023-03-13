import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen(_authStateChanges);
  }

  void _authStateChanges(User? user) {
    if (user != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }
}
