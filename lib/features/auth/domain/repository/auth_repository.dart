import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/index.dart';

@immutable
abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signInWithGoogle();
  Future<Either<Failure, User?>> getUser();
}
