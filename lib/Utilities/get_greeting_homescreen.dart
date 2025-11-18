import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String getGreetingText() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}

IconData getGreetingIcon() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return FontAwesomeIcons.cloudSun; // Morning
  } else if (hour >= 12 && hour < 17) {
    return Icons.sunny; // Afternoon
  } else if (hour >= 17 && hour < 21) {
    return FontAwesomeIcons.cloudMoon; // Evening
  } else {
    return Icons. dark_mode; // Night
  }
}




// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// String getGreetingText() {
//   final hour = DateTime.now().hour;

//   if (hour >= 5 && hour < 12) return "Good Morning";
//   if (hour >= 12 && hour < 17) return "Good Afternoon";
//   if (hour >= 17 && hour < 21) return "Good Evening";
//   return "Good Night";
// }

// IconData getGreetingIcon() {
//   final hour = DateTime.now().hour;

//   if (hour >= 5 && hour < 12) return FontAwesomeIcons.solidSun;
//   if (hour >= 12 && hour < 17) return FontAwesomeIcons.cloudSun;
//   if (hour >= 17 && hour < 21) return FontAwesomeIcons.moon;
//   return FontAwesomeIcons.sun;
// }

// // New: dynamic color function
// Color getGreetingColor() {
//   final hour = DateTime.now().hour;

//   if (hour >= 5 && hour < 12) return Colors.orange;   // Morning
//   if (hour >= 12 && hour < 17) return Colors.red;     // Afternoon
//   if (hour >= 17 && hour < 21) return Colors.purple;   // Evening
//   return Colors.grey;                                  // Night
// }

