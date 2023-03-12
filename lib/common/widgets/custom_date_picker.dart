import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manage/core/config/styles.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius * 2),
      onTap: () async {
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime.now(),
        //   lastDate: DateTime(DateTime.now().year + 1),
        // );
        final time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 0),
        );
        log(time.toString());
      },
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
              child: const Icon(Icons.date_range),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick Date',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '1 June',
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
