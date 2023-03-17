import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import '../../domain/repository/repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository repository;
  late final User user;
  late final Stream<QuerySnapshot<TaskModel>> allTasks;

  TaskModel _taskModel = TaskModel(
    title: '',
    description: '',
    dateTime: DateTime.now(),
    type: TaskType.personal,
    isNotificationEnabled: false,
    isCompleted: false,
  );

  TaskModel get taskModel => _taskModel;

  set taskModel(TaskModel value) {
    _taskModel = value;
    notifyListeners();
  }

  TaskProvider({
    required this.repository,
  });

  void init({
    required User user,
  }) {
    this.user = user;
    allTasks = repository.getAll(uid: user.uid);
  }

  Future<String> createTask() async {
    final response = await repository.create(
      uid: user.uid,
      taskModel: _taskModel,
    );
    return response.fold(
      (faliure) {
        return faliure.error;
      },
      (success) {
        return success;
      },
    );
  }

  Future<String> updateTask({
    required doc,
  }) async {
    final response = await repository.update(
      uid: user.uid,
      taskModel: _taskModel,
      doc: doc,
    );
    return response.fold(
      (faliure) {
        return faliure.error;
      },
      (success) {
        return success;
      },
    );
  }

  Future<String> deleteTask({
    required DocumentSnapshot<TaskModel> doc,
  }) async {
    final response = await repository.delete(
      uid: user.uid,
      doc: doc,
    );
    return response.fold(
      (faliure) {
        return faliure.error;
      },
      (success) {
        return success;
      },
    );
  }
}
