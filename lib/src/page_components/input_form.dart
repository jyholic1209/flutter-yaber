import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.textController,
    this.isPassword = false,
    required this.hintText,
    this.icon,
    this.suffixText,
  });

  final TextEditingController textController;
  final bool isPassword;
  final String hintText;
  final Widget? icon;
  final String? suffixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(style: BorderStyle.solid),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          suffixText: suffixText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
