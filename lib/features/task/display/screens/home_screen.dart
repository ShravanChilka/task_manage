import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/routes/app_router.dart';
import 'package:task_manage/config/routes/app_routes.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';
import 'package:task_manage/features/task/display/screens/add_task_screen.dart';
import 'widgets/pop_up_menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: const [
          PopUpMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
        },
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
                const SizedBox(height: defaultPadding),
                Text(
                  'Pending Task',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: defaultPadding * 0.4),
                Selector<TaskProvider, Stream<QuerySnapshot<TaskModel>>>(
                  selector: (context, value) => value.allTasks,
                  builder: (context, allTasks, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<QuerySnapshot<TaskModel>>(
                          stream: allTasks,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.hasData) {
                              final data = snapshot.requireData.docs
                                  .where(
                                    (element) =>
                                        element.data().isCompleted == false,
                                  )
                                  .toList();
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
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                          'Completed Task',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: defaultPadding * 0.4),
                        StreamBuilder<QuerySnapshot<TaskModel>>(
                          stream: allTasks,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.hasData) {
                              final data = snapshot.requireData.docs
                                  .where(
                                    (element) =>
                                        element.data().isCompleted == true,
                                  )
                                  .toList();
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
                        ),
                      ],
                    );
                  },
                ),
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
          taskDoc: docList[index],
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final DocumentSnapshot<TaskModel> taskDoc;
  const TaskTile({
    Key? key,
    required this.taskDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.4),
      child: InkWell(
        splashColor: Palette.red,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(documentSnapshot: taskDoc),
            ),
          );
        },
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
