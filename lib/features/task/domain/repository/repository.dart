import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';

@immutable
abstract class TaskRepositoryInterface {
  Stream<QuerySnapshot<TaskModel>> getAll();
  Future<Either<Failure, String>> update({
    required DocumentSnapshot<TaskModel> doc,
    required TaskModel taskModel,
  });
  Future<Either<Failure, String>> create({
    required TaskModel taskModel,
  });
  Future<Either<Failure, String>> delete({
    required DocumentSnapshot<TaskModel> doc,
  });
}
