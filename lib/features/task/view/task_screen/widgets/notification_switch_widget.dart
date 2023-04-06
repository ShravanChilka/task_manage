// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/custom_switch_widget.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class NotificationSwitchWidget extends StatelessWidget {
  final TaskModel taskModel;
  const NotificationSwitchWidget({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomSwitchWidget(
        activeIcon: const Icon(Icons.notifications_active_sharp),
        inactiveIcon: const Icon(Icons.notifications_off_outlined),
        isTrue: taskModel.isNotificationEnabled,
        onTap: () {
          context.read<TaskViewModel>().taskModel = taskModel.copyWith(
            isNotificationEnabled: !taskModel.isNotificationEnabled,
          );
        },
        description: 'Notification',
        title: taskModel.isNotificationEnabled ? 'Enabled' : 'Disabled',
      ),
    );
  }
}
