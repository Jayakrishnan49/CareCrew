
import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/Widgets/custom_button.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String? buttonLeft;
  final String? buttonRight;
  final String subTitle;
  // final Icon icon;
  final VoidCallback onTap;
  const CustomShowDialog({
    super.key,
    required this.title,
    this.buttonLeft,
    this.buttonRight,
    required this.subTitle,
    // required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          SizedBox(
            height: 250,
            child: Image.asset('assets/icons/logout.png')),
          // icon,
          // const SizedBox(
          //   width: 8,
          // ),
          Text(
            title,
            style: TextStyle(color: AppColors.textColor, fontSize: 20),
          ),
        ],
      ),
      content: Text(
        subTitle,
        style: TextStyle(color: AppColors.hintText,),
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 20
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomButton(
              text: buttonLeft ?? 'Cancel',
              width: 100,
              height: 45,
              color: AppColors.hintText,
              textColor: AppColors.secondary,
              borderRadius: 10,
              borderColor: AppColors.hintText,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            CustomButton(
                text: buttonRight ?? 'Delete',
                width: 100,
                height: 45,
                textColor: AppColors.secondary,
                color: AppColors.buttonColor,
                borderRadius: 10,
                borderColor: AppColors.buttonColor,
                onTap: onTap)
          ])
            ],
          ),
        )
        
      ],
    );
  }
}
