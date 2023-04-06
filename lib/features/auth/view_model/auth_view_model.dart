import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/auth/utils/paths.dart';
import 'package:task_manage/features/auth/view/walkthrough_page.dart';
import 'package:task_manage/features/auth/web_service/firebase_auth_web_service.dart';

class AuthViewModel extends ChangeNotifier {
  late final FirebaseAuthWebService _service;
  late final StreamSubscription _authStream;

  User? _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  User? get user => _user;

  AuthViewModel() {
    _service = FirebaseAuthWebService(
      client: FirebaseAuth.instance,
    );
    _authStream = _service.client.authStateChanges().listen(
      (event) {
        user = event;
      },
    );
  }

  @override
  void dispose() {
    _authStream.cancel();
    super.dispose();
  }

  Failure? _failure;
  bool _isLoading = false;
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

  set failure(Failure? value) {
    _failure = value;
    notifyListeners();
  }

  Failure? get failure => _failure;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> signInWithGoogle() async {
    try {
      _service.signInWithGoogle();
    } on RemoteException catch (e) {
      failure = RemoteFailure(error: e.error);
    }
  }

  Future<void> deleteAccount() async {
    try {
      _service.deleteAccount();
    } on RemoteException catch (e) {
      failure = RemoteFailure(error: e.error);
    }
  }

  Future<void> logout() async {
    try {
      _service.logout();
    } on RemoteException catch (e) {
      failure = RemoteFailure(error: e.error);
    }
  }

  Stream<User?> authStateChanges() => _service.authStateChanges();
}
