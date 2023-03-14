import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';

class HomeScreenTest extends StatelessWidget {
  const HomeScreenTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Tasks',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  '3 tasks for today',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  'Pending Task',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: defaultPadding * 0.4),
                Consumer<TaskProvider>(
                  builder: (context, value, child) {
                    return StreamBuilder<QuerySnapshot<TaskModel>>(
                      stream: value.allTasks,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        if (snapshot.hasData) {
                          final data = snapshot.requireData;
                          return TaskListView(docList: data.docs);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          taskModel: docList[index].data(),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final TaskModel taskModel;
  const TaskTile({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.4),
      child: InkWell(
        splashColor: Palette.red,
        onTap: () {},
        borderRadius: BorderRadius.circular(defaultRadius * 2),
        child: Ink(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius * 2),
            color: taskModel.type.color,
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
                    taskModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    taskModel.title,
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
                  DateFormat('HH : MM').format(taskModel.dateTime),
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
