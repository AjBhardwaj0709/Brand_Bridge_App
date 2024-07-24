import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:brandbridge/Features/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Appcolors.primaryColor),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: Appcolors.gradientBackground),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogoutRequested());
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(RouteNames.loginScreen);
              },
            ),
          ],
        );
      },
    );
  }
}
