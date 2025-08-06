import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2/View/Auth/Login%20screen/login_main.dart';
import 'package:project_2/View/Home%20screen/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateUser(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isLoggedIn = await authProvider.checkUserLogin();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  isLoggedIn ? const HomeScreen() : const LoginMain(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => navigateUser(context));
    return Scaffold(
  backgroundColor: AppColors.primary,
  body: SafeArea(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
  
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary,
            ),
            child: Icon(
              Icons.home_repair_service,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          
          SizedBox(height: 40),
          Text(
            'Care Crew',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          
          SizedBox(height: 15),

          Text(
            'Connecting you with trusted professionals',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}