import 'package:flutter/material.dart';

class Appcolors {
  //backgroundColor
  static LinearGradient get gradientBackground {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // colors: [Color.fromARGB(255, 4, 51, 90), Colors.blue],
      colors: [
        Color(0xff09203f),
        Color(0xff537895),
      ], // Example colors
    );
  }

// Loding Widget color
  static const Color loding = Colors.blue;
  //navbar background color
  static const Color navbar = Color(0xff09203f);
  //primary color
  static const Color primaryColor = Color.fromRGBO(37, 211, 102, 1);
  // Text Color
  static const Color textColor = Color(0xFFFFFFFF);
  //Button Text Color
  static const Color buttontextColor = Color(0x00000000);
}