import 'package:brandbridge/Core/utils/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double height;
  final double width;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Appcolors.navbar),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Appcolors.primaryColor),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Appcolors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
