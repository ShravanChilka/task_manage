import 'package:flutter/material.dart';
import 'package:task_manage/config/style/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        focusColor: Palette.secondary500,
        prefixIcon: Container(
          margin: const EdgeInsets.all(defaultPadding),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Palette.neutral500,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: const Icon(Icons.add),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius * 2),
          borderSide: const BorderSide(
            width: 2,
            color: Palette.neutral500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius * 2),
          borderSide: BorderSide(
            width: 2,
            color: Palette.neutral900.withOpacity(0.2),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius * 2),
          borderSide: const BorderSide(
            color: Palette.secondary500,
          ),
        ),
      ),
    );
  }
}
