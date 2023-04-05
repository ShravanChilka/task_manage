import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manage/config/styles.dart';
part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    @Default('') String title,
    @Default('') String description,
    required DateTime dateTime,
    @Default(TaskType.personal) TaskType type,
    @Default(false) bool isNotificationEnabled,
    @Default(false) bool isCompleted,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) =>
      _$TaskModelFromJson(json);
}

enum TaskType {
  personal,
  work,
}

extension GetColor on TaskType {
  Color get color {
    switch (this) {
      case TaskType.personal:
        return Palette.blue;
      case TaskType.work:
        return Palette.orange;
    }
  }
}

extension GetName on TaskType {
  String get name {
    switch (this) {
      case TaskType.personal:
        return 'Personal';
      case TaskType.work:
        return 'Work';
    }
  }
}
