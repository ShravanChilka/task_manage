import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manage/core/errors/index.dart';

@immutable
class FirebaseAuthWebService {
  final FirebaseAuth client;
  const FirebaseAuthWebService({
    required this.client,
  });

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? auth = await user?.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );
      return await client.signInWithCredential(authCredential);
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      await client.currentUser?.delete();
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await client.signOut();
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}
