import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/index.dart';
import '../../../../core/network/network_info.dart';
import '../data_source/task_remote_data_source.dart';
import '../../domain/repository/repository.dart';
import '../models/task_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskRepositoryImpl implements TaskRepository {
  final TaskModelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> create({
    required TaskModel taskModel,
    required String uid,
  }) async {
    if (await networkInfo.isConnected()) {
      final response =
          await remoteDataSource.create(taskModel: taskModel, uid: uid);
      return Right(response);
    } else {
      return const Left(
        NetworkFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, String>> delete({
    required DocumentSnapshot<TaskModel> doc,
    required String uid,
  }) async {
    if (await networkInfo.isConnected()) {
      final response = await remoteDataSource.delete(doc: doc, uid: uid);
      return Right(response);
    } else {
      return const Left(
        NetworkFailure(),
      );
    }
  }

  @override
  Stream<QuerySnapshot<TaskModel>> getAll({
    required String uid,
  }) {
    return remoteDataSource.getAll(uid: uid);
  }

  @override
  Future<Either<Failure, String>> update({
    required DocumentSnapshot<TaskModel> doc,
    required TaskModel taskModel,
    required String uid,
  }) async {
    if (await networkInfo.isConnected()) {
      final response = await remoteDataSource.update(
          doc: doc, taskModel: taskModel, uid: uid);
      return Right(response);
    } else {
      return const Left(
        NetworkFailure(),
      );
    }
  }
}
