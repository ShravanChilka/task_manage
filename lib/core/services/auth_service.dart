import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class AuthService {
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(authCredential);
  }
}
