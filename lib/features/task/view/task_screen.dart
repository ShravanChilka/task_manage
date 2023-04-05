import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';
import 'package:task_manage/features/task/utils/custom_drop_down.dart';
import 'package:task_manage/features/task/utils/custom_floating_action_button.dart';
import 'package:task_manage/features/task/utils/custom_picker_widget.dart';
import 'package:task_manage/features/task/utils/custom_switch_widget.dart';
import 'package:task_manage/features/task/utils/custom_text_field.dart';
import 'package:task_manage/features/task/utils/helper_fuctions.dart';
import 'package:task_manage/features/task/view_model/task_view_model.dart';

enum TaskScreenEvent {
  create,
  update,
}

extension GetName on TaskScreenEvent {
  String get name {
    switch (this) {
      case TaskScreenEvent.create:
        return 'Create';
      case TaskScreenEvent.update:
        return 'Update';
    }
  }
}

class TaskScreen extends StatefulWidget {
  late final TaskScreenEvent event;
  final DocumentSnapshot<TaskModel>? taskDoc;

  TaskScreen.update({
    Key? key,
    required this.taskDoc,
  }) : super(key: key) {
    event = TaskScreenEvent.update;
  }

  TaskScreen.create({
    Key? key,
    this.taskDoc,
  }) : super(key: key) {
    event = TaskScreenEvent.create;
  }

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
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Visibility(
                visible: widget.event == TaskScreenEvent.update,
                child: CustomFloatingActionButton(
                  backgroundColor: Palette.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    viewModel.delete(doc: widget.taskDoc!);
                  },
                ),
              ),
              const SizedBox(width: defaultPadding * 0.4),
              CustomFloatingActionButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    switch (widget.event) {
                      case TaskScreenEvent.create:
                        viewModel.create();
                        break;
                      case TaskScreenEvent.update:
                        viewModel.update(doc: widget.taskDoc!);
                        break;
                    }
                  }
                },
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
                          Expanded(
                            flex: 1,
                            child: CustomPickerWidget(
                              title: DateFormat('d MMM')
                                  .format(viewModel.taskModel.dateTime),
                              description: 'Pick Date',
                              icon: const Icon(
                                Icons.date_range,
                              ),
                              onTap: () async {
                                final dateTime = await getPickedDate(
                                  context: context,
                                  taskModel: viewModel.taskModel,
                                );
                                if (dateTime != null) {
                                  viewModel.taskModel =
                                      viewModel.taskModel.copyWith(
                                    dateTime:
                                        viewModel.taskModel.dateTime.copyWith(
                                      year: dateTime.year,
                                      month: dateTime.month,
                                      day: dateTime.day,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding * 0.5,
                          ),
                          Flexible(
                            flex: 1,
                            child: CustomPickerWidget(
                              title: DateFormat('HH : mm')
                                  .format(viewModel.taskModel.dateTime),
                              description: 'Pick Time',
                              icon: const Icon(Icons.access_time),
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                    viewModel.taskModel.dateTime,
                                  ),
                                );
                                if (time != null) {
                                  viewModel.taskModel =
                                      viewModel.taskModel.copyWith(
                                    dateTime:
                                        viewModel.taskModel.dateTime.copyWith(
                                      hour: time.hour,
                                      minute: time.minute,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: CustomSwitchWidget(
                              activeIcon:
                                  const Icon(Icons.notifications_active_sharp),
                              inactiveIcon:
                                  const Icon(Icons.notifications_off_outlined),
                              isTrue: viewModel.taskModel.isNotificationEnabled,
                              onTap: () {
                                viewModel.taskModel =
                                    viewModel.taskModel.copyWith(
                                  isNotificationEnabled: !viewModel
                                      .taskModel.isNotificationEnabled,
                                );
                              },
                              description: 'Notification',
                              title: viewModel.taskModel.isNotificationEnabled
                                  ? 'Enabled'
                                  : 'Disabled',
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding * 0.5,
                          ),
                          Expanded(
                            child: CustomDropDown(
                              taskModel: viewModel.taskModel,
                              onChanged: (taskType) {
                                if (taskType != null) {
                                  viewModel.taskModel =
                                      viewModel.taskModel.copyWith(
                                    type: taskType,
                                  );
                                }
                              },
                            ),
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
                      CustomSwitchWidget(
                        isTrue: viewModel.taskModel.isCompleted,
                        title: viewModel.taskModel.isCompleted
                            ? 'Completed'
                            : 'Pending',
                        description: 'Status',
                        onTap: () {
                          viewModel.taskModel = viewModel.taskModel.copyWith(
                            isCompleted: !viewModel.taskModel.isCompleted,
                          );
                        },
                        activeIcon: const Icon(Icons.check),
                        inactiveIcon: const Icon(Icons.close),
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
}
