import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manage/config/style/styles.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String title,
    required String description,
    required DateTime dateTime,
    required TaskType type,
    required bool isNotificationEnabled,
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
