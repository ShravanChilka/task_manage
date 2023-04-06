import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/utils/helper_fuctions.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/custom_picker_widget.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class DatePickerWidget extends StatelessWidget {
  final TaskModel taskModel;
  const DatePickerWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPickerWidget(
        title: DateFormat('d MMM').format(taskModel.dateTime),
        description: 'Pick Date',
        icon: const Icon(
          Icons.date_range,
        ),
        onTap: () async {
          final dateTime = await getPickedDate(
            context: context,
            taskModel: taskModel,
          ).then((dateTime) {
            if (dateTime != null) {
              context.read<TaskViewModel>().taskModel = taskModel.copyWith(
                dateTime: taskModel.dateTime.copyWith(
                  year: dateTime.year,
                  month: dateTime.month,
                  day: dateTime.day,
                ),
              );
            }
          });
        },
      ),
    );
  }
}
