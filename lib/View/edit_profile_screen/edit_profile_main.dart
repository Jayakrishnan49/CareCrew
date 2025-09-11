import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/edit_profile_screen/edit_profile_form.dart';
import 'package:project_2/View/edit_profile_screen/edit_profile_top.dart';

class EditProfileMain extends StatelessWidget {
  const EditProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Edit Profile',style: TextStyle(color: AppColors.secondary),),
      ),
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditProfileTop(),
                  SizedBox(height: 60,),
                  EditProfileForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}