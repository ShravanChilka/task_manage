// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manage/core/errors/index.dart';

@immutable
abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  User? getUser();
}

@immutable
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  const AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
  });

  @override
  User? getUser() => firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? auth = await user?.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(authCredential);
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}
