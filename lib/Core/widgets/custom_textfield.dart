import 'package:brandbridge/Core/utils/colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String labelText;
  final bool obscuretext;
  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.labelText,
      required this.obscuretext,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscuretext,
      controller: controller,
      style: const TextStyle(color: Appcolors.textColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Appcolors.primaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(color: Appcolors.hinttextColor),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(color: Appcolors.primaryColor, width: 3.0)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color:
                Appcolors.primaryColor, // Color when the TextField is focused
            width: 3.0,
          ),
        ),
        prefixIcon: Icon(icon, color: Appcolors.primaryColor),
      ),
    );
  }
}
