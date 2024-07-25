import '../../../Core/utils/constants.dart';
import '../../widgets/something_went_wrong_widget.dart';
import '../../Bloc/Splash_Screen/bloc/splash_screen_bloc.dart';
import 'splash_screen_widget.dart';
import '../LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenBloc _splashBloc = SplashScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _splashBloc,
        child: SizedBox(
          height: AppSize.screenHeight(context),
          width: AppSize.screenWidth(context),
          child: Center(
            child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
              builder: (context, state) {
                if (state is SplashScreenInitial ||
                    state is SplashScreenLoading) {
                  return const SplashScreenWidget();
                } else if (state is SplashScreenLoaded) {
                  return LoginPage();
                } else {
                  // Handle unexpected states
                  return const SomethingWentWrongWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }
}
