import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/data/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository repository;
  final Stream<QuerySnapshot<TaskModel>> allTasks;
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
  }) : allTasks = repository.getAll();

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
      taskModel: TaskModel(
        title: title,
        description: description,
        dateTime: getDateTime(),
        type: type,
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
      taskModel: TaskModel(
        title: title,
        description: description,
        dateTime: getDateTime(),
        type: type,
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
