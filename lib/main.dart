import 'package:brandbridge/Features/Pages/Nav%20Bar/navbar.dart';
import 'package:brandbridge/Features/Pages/Splash_Screen/ui/splash_screen.dart';
import 'package:brandbridge/Features/authentication/bloc/authentication_bloc.dart';
import 'package:brandbridge/Features/Pages/login/ui/login_page.dart';
import 'package:brandbridge/Services/auth_service.dart';
import 'package:brandbridge/Services/authentication_repo.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brandbridge/Core/navigation/app_router.dart';
import 'package:brandbridge/Core/error/Internet%20Exception/bloc/internet_exception_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

// void main() {
//   runApp(MyApp());
// }
void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable DevicePreview in debug mode
      builder: (context) => MyApp(), // Wrap your app with DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService = AuthService();
  final AuthRepository authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authService: authService,
            authRepository: authRepository,
          )..add(CheckAuthenticationStatus()),
        ),
        RepositoryProvider.value(value: authService),
        RepositoryProvider.value(value: authRepository),
        BlocProvider(
          create: (context) => InternetExceptionBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial ||
                state is AuthenticationLoading) {
              return const SplashScreen();
            } else if (state is Authenticated) {
              return const NavBar();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
