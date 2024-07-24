import 'package:brandbridge/Core/utils/constants.dart';
import 'package:flutter/material.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.screenHeight(context),
      width: AppSize.screenWidth(context),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 100.0,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
