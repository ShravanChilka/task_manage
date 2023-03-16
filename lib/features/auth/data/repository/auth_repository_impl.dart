import 'package:flutter/foundation.dart' show immutable;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/index.dart';
import '../../../../core/network/network_info.dart';
import '../../data/data_source/auth_remote_data_source.dart';
import '../../domain/repository/auth_repository.dart';

@immutable
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User?>> getUser() async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(remoteDataSource.getUser());
      } on RemoteException catch (e) {
        return Left(RemoteFailure(error: e.error));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await remoteDataSource.signInWithGoogle());
      } on RemoteException catch (e) {
        return Left(RemoteFailure(error: e.error));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await remoteDataSource.deleteAccount());
      } on RemoteException catch (e) {
        return Left(RemoteFailure(error: e.error));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    if (await networkInfo.isConnected()) {
      try {
        return Right(await remoteDataSource.logout());
      } on RemoteException catch (e) {
        return Left(RemoteFailure(error: e.error));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
