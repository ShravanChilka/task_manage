import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Icon icon;
  const CustomFloatingActionButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
