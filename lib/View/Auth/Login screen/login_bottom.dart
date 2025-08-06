import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/Auth/SignUp%20screen/signup_main.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          RichText(
            text: TextSpan(
              text: "Don't have an acoount?",
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold
              ),
              children:[
                TextSpan(
                  text: ' Sign Up',
                  style: TextStyle(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap=(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SignupMain(),));
                  }
                ),
              ]
            )
            )
      ],
    );
  }
}