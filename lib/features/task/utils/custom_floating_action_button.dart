import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String tag;
  final Color? backgroundColor;
  final Icon icon;
  const CustomFloatingActionButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    required this.icon,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      heroTag: tag,
      elevation: 0,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
