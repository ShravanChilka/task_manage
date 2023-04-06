import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/view/home_screen/widgets/task_list_view.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class CompletedTaskListWidget extends StatelessWidget {
  const CompletedTaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed Task',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: defaultPadding * 0.4),
        Selector<TaskViewModel, Stream<List<QueryDocumentSnapshot<TaskModel>>>>(
          selector: (_, viewModel) => viewModel.getAllCompleted(),
          builder: (_, value, __) {
            return StreamBuilder<List<QueryDocumentSnapshot<TaskModel>>>(
              stream: value,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  if (data.isEmpty) {
                    return const Text('No results found');
                  }
                  return TaskListView(docList: data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
