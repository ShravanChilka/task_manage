import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../auth/display/provider/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, state, child) {
        // if (state.user != null) {
        //   AppRouter.router.goNamed(Pages.home.screenName, extra: state.user!);
        // }
        if (state.failure != null) {
          log(state.failure!.error.toString());
        }
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                state.signInWithGoogle();
              },
              child: const Text('Login with google'),
            ),
          ),
        );
      },
    );
  }
}
