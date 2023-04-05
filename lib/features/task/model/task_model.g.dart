// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: $enumDecodeNullable(_$TaskTypeEnumMap, json['type']) ??
          TaskType.personal,
      isNotificationEnabled: json['isNotificationEnabled'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'type': _$TaskTypeEnumMap[instance.type]!,
      'isNotificationEnabled': instance.isNotificationEnabled,
      'isCompleted': instance.isCompleted,
    };

const _$TaskTypeEnumMap = {
  TaskType.personal: 'personal',
  TaskType.work: 'work',
};