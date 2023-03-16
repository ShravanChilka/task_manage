import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage/config/style/styles.dart';
import 'package:task_manage/features/task/data/models/task_model.dart';
import 'package:task_manage/features/task/display/providers/task_provider.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          color: value.taskModel.type.color,
          borderRadius: BorderRadius.circular(defaultRadius * 2),
        ),
        child: DropdownButton<TaskType>(
          underline: const SizedBox.shrink(),
          selectedItemBuilder: (context) => [
            DropdownMenuItem<TaskType>(
              value: value.taskModel.type,
              child: CustomDropDownItem(
                showType: true,
                title: value.taskModel.type.name,
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
          onChanged: (item) {
            if (item != null) {
              switch (item) {
                case TaskType.personal:
                  value.taskModel = value.taskModel.copyWith(
                    type: item,
                  );
                  break;
                case TaskType.work:
                  value.taskModel = value.taskModel.copyWith(
                    type: item,
                  );
                  break;
              }
            }
          },
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
