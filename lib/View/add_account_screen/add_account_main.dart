import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/add_account_screen/add_account_form.dart';
import 'package:project_2/View/add_account_screen/add_account_top.dart';

class AddAccountMain extends StatelessWidget {
  const AddAccountMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddAccountTop(),
                  SizedBox(height: 60,),
                  AddAccountForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}