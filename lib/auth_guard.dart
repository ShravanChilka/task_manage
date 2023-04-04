import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/display/screens/walkthrough_screen.dart';
import 'package:task_manage/features/task/display/screens/home_screen.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(
      builder: (context, user, child) {
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
                return const HomeScreen();
              } else {
                return const WalkthroughScreen();
              }
            }
          },
        );
      },
    );
  }

  Future _reload({User? user}) async {
    await user?.reload();
  }
}
