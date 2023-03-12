import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/core/config/routes.dart';
import 'package:task_manage/core/config/styles.dart';

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: StreamProvider.value(
        value: FirebaseAuth.instance.authStateChanges(),
        initialData: null,
      ),
      child: MaterialApp.router(
        theme: themeConfig,
        routerConfig: appRoutes,
      ),
    );
  }
}
