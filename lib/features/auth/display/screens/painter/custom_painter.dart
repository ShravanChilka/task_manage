import 'package:flutter/material.dart';
import 'package:task_manage/config/style/styles.dart';

class MyCustomPainter extends CustomPainter {
  Path path;
  MyCustomPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Palette.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
