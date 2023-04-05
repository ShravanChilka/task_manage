import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';

class CustomSwitchWidget extends StatelessWidget {
  final Icon activeIcon;
  final Icon inactiveIcon;
  final bool isTrue;
  final String title;
  final String description;
  final void Function() onTap;
  const CustomSwitchWidget({
    Key? key,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.isTrue,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius * 2),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: isTrue ? Palette.green : Palette.red,
          borderRadius: BorderRadius.circular(defaultRadius * 2),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(defaultPadding),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Palette.neutral300,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: isTrue ? activeIcon : inactiveIcon,
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
