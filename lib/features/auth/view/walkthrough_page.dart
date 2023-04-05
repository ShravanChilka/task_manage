import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';
import 'package:task_manage/features/auth/utils/custom_painter.dart';
import 'package:task_manage/features/auth/utils/paths.dart';

class WalkthroughPage extends StatelessWidget {
  final PathType pathType;
  final String assetPath;
  final String title;
  final String description;
  const WalkthroughPage({
    Key? key,
    required this.pathType,
    required this.assetPath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomPaint(
          size: Size(size.width, (size.width * 2.1546666666666665).toDouble()),
          painter: MyCustomPainter(path: MyPaths.getPath(pathType, size)),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 400,
                image: AssetImage(assetPath),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
