import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/web_service/firebase_web_service.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel() {
    _service = FirebaseStorageWebService(
      client: FirebaseAuth.instance,
      db: FirebaseFirestore.instance,
    );
    _taskModel = TaskModel(dateTime: DateTime.now());
  }

  late final FirebaseStorageWebService _service;
  late TaskModel _taskModel;

  set taskModel(TaskModel value) {
    _taskModel = value;
    notifyListeners();
  }

  TaskModel get taskModel => _taskModel;

  Stream<QuerySnapshot<TaskModel>> getAll() => _service.getAll();

  Future<String> create() => _service.create(
        taskModel: taskModel,
      );

  Future<String> update({
    required DocumentSnapshot<TaskModel> doc,
  }) =>
      _service.update(
        doc: doc,
        taskModel: taskModel,
      );

  Future<String> delete({
    required DocumentSnapshot<TaskModel> doc,
  }) =>
      _service.delete(
        doc: doc,
      );
}
