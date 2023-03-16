import 'package:flutter/material.dart';
import 'package:task_manage/config/style/styles.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() onTap;
  final Icon icon;
  final Color? backgroundColor;
  const CustomIconButton({
    Key? key,
    this.backgroundColor = Palette.secondary500,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        width: 48,
        height: 48,
        child: icon,
      ),
    );
  }
}
