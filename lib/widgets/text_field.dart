import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldComponent extends StatelessWidget {
  TextFieldComponent(
      {super.key,
      required this.text,
      required this.controller,
      this.keyboardType = TextInputType.name,
      this.icon,
      this.suffixIcon,
      this.obscureText=false});

  final String text;
  final TextEditingController controller;
  final Icon? icon;
  bool obscureText = false;
  var keyboardType = TextInputType.name;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType:  keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }
}
