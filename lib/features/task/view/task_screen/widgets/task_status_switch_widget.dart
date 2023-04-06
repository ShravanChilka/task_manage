import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/custom_switch_widget.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class TaskStatusSwitchWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskStatusSwitchWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSwitchWidget(
      isTrue: taskModel.isCompleted,
      title: taskModel.isCompleted ? 'Completed' : 'Pending',
      description: 'Status',
      onTap: () {
        context.read<TaskViewModel>().taskModel = taskModel.copyWith(
          isCompleted: !taskModel.isCompleted,
        );
      },
      activeIcon: const Icon(Icons.check),
      inactiveIcon: const Icon(Icons.close),
    );
  }
}
