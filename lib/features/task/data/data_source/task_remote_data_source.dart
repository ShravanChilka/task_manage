import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/index.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';

@immutable
abstract class TaskModelRemoteDataSource {
  Stream<QuerySnapshot<TaskModel>> getAll({
    required String uid,
  });
  Future<String> create({
    required TaskModel taskModel,
    required String uid,
  });
  Future<String> update({
    required DocumentSnapshot doc,
    required TaskModel taskModel,
    required String uid,
  });
  Future<String> delete({
    required DocumentSnapshot doc,
    required String uid,
  });
}

@immutable
class TaskModelRemoteDataSourceImpl implements TaskModelRemoteDataSource {
  final FirebaseFirestore client;
  const TaskModelRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<String> create({
    required String uid,
    required TaskModel taskModel,
  }) async {
    try {
      await client.collection(uid).add(
            taskModel.toJson(),
          );
      return 'Task Created Successfully!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  @override
  Future<String> delete({
    required String uid,
    required DocumentSnapshot<Object?> doc,
  }) async {
    try {
      await client.collection(uid).doc(doc.id).delete();
      return 'Task deleted';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  @override
  Stream<QuerySnapshot<TaskModel>> getAll({
    required String uid,
  }) {
    return client
        .collection(uid)
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
    required String uid,
  }) async {
    try {
      await client.collection(uid).doc(doc.id).set(taskModel.toJson());
      return 'Task updated!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}
