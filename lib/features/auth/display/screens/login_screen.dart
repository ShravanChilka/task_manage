import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/routes/app_router.dart';
import '../../../../config/routes/routes.dart';
import '../../../auth/display/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    if (context.read<AuthProvider>().user != null) {
      context.goNamed(Pages.home.screenName);
    }
    super.initState();
  }

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
