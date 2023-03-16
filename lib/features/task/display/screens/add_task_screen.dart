import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/common/functions/utils.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_drop_down.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_icon_button.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_notification_widget.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_picker_widget.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_switch_tile.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  final DocumentSnapshot<TaskModel>? documentSnapshot;
  const AddTaskScreen({
    Key? key,
    this.documentSnapshot,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.documentSnapshot?.data()?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.documentSnapshot?.data()?.description ?? '',
    );
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.documentSnapshot.toString());
    return Consumer<TaskProvider>(
      builder: (context, value, _) => Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.documentSnapshot == null ? 'Create' : 'Update',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const Spacer(),
                        widget.documentSnapshot != null
                            ? CustomIconButton(
                                backgroundColor: Palette.red,
                                onTap: () async {
                                  await value
                                      .deleteTask(doc: widget.documentSnapshot!)
                                      .then((value) {
                                    showSnackBar(context: context, text: value);
                                    context.pop();
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Palette.secondary500,
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          width: defaultPadding / 2,
                        ),
                        CustomIconButton(
                          onTap: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (widget.documentSnapshot != null) {
                                await value
                                    .updateTask(
                                  doc: widget.documentSnapshot!,
                                )
                                    .then((value) {
                                  showSnackBar(context: context, text: value);
                                  context.pop();
                                });
                              } else {
                                await value.createTask().then(
                                  (value) {
                                    showSnackBar(context: context, text: value);
                                    context.pop();
                                  },
                                );
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Palette.neutral300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomTextField(
                      onChanged: (text) {
                        value.taskModel = value.taskModel.copyWith(title: text);
                      },
                      controller: _titleController,
                      hint: 'Enter title',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
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
                                .format(value.taskModel.dateTime),
                            description: 'Pick Date',
                            icon: const Icon(
                              Icons.date_range,
                            ),
                            onTap: () async {
                              final dateTime = await showDatePicker(
                                context: context,
                                initialDate: value.taskModel.dateTime,
                                firstDate: DateTime(
                                  value.taskModel.dateTime.year - 1,
                                ),
                                lastDate: DateTime(
                                  value.taskModel.dateTime.year + 1,
                                ),
                              );
                              if (dateTime != null) {
                                value.taskModel = value.taskModel.copyWith(
                                  dateTime: value.taskModel.dateTime.copyWith(
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
                                .format(value.taskModel.dateTime),
                            description: 'Pick Time',
                            icon: const Icon(Icons.access_time),
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                  value.taskModel.dateTime,
                                ),
                              );
                              if (time != null) {
                                value.taskModel = value.taskModel.copyWith(
                                  dateTime: value.taskModel.dateTime.copyWith(
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
                            isTrue: value.taskModel.isNotificationEnabled,
                            onTap: () {
                              value.taskModel = value.taskModel.copyWith(
                                isNotificationEnabled:
                                    !value.taskModel.isNotificationEnabled,
                              );
                            },
                            description: 'Notification',
                            title: value.taskModel.isNotificationEnabled
                                ? 'Enabled'
                                : 'Disabled',
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding * 0.5,
                        ),
                        const Expanded(
                          child: CustomDropDown(),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomTextField(
                      onChanged: (text) {
                        value.taskModel =
                            value.taskModel.copyWith(description: text);
                      },
                      controller: _descriptionController,
                      hint: 'Enter description',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: defaultPadding),
                    CustomSwitchWidget(
                      isTrue: value.taskModel.isCompleted,
                      title:
                          value.taskModel.isCompleted ? 'Completed' : 'Pending',
                      description: 'Status',
                      onTap: () {
                        value.taskModel = value.taskModel.copyWith(
                          isCompleted: !value.taskModel.isCompleted,
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
      ),
    );
  }
}
