import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/web_service/firebase_web_service.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel() {
    _service = FirebaseWebService(
      client: FirebaseFirestore.instance,
    );
    _taskModel = TaskModel(dateTime: DateTime.now());
  }

  late final FirebaseWebService _service;
  String? _uid;
  late TaskModel _taskModel;

  set taskModel(TaskModel value) {
    _taskModel = value;
    notifyListeners();
  }

  String? get uid => _uid;

  set uid(String? value) {
    _uid = value;
    notifyListeners();
  }

  TaskModel get taskModel => _taskModel;

  Stream<QuerySnapshot<TaskModel>> getAll() => _service.getAll(
        uid: uid!,
      );

  Future<String> create() => _service.create(
        uid: uid!,
        taskModel: taskModel,
      );

  Future<String> update({
    required DocumentSnapshot<TaskModel> doc,
  }) =>
      _service.update(
        doc: doc,
        taskModel: taskModel,
        uid: uid!,
      );

  Future<String> delete({
    required DocumentSnapshot<TaskModel> doc,
  }) =>
      _service.delete(
        doc: doc,
        uid: uid!,
      );
}
