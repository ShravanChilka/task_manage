// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../config/style/styles.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> list = ['Personal', 'Business'];
    return Container(
      decoration: BoxDecoration(
        color: Palette.blue,
        borderRadius: BorderRadius.circular(defaultRadius * 2),
        border: Border.all(
          width: 2,
          color: Palette.blue,
        ),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox.shrink(),
        selectedItemBuilder: (context) => list.map((title) {
          return CustomDropDownItem(
            title: title,
            showType: true,
          );
        }).toList(),
        value: list.first,
        borderRadius: BorderRadius.circular(defaultRadius * 2),
        icon: const Padding(
          padding: EdgeInsets.all(defaultPadding * 0.5),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        style: const TextStyle(color: Colors.deepPurple),
        itemHeight: null,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          // setState(() {
          //   dropdownValue = value!;
          // });
        },
        items: list.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CustomDropDownItem(
                title: value,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomDropDownItem extends StatelessWidget {
  final bool showType;
  final String title;
  const CustomDropDownItem({
    Key? key,
    required this.title,
    this.showType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(defaultPadding),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: showType ? Palette.neutral300 : Palette.neutral500,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: const Icon(Icons.person),
        ),
        showType
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ],
    );
  }
}
