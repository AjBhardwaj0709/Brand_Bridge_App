import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Features/Home/ui/home_page.dart';
// import 'package:brandbridge/Features/Internet%20Exception/pages/internet_check_screen.dart';
import 'package:brandbridge/Features/Splash_Screen/ui/splash_screen.dart';
// import 'package:brandbridge/Features/login/ui/login_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case RouteNames.internetCheckScreen:
      // return MaterialPageRoute(builder: (_) => const InternetCheckScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case RouteNames.loginScreen:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
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
