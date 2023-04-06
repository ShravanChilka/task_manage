import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/common/widgets/custom_floating_action_button.dart';
import 'package:task_manage/features/task/utils/custom_text_field.dart';
import 'package:task_manage/features/task/utils/extensions.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/date_picker_widget.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/notification_switch_widget.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/task_status_switch_widget.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/task_type_drop_down_widget.dart';
import 'package:task_manage/features/task/view/task_screen/widgets/time_picker_widget.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

class TaskScreen extends StatefulWidget {
  final TaskScreenEvent event;
  final DocumentSnapshot<TaskModel>? taskDoc;

  const TaskScreen.update({
    Key? key,
    required this.taskDoc,
  })  : event = TaskScreenEvent.update,
        super(key: key);

  const TaskScreen.create({
    Key? key,
    this.taskDoc,
  })  : event = TaskScreenEvent.create,
        super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _titleController.text =
        Provider.of<TaskViewModel>(context, listen: false).taskModel.title;
    _descriptionController.text =
        Provider.of<TaskViewModel>(context, listen: false)
            .taskModel
            .description;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.event.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            actions: [
              Visibility(
                visible: widget.event == TaskScreenEvent.update,
                child: CustomFloatingActionButton(
                  tag: 'delete',
                  backgroundColor: Palette.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteClickEvent(viewModel),
                ),
              ),
              const SizedBox(width: defaultPadding * 0.4),
              CustomFloatingActionButton(
                tag: 'check',
                icon: const Icon(Icons.check),
                onPressed: () => saveClickEvent(viewModel),
              ),
              const SizedBox(width: defaultPadding * 0.4),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        onChanged: (text) {
                          viewModel.taskModel =
                              viewModel.taskModel.copyWith(title: text);
                        },
                        controller: _titleController,
                        hint: 'Enter title',
                        validator: (viewModel) {
                          if (viewModel != null && viewModel.isEmpty) {
                            return 'Please enter the title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          DatePickerWidget(taskModel: viewModel.taskModel),
                          const SizedBox(width: defaultPadding * 0.5),
                          TimePickerWidget(taskModel: viewModel.taskModel),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          NotificationSwitchWidget(
                            taskModel: viewModel.taskModel,
                          ),
                          const SizedBox(width: defaultPadding * 0.5),
                          TaskTypeDropDownWidget(
                            taskModel: viewModel.taskModel,
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        onChanged: (text) {
                          viewModel.taskModel =
                              viewModel.taskModel.copyWith(description: text);
                        },
                        controller: _descriptionController,
                        hint: 'Enter description',
                        validator: (viewModel) {
                          if (viewModel != null && viewModel.isEmpty) {
                            return 'Please enter the title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),
                      TaskStatusSwitchWidget(
                        taskModel: viewModel.taskModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void saveClickEvent(TaskViewModel viewModel) {
    if (_formKey.currentState?.validate() ?? false) {
      switch (widget.event) {
        case TaskScreenEvent.create:
          viewModel.create().whenComplete(() => Navigator.of(context).pop());

          break;
        case TaskScreenEvent.update:
          viewModel
              .update(doc: widget.taskDoc!)
              .whenComplete(() => Navigator.of(context).pop());

          break;
      }
    }
  }

  void deleteClickEvent(TaskViewModel viewModel) {
    viewModel
        .delete(doc: widget.taskDoc!)
        .whenComplete(() => Navigator.of(context).pop());
  }
}
