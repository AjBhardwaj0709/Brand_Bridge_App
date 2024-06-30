import 'package:brandbridge/Core/utils/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double height;
  final double width;
  const MyButton({super.key, required this.text, this.onPressed, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          
          backgroundColor: WidgetStateProperty.all(Appcolors.primaryColor),
        ),
        child: Text(
          text,
          style:
              const TextStyle(color: Appcolors.buttontextColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
