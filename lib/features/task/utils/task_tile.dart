import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';

class TaskTile extends StatelessWidget {
  final DocumentSnapshot<TaskModel> taskDoc;
  final void Function(DocumentSnapshot<TaskModel> taskDoc) onTap;
  const TaskTile({
    Key? key,
    required this.taskDoc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.4),
      child: InkWell(
        splashColor: Palette.red,
        onTap: () => onTap(taskDoc),
        borderRadius: BorderRadius.circular(defaultRadius * 2),
        child: Ink(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius * 2),
            color: taskDoc.data()!.type.color,
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(defaultPadding),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Palette.neutral300,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: const Icon(
                  Icons.work_outline,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskDoc.data()!.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    taskDoc.data()!.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(defaultPadding),
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.4,
                  horizontal: defaultPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color: Palette.neutral300,
                ),
                child: Text(
                  DateFormat('HH : MM').format(taskDoc.data()!.dateTime),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
