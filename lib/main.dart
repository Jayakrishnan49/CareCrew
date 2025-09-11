import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2/Controllers/Custom%20Textform%20Field%20Provider/custom_text_form_field_provider.dart';
import 'package:project_2/Controllers/user_provider/user_provider.dart';
import 'package:project_2/View/splash_screen/splash_screen.dart';
import 'package:project_2/View/location_access_screen/location_access_screen.dart';
import 'package:provider/provider.dart';

import 'Controllers/BottomNavProvider/bottom_nav_provider.dart' show NavigationProvider;

void main() async{
     WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CustomTextFormFieldProvider()),
        ChangeNotifierProvider(create: (_)=>UserAuthProvider()),
        ChangeNotifierProvider(create: (_)=>UserProvider()),
         ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen()
        // home: LocationAccessScreen(),
        
        // home: CreateUserPage(),
      ),
    );
  }
}
