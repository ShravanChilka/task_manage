import 'package:flutter/material.dart';
import 'package:task_manage/config/routes/app_router.dart';
import 'package:task_manage/config/style/styles.dart';

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeConfig,
      routerConfig: AppRouter.router,
    );
  }
}
