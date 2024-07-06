// import 'package:brandbridge/Features/Home/ui/home_page.dart';
import 'package:brandbridge/Features/Nav%20Bar/navbar.dart';
import 'package:brandbridge/Features/Splash_Screen/bloc/splash_screen_bloc.dart';
import 'package:brandbridge/Features/Splash_Screen/ui/splash_screen_widget.dart';
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
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashBloc,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: Center(
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              if (state is SplashScreenInitial ||
                  state is SplashScreenLoading) {
                return const SplashScreenWidget();
              } else if (state is SplashScreenLoaded) {
                return const NavBar();
              } else {
                // Handle unexpected states
                return Text('Unexpected state: $state');
              }
            },
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
