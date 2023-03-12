import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/connection/network_connection.dart';
import '../../../../core/errors/index.dart';
import '../data_source/task_remote_data_source.dart';
import '../../domain/repository/repository.dart';
import '../models/task_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskRepository implements TaskRepositoryInterface {
  final TaskModelRemoteDataSource remoteDataSource;
  final NetworkConnection networkConnection;
  const TaskRepository({
    required this.remoteDataSource,
    required this.networkConnection,
  });

  @override
  Future<Either<Failure, String>> create({
    required TaskModel taskModel,
  }) async {
    if (await networkConnection.isConnected()) {
      final response = await remoteDataSource.create(taskModel: taskModel);
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
  }) async {
    if (await networkConnection.isConnected()) {
      final response = await remoteDataSource.delete(doc: doc);
      return Right(response);
    } else {
      return const Left(
        NetworkFailure(),
      );
    }
  }

  @override
  Stream<QuerySnapshot<TaskModel>> getAll() {
    return remoteDataSource.getAll();
  }

  @override
  Future<Either<Failure, String>> update({
    required DocumentSnapshot<TaskModel> doc,
    required TaskModel taskModel,
  }) async {
    if (await networkConnection.isConnected()) {
      final response = await remoteDataSource.update(
        doc: doc,
        taskModel: taskModel,
      );
      return Right(response);
    } else {
      return const Left(
        NetworkFailure(),
      );
    }
  }
}
