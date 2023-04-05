import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/utils/task_tile.dart';
import 'package:task_manage/features/task/view/task_screen.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class TaskListView extends StatelessWidget {
  final List<QueryDocumentSnapshot<TaskModel>> docList;
  const TaskListView({
    super.key,
    required this.docList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: docList.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskDoc: docList[index],
          onTap: (taskDoc) {
            context.read<TaskViewModel>().taskModel = taskDoc.data()!;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TaskScreen.update(taskDoc: taskDoc),
              ),
            );
          },
        );
      },
    );
  }
}
