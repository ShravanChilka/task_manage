import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/auth/view/walkthrough_screen.dart';
import 'package:task_manage/features/auth/view_model/auth_view_model.dart';
import 'package:task_manage/features/task/view/home_screen/home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.user != null) {
          return const HomeScreen();
        } else {
          return const WalkthroughScreen();
        }
      },
    );
  }
}
