import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/custom_drop_down.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class TaskTypeDropDownWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskTypeDropDownWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomDropDown(
        taskModel: taskModel,
        onChanged: (taskType) {
          if (taskType != null) {
            context.read<TaskViewModel>().taskModel = taskModel.copyWith(
              type: taskType,
            );
          }
        },
      ),
    );
  }
}
