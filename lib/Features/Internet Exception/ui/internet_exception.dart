import 'package:brandbridge/Core/utils/colors.dart';
import 'package:brandbridge/Core/utils/constants.dart';
import 'package:brandbridge/Features/Internet%20Exception/bloc/internet_exception_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetException extends StatefulWidget {
  const InternetException({super.key});

  @override
  State<InternetException> createState() => _InternetExceptionState();
}

class _InternetExceptionState extends State<InternetException> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: BlocListener<InternetExceptionBloc, InternetExceptionState>(
          listener: (context, state) {
            if (state is InternetExceptionGainState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Internet is connected"),
                backgroundColor: Colors.green,
              ));
            } else if (state is InternetExceptionLostState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(AppText.internetExceptionText),
                backgroundColor: Appcolors.internetExceptionColor,
              ));
            }
          },
          child: Container(),
        ),
      )),
    );
  }
}
