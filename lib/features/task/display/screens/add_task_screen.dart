import 'package:flutter/material.dart';
import 'package:task_manage/common/widgets/custom_date_picker.dart';
import 'package:task_manage/common/widgets/custom_drop_down.dart';
import 'package:task_manage/common/widgets/custom_notification_widget.dart';
import 'package:task_manage/common/widgets/custom_text_field.dart';
import 'package:task_manage/config/style/styles.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onTap: () {},
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
                controller: TextEditingController(),
                hint: 'Enter title',
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: const [
                  Flexible(
                    flex: 1,
                    child: CustomDatePicker(),
                  ),
                  SizedBox(
                    width: defaultPadding * 0.5,
                  ),
                  Flexible(
                    flex: 1,
                    child: CustomDatePicker(),
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
                controller: TextEditingController(),
                hint: 'Enter description',
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
