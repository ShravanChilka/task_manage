import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import '../../domain/repository/repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository repository;
  late final User user;
  late final Stream<QuerySnapshot<TaskModel>> allTasks;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  DateTime get date => _date;
  TimeOfDay get time => _time;
  String type = 'Personal';
  bool isNotificationEnabled = true;

  set timeOfDay(TimeOfDay value) {
    _time = value;
    notifyListeners();
  }

  set dateTime(DateTime value) {
    _date = value;
    notifyListeners();
  }

  TaskProvider({
    required this.repository,
  });

  void init({
    required User user,
  }) {
    user = user;
    allTasks = repository.getAll(uid: user.uid);
  }

  DateTime getDateTime() {
    return date.copyWith(
      hour: time.hour,
      minute: time.minute,
    );
  }

  Future<String> createTask({
    required String title,
    required String description,
  }) async {
    final response = await repository.create(
      uid: user.uid,
      taskModel: TaskModel(
        title: title,
        description: description,
        dateTime: getDateTime(),
        type: TaskType.personal,
        isNotificationEnabled: isNotificationEnabled,
      ),
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
    required DocumentSnapshot<TaskModel> doc,
    required String title,
    required String description,
  }) async {
    final response = await repository.update(
      uid: user.uid,
      taskModel: TaskModel(
        title: title,
        description: description,
        dateTime: getDateTime(),
        type: TaskType.personal,
        isNotificationEnabled: isNotificationEnabled,
      ),
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
    required String title,
    required String description,
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
