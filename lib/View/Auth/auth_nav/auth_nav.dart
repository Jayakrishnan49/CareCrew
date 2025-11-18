
import 'package:flutter/material.dart';
import 'package:project_2/controllers/user_provider/user_provider.dart';
import 'package:project_2/View/Home_screen/home_screen_main.dart';

import 'package:provider/provider.dart';

import '../../add_account_screen/add_account_main.dart';

class AuthNavigation extends StatelessWidget {
  const AuthNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<UserProvider>(context, listen: false);

    Future<String?> checkUserRegistration() async {
      return await hotelProvider.checkUserRegistration();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? hotelId = await checkUserRegistration();
      if (hotelId != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AddAccountMain(),
          ),
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}