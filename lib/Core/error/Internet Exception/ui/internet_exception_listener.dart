import 'package:brandbridge/Core/navigation/app_route_names.dart';
import 'package:brandbridge/Core/error/Internet%20Exception/bloc/internet_exception_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetExceptionListener extends StatelessWidget {
  final Widget child;
  const InternetExceptionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetExceptionBloc, InternetExceptionState>(
      listener: (context, state) {
        if (state is InternetExceptionLostState) {
          // Handle internet connectivity lost state
          RouteNames.internetException;
        } else if (state is InternetExceptionGainState) {
          // Handle internet connectivity  state
                    RouteNames.internetException;

        }
      },
      child: child,
    );
  }
}
