import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/Auth/Login%20screen/login_bottom.dart';
import 'package:project_2/View/Auth/Login%20screen/login_registration.dart';
import 'package:project_2/View/Auth/Login%20screen/login_top.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  LoginTop(),
                  LoginRegistration(),
                  SizedBox(height: 20,),
                  LoginBottom(),
                  SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Divider(color: AppColors.hintText,)),
                      Text('   Or continue with   '),
                      Expanded(child: Divider(color: AppColors.hintText,)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}