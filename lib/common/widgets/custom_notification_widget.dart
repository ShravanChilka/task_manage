import 'package:flutter/material.dart';
import '../../config/style/styles.dart';

class CustomNotificationWidget extends StatelessWidget {
  final bool isEnabled;
  const CustomNotificationWidget({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius * 2),
      onTap: () async {},
      child: Ink(
        decoration: BoxDecoration(
          color: isEnabled ? Palette.green : Palette.red,
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
              child: const Icon(Icons.notification_add),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notification',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  isEnabled ? 'Enabled' : 'Disabled',
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
