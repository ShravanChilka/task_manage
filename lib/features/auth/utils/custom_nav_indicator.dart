import 'package:flutter/material.dart';
import 'package:task_manage/config/styles.dart';

class CustomNavIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  const CustomNavIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                margin: const EdgeInsets.only(left: 4, right: 4),
                height: 8,
                width: index == currentIndex ? 16 : 8,
                decoration: BoxDecoration(
                  color: Palette.secondary500,
                  borderRadius: BorderRadius.circular(4),
                ),
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
              );
            },
            itemCount: itemCount,
          )
        ],
      ),
    );
  }
}
