import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/di/injector.dart';
import 'package:task_manage/config/routes/app_router.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/auth/display/provider/auth_provider.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => injector.get<AuthProvider>()..getUser(),
        ),
        Provider(
          create: (_) => injector.get<TaskProvider>()
            ..init(
              user: FirebaseAuth.instance.currentUser!,
            ),
        ),
      ],
      child: MaterialApp.router(
        theme: themeConfig,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
