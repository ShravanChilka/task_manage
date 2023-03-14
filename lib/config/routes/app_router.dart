import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manage/features/auth/display/screens/login_screen.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import '../../features/task/display/screens/add_task_screen.dart';
import '../../features/task/display/screens/home_screen.dart';
import 'routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Pages.login.screenPath,
        name: Pages.login.screenName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Pages.home.screenPath,
        name: Pages.home.screenName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Pages.create.screenPath,
        name: Pages.create.screenName,
        builder: (context, state) {
          DocumentSnapshot<TaskModel>? documentSnapshot =
              state.extra as DocumentSnapshot<TaskModel>?;
          return AddTaskScreen(documentSnapshot: documentSnapshot);
        },
      ),
    ],
  );
}
