import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:brandbridge/Features/Chat%20Page/ui/chat.dart';
import 'package:brandbridge/Features/Home/ui/home_page.dart';
import 'package:brandbridge/Features/Profile%20Page/ui/profile.dart';
import 'package:brandbridge/Features/Setting%20Page/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ChatPage(),
    const ProfilePage(),
    const SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          // Navigation Bar
          Positioned(
            left: 10,
            right: 10,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Appcolors.navbar,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Appcolors.navbar,
                      // spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(0, 20),
                    )
                  ]),
              child: GNav(
                gap: 8,
                backgroundColor: Appcolors.navbar,
                color: Appcolors.textColor,
                activeColor: Appcolors.primaryColor,
                tabBackgroundColor: Appcolors.primaryColor.withOpacity(0.1),
                iconSize: 25,
                padding: const EdgeInsets.all(16),
                onTabChange: _onItemTapped,
                tabs: const [
                  GButton(icon: Icons.home, text: AppText.homeText),
                  GButton(icon: Icons.chat, text: AppText.chattext),
                  GButton(icon: Icons.person, text: AppText.profileText),
                  GButton(icon: Icons.settings, text: AppText.settingsText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
