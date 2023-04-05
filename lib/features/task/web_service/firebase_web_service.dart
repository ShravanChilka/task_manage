import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/exceptions.dart';
import 'package:task_manage/features/task/model/task_model.dart';

@immutable
class FirebaseWebService {
  final FirebaseFirestore client;
  const FirebaseWebService({
    required this.client,
  });

  Future<String> create({
    required String uid,
    required TaskModel taskModel,
  }) async {
    try {
      await client.collection(uid).add(
            taskModel.toJson(),
          );
      return 'Task created!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  Future<String> delete({
    required String uid,
    required DocumentSnapshot<Object?> doc,
  }) async {
    try {
      await client.collection(uid).doc(doc.id).delete();
      return 'Task deleted!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

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

  Future<String> update({
    required DocumentSnapshot<TaskModel> doc,
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
