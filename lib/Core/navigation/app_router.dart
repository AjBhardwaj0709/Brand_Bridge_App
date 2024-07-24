import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Core/widgets/something_went_wrong_widget.dart';
import 'package:brandbridge/Features/Pages/Home/ui/home_page.dart';
import 'package:brandbridge/Features/Internet%20Exception/ui/internet_exception.dart';
import 'package:brandbridge/Features/Nav%20Bar/navbar.dart';
import 'package:brandbridge/Features/Pages/SignUp/ui/signup.dart';
import 'package:brandbridge/Features/Pages/Splash_Screen/ui/splash_screen.dart';
import 'package:brandbridge/Features/Pages/login/ui/login_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteNames.somethingwentwrong:
        return MaterialPageRoute(
            builder: (_) => const SomethingWentWrongWidget());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.internetException:
        return MaterialPageRoute(builder: (_) => const InternetException());

      case RouteNames.navbar:
        return MaterialPageRoute(builder: (_) => const NavBar());

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RouteNames.singupScreen:
        return MaterialPageRoute(builder: (_) => SignUpPage());

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
