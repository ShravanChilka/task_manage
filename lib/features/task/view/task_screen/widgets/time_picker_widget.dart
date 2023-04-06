import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/custom_picker_widget.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class TimePickerWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TimePickerWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPickerWidget(
        title: DateFormat('HH : mm').format(taskModel.dateTime),
        description: 'Pick Time',
        icon: const Icon(Icons.access_time),
        onTap: () async {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(
              taskModel.dateTime,
            ),
          ).then(
            (time) {
              if (time != null) {
                context.read<TaskViewModel>().taskModel = taskModel.copyWith(
                  dateTime: taskModel.dateTime.copyWith(
                    hour: time.hour,
                    minute: time.minute,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
