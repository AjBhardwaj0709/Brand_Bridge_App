import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Presentation/Bloc/Internet Exception/bloc/internet_exception_bloc.dart';
import 'Core/navigation/app_router.dart';
import 'Presentation/Pages/NavBottomBar/navbar.dart';
import 'Presentation/Bloc/Profile Page/bloc/profile_bloc.dart';
import 'Presentation/Pages/SplashScreen/splash_screen.dart';
import 'Presentation/Pages/LoginPage/login_page.dart';
import 'Presentation/Bloc/authentication/bloc/authentication_bloc.dart';
import 'Core/Services/auth_service.dart';
import 'Core/Services/authentication_repo.dart.dart';
import 'Core/Services/profile_services.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
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
        // Add ProfileBloc here
        BlocProvider(
          create: (context) => ProfileBloc(profileservice: ProfileService()),
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
