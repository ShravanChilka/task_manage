import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';

@immutable
abstract class TaskModelRemoteDataSourceInterface {
  Stream<QuerySnapshot<TaskModel>> getAll();
  Future<String> create({
    required TaskModel taskModel,
  });
  Future<String> update({
    required DocumentSnapshot doc,
    required TaskModel taskModel,
  });
  Future<String> delete({
    required DocumentSnapshot doc,
  });
}

@immutable
class TaskModelRemoteDataSource implements TaskModelRemoteDataSourceInterface {
  final FirebaseFirestore client;
  final User user;
  const TaskModelRemoteDataSource({
    required this.client,
    required this.user,
  });

  @override
  Future<String> create({
    required TaskModel taskModel,
  }) async {
    try {
      await client.collection(user.uid).add(
            taskModel.toJson(),
          );
      return 'Task Created Successfully!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  @override
  Future<String> delete({
    required DocumentSnapshot<Object?> doc,
  }) async {
    try {
      await client.collection(user.uid).doc(doc.id).delete();
      return 'Task deleted';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  @override
  Stream<QuerySnapshot<TaskModel>> getAll() {
    return client
        .collection(user.uid)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, options) => taskModel.toJson(),
        )
        .snapshots();
  }

  @override
  Future<String> update({
    required DocumentSnapshot<Object?> doc,
    required TaskModel taskModel,
  }) async {
    try {
      await client.collection(user.uid).doc(doc.id).set(taskModel.toJson());
      return 'Task updated!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}
