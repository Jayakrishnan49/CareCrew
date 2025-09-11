import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';

class LoginTop extends StatelessWidget {
  const LoginTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60,),
        Text('Login',
          style: TextStyle(
          color: AppColors.primary,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'DancingScript',
          ),
        ),
        SizedBox(height: 15),
        Text('You have been missed !!',
        textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
              fontFamily: 'DancingScript',
            ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}