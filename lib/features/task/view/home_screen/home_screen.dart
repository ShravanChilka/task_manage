import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/utils/pop_up_menu_button.dart';
import 'package:task_manage/features/task/view/home_screen/widgets/completed_task_list_widget.dart';
import 'package:task_manage/features/task/view/home_screen/widgets/non_completed_task_list_widget.dart';
import 'package:task_manage/features/task/view/task_screen/task_screen.dart';

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
        onPressed: () => createTaskEvent(context),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: defaultPadding),
                NonCompletedTaskListWidget(),
                SizedBox(height: defaultPadding),
                CompletedTaskListWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createTaskEvent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TaskScreen.create(),
      ),
    );
  }
}
