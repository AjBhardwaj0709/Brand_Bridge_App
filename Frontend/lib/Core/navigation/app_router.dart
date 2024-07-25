import 'app_route_names.dart';
import '../../Presentation/widgets/something_went_wrong_widget.dart';
import '../../Presentation/Pages/HomePage/home_page.dart';
import '../../Presentation/Bloc/Internet Exception/ui/internet_exception.dart';
import '../../Presentation/Pages/NavBottomBar/navbar.dart';
import '../../Presentation/Pages/SignUpPage/signup.dart';
import '../../Presentation/Pages/SplashScreen/splash_screen.dart';
import '../../Presentation/Pages/LoginPage/login_page.dart';
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
