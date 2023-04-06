import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';

class CustomPickerWidget extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;
  final void Function() onTap;
  const CustomPickerWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius * 2),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius * 2),
          border: Border.all(
            width: 2,
            color: Palette.neutral500,
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(defaultPadding),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Palette.neutral500,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: icon,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
