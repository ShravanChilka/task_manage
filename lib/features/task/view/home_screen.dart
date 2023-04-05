import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/utils/task_list_view.dart';
import 'package:task_manage/features/task/view/task_screen.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskScreen.create(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
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
                  Selector<TaskViewModel, Stream<QuerySnapshot<TaskModel>>>(
                    selector: (context, value) => value.getAll(),
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
      ),
    );
  }
}
