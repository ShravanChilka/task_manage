import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manage/config/routes/app_router.dart';
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/auth/domain/repository/auth_repository.dart';
import 'dart:developer';
import '../../../../config/routes/app_routes.dart';
import '../screens/painter/paths.dart';
import '../screens/walkthrough_page.dart';

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
      (error) {
        log(error.toString());
        failure = error;
      },
      (data) {
        log(data.toString());
        user = data;
        if (user != null) {
          AppRouter.router.goNamed(Pages.home.screenName, extra: user!);
        }
      },
    );
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final response = await repository.signInWithGoogle();
    response.fold(
      (error) {
        log(error.error.toString());
        failure = error;
      },
      (data) {
        user = data.user;
        if (user != null) {
          AppRouter.router.goNamed(Pages.home.screenName, extra: user!);
        }
      },
    );
    notifyListeners();
  }

  Future<void> logOut() async {
    await repository.logOut();
  }

  Future<void> deleteAccount() async {
    await repository.deleteAccount();
  }

  int _currentIndex = 0;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  final pagesList = const [
    WalkthroughPage(
      assetPath:
          'assets/business-young_woman_standing_and_holding_her_head.png',
      pathType: PathType.firstScreen,
      title: 'Stay Organized, Every Day',
      description:
          'You can keep track of all your tasks and to-dos in one place, ensuring you never miss an important deadline or forget a critical task again',
    ),
    WalkthroughPage(
      assetPath: 'assets/business_man_studying.png',
      pathType: PathType.secondScreen,
      title: 'Your Personal Productivity Assistant',
      description:
          'Assistant that can help you manage your tasks and schedule effectively',
    ),
    WalkthroughPage(
      assetPath: 'assets/business_man_standing_with_laptop.png',
      pathType: PathType.thirdScreen,
      title: 'Simplify Your Life, One Task at a Time',
      description:
          'Simplify your life and focus on what matters most by breaking down complex tasks into simple, manageable steps',
    ),
  ];

  int get currentIndex => _currentIndex;
}
