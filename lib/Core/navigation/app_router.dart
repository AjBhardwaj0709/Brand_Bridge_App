import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Features/Home/pages/home_page.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen() );
      case RouteNames.loginPage:
        // return MaterialPageRoute(builder: (_) => );
      // case RouteNames.settings:
      //   return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}