import 'dart:developer';
import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final user = await AuthService.signInWithGoogle();
                log(user.toString());
              },
              child: const Text('Google Login'),
            )
          ],
        ),
      ),
    );
  }
}
