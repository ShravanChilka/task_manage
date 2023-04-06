import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/auth/view/auth_screen.dart';
import 'features/auth/view_model/auth_view_model.dart';
import 'features/task/view_model/task_view_model.dart';
import 'firebase_options.dart';

void application() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TaskManage());
}

class TaskManage extends StatelessWidget {
  const TaskManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthViewModel()),
        ChangeNotifierProvider.value(value: TaskViewModel()),
      ],
      child: MaterialApp(
        theme: themeConfig,
        home: const AuthScreen(),
      ),
    );
  }
}
