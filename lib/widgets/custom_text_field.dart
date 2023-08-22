import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.maxLength,
  });
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.blueGrey.shade100,
        border: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
