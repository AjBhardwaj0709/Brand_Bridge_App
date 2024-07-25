import '../../../Core/utils/colors.dart';
import '../../../Core/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppText.chattext),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: Appcolors.gradientBackground),
      ),
    );
  }
}
