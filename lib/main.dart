import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Core/navigation/app_router.dart';
import 'package:brandbridge/Features/Internet%20Exception/bloc/internet_exception_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetExceptionBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
