import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:task_manage/core/errors/exceptions.dart';
import 'package:task_manage/features/task/model/task_model.dart';

@immutable
class FirebaseStorageWebService {
  final FirebaseAuth client;
  final FirebaseFirestore db;
  const FirebaseStorageWebService({
    required this.client,
    required this.db,
  });

  Future<String> create({
    required TaskModel taskModel,
  }) async {
    try {
      await db.collection(client.currentUser!.uid).add(
            taskModel.toJson(),
          );
      return 'Task created!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  Future<String> delete({
    required DocumentSnapshot<Object?> doc,
  }) async {
    try {
      await db.collection(client.currentUser!.uid).doc(doc.id).delete();
      return 'Task deleted!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }

  Stream<List<QueryDocumentSnapshot<TaskModel>>> getAllCompleted() {
    return db
        .collection(client.currentUser!.uid)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, options) => taskModel.toJson(),
        )
        .snapshots()
        .map(
          (e) => e.docs
              .where((element) => element.data().isCompleted == true)
              .toList(),
        );
  }

  Stream<List<QueryDocumentSnapshot<TaskModel>>> getAllNonCompleted() {
    return db
        .collection(client.currentUser!.uid)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, options) => taskModel.toJson(),
        )
        .snapshots()
        .map(
          (e) => e.docs
              .where((element) => element.data().isCompleted == false)
              .toList(),
        );
  }

  Future<String> update({
    required DocumentSnapshot<TaskModel> doc,
    required TaskModel taskModel,
  }) async {
    try {
      await db
          .collection(client.currentUser!.uid)
          .doc(doc.id)
          .set(taskModel.toJson());
      return 'Task updated!';
    } catch (e) {
      throw RemoteException(error: e.toString());
    }
  }
}
