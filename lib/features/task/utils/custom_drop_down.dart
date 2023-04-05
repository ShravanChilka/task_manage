import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/task/model/task_model.dart';

class CustomDropDown extends StatelessWidget {
  final TaskModel taskModel;
  final void Function(TaskType? taskType)? onChanged;
  const CustomDropDown({
    Key? key,
    required this.taskModel,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: taskModel.type.color,
        borderRadius: BorderRadius.circular(defaultRadius * 2),
      ),
      child: DropdownButton<TaskType>(
        underline: const SizedBox.shrink(),
        selectedItemBuilder: (context) => [
          DropdownMenuItem<TaskType>(
            value: taskModel.type,
            child: CustomDropDownItem(
              showType: true,
              title: taskModel.type.name,
            ),
          ),
        ],
        value: TaskType.personal,
        borderRadius: BorderRadius.circular(defaultRadius * 2),
        icon: const Padding(
          padding: EdgeInsets.all(defaultPadding * 0.5),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        style: const TextStyle(color: Colors.deepPurple),
        itemHeight: null,
        onChanged: onChanged,
        items: const [
          DropdownMenuItem<TaskType>(
            value: TaskType.personal,
            child: CustomDropDownItem(
              title: 'Personal',
            ),
          ),
          DropdownMenuItem<TaskType>(
            value: TaskType.work,
            child: CustomDropDownItem(
              title: 'Work',
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDownItem extends StatelessWidget {
  final bool showType;
  final String title;
  const CustomDropDownItem({
    Key? key,
    required this.title,
    this.showType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(defaultPadding),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: showType ? Palette.neutral300 : Palette.neutral500,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: const Icon(Icons.person),
        ),
        showType
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ],
    );
  }
}
