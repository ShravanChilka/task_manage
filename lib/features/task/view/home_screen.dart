import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/utils/pop_up_menu_button.dart';
import 'package:task_manage/features/task/utils/task_list_view.dart';
import 'package:task_manage/features/task/view/task_screen.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: const [PopUpMenu()],
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
                  Selector<
                      TaskViewModel,
                      Tuple2<Stream<List<QueryDocumentSnapshot<TaskModel>>>,
                          Stream<List<QueryDocumentSnapshot<TaskModel>>>>>(
                    selector: (context, value) => Tuple2(
                      value.getAllNonCompleted(),
                      value.getAllCompleted(),
                    ),
                    builder: (context, tuple, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<List<QueryDocumentSnapshot<TaskModel>>>(
                            stream: tuple.value1,
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
                          ),
                          const SizedBox(height: defaultPadding),
                          Text(
                            'Completed Task',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: defaultPadding * 0.4),
                          StreamBuilder<List<QueryDocumentSnapshot<TaskModel>>>(
                            stream: tuple.value2,
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
