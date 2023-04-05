import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/view/walkthrough_screen.dart';
import 'package:task_manage/features/task/view/home_screen.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data != null) {
            Provider.of<TaskViewModel>(context).uid = snapshot.data!.uid;
            return const HomeScreen();
          } else {
            return const WalkthroughScreen();
          }
        }
      },
    );
  }
}
