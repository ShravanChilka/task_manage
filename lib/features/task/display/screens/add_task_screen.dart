// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:task_manage/common/widgets/custom_date_picker.dart';
import 'package:task_manage/common/widgets/custom_drop_down.dart';
import 'package:task_manage/common/widgets/custom_notification_widget.dart';
import 'package:task_manage/common/widgets/custom_text_field.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';
import 'package:task_manage/features/task/display/screens/widgets/custom_picker_widget.dart';

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
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    if (widget.documentSnapshot != null) {
      context.read<TaskProvider>().taskModel = widget.documentSnapshot!.data()!;
    }
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
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (widget.documentSnapshot != null) {
                              value
                                  .updateTask(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    doc: widget.documentSnapshot!,
                                  )
                                  .whenComplete(() => context.pop());
                            } else {
                              value
                                  .createTask(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                  )
                                  .whenComplete(() => context.pop());
                            }
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Palette.secondary500,
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          width: 48,
                          height: 48,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomTextField(
                    controller: _titleController..text = value.taskModel.title,
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
                      Flexible(
                        flex: 1,
                        child: CustomPickerWidget(
                          title: DateFormat('d MMM')
                              .format(value.taskModel.dateTime),
                          description: 'Pick Date',
                          icon: const Icon(
                            Icons.date_range,
                          ),
                          onTap: () {},
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
                              initialTime: TimeOfDay(
                                hour: value.taskModel.dateTime.hour,
                                minute: value.taskModel.dateTime.hour,
                              ),
                            );
                            if (time != null) {}
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: const [
                      Flexible(
                        flex: 1,
                        child: CustomNotificationWidget(
                          isEnabled: false,
                        ),
                      ),
                      SizedBox(
                        width: defaultPadding * 0.5,
                      ),
                      Flexible(
                        flex: 1,
                        child: CustomDropDown(),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomTextField(
                    controller: _descriptionController
                      ..text = value.taskModel.description,
                    hint: 'Enter description',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
