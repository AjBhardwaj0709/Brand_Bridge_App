import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          AppText.settingsText,
          style: TextStyle(color: Appcolors.primaryColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: Appcolors.gradientBackground),
      ),
    );
  }
}
