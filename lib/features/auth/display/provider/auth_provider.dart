import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manage/config/routes/app_router.dart';
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/auth/domain/repository/auth_repository.dart';
import 'dart:developer';
import '../../../../config/routes/routes.dart';

class AuthProvider extends ChangeNotifier {
  Failure? failure;
  User? user;
  final AuthRepository repository;
  bool isSelected = false;

  AuthProvider({
    required this.repository,
  });

  Future<void> getUser() async {
    final response = await repository.getUser();
    response.fold(
      (error) => failure = error,
      (data) {
        log(data.toString());
        user = data;
      },
    );
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final response = await repository.signInWithGoogle();
    response.fold(
      (error) => failure = error,
      (data) {
        log(data.toString());
        user = data.user;
        if (user != null) {
          AppRouter.router.goNamed(Pages.home.screenName, extra: user!);
        }
      },
    );
    notifyListeners();
  }

  bool _isLoggedIn = false;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  void _authStateChanges(User? user) {
    if (user != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }
}
