import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String title,
    required String description,
    required DateTime dateTime,
    required String type,
    required bool isNotificationEnabled,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) =>
      _$TaskModelFromJson(json);
}
