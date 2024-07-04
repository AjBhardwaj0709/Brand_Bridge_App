// import 'package:brandbridge/Features/Internet%20Exception/bloc/internet_exception_bloc.dart';
import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Features/Internet%20Exception/bloc/internet_exception_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: BlocListener<InternetExceptionBloc, InternetExceptionState>(
        listener: (context, state) {
          if (state is InternetExceptionLostState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Internet is connected"),
                backgroundColor: Colors.green));
          } else if (state is InternetExceptionGainState) {
            RouteNames.internetException;
          }
        },
        child: Container(),
      ),
    );
  }
}
