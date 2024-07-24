import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppText.profileText),
        backgroundColor: Colors.transparent,
      ),
      
      body: Container(
        decoration: BoxDecoration(gradient: Appcolors.gradientBackground),
        
      ),
    );
  }
}
