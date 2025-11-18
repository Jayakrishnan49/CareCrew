import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/View/bottom_nav/bottom_nav_screen.dart';
import 'package:project_2/Widgets/custom_button.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/location_access/location_access.png'),
            Text(
              'Allow location access ?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'We need your location access to easily find professionals around you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.hintText,
                // fontSize: 20
              ),
            ),
            SizedBox(height: 50),
            CustomButton(
              text: 'Allow location access',
              width: 400,
              borderRadius: 15,
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreenWithNavigation(),
                  ),
                );
              },
              child: Text(
                'Skip this step',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  // fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  // fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
