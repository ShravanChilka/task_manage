import 'package:flutter/material.dart';

enum PathType { firstScreen, secondScreen, thirdScreen }

class MyPaths {
  static Path getPath(PathType pathType, Size size) {
    Path path = Path();
    switch (pathType) {
      case PathType.firstScreen:
        path.moveTo(0, size.height * 0.48);
        path.cubicTo(
          size.width * 0.28,
          size.height * 0.37,
          size.width * 0.70,
          size.height * 0.60,
          size.width,
          size.height * 0.37,
        );
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        path.close();
        return path;
      case PathType.secondScreen:
        path.moveTo(0, size.height * 0.37);
        path.cubicTo(
          size.width * 0.3,
          size.height * 0.1,
          size.width * 0.8,
          size.height * 0.45,
          size.width,
          size.height * 0.34,
        );
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        path.close();
        return path;
      case PathType.thirdScreen:
        path.moveTo(0, size.height * 0.34);
        path.quadraticBezierTo(size.width * 0.15, size.height * 0.24,
            size.width * 0.45, size.height * 0.36);
        path.cubicTo(
          size.width * 0.75,
          size.height * 0.44,
          size.width * 0.8,
          size.height * 0.2,
          size.width,
          size.height * 0.2,
        );
        path.lineTo(size.width, 0);
        path.lineTo(0, 0);
        path.close();
        return path;
    }
  }
}
