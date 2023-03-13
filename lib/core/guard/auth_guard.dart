import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/display/screens/home_screen.dart';
import 'package:task_manage/screens/login_screen.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return FutureBuilder(
      future: _reload(user: user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (user != null) {
            context.goNamed('home', extra: user);
            return HomeScreen(user: user);
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }

  Future _reload({User? user}) async {
    await user?.reload();
  }
}
