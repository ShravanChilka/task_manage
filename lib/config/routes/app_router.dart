import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/display/provider/auth_provider.dart';
import 'package:task_manage/screens/home_screen_test.dart';
import '../../features/auth/display/screens/login_screen.dart';
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
        builder: (context, state) => const HomeScreenTest(),
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
          return const AddTaskScreen();
        },
      ),
    ],
  );
}
