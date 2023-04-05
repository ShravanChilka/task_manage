import 'package:flutter/material.dart';
import 'package:task_manage/features/task/model/task_model.dart';

Future<DateTime?> getPickedDate({
  required BuildContext context,
  required TaskModel taskModel,
}) async {
  final dateTime = await showDatePicker(
    context: context,
    initialDate: taskModel.dateTime,
    firstDate: DateTime(taskModel.dateTime.year - 1),
    lastDate: DateTime(taskModel.dateTime.year + 1),
  );
  if (dateTime != null) {
    return dateTime;
  } else {
    return null;
  }
}
