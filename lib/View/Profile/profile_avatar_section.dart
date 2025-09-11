import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/edit_profile_screen/edit_profile_main.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          padding: EdgeInsets.all(3), // thickness of the border
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary, // border color
              width: 3, // border width
            ),
          ),
          child: CircleAvatar(
            radius: 65,
            // backgroundImage: image != null ? FileImage(File(image!)) : null,
            // child: image == null ? Icon(Icons.person, size: 50) : null,
          ),
        ),

        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.edit,
                size: 30,
                color: AppColors.secondary,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileMain(),));
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) {
              //     return CustomCameraGalleryBottomSheet(
              //       onImagePicked: (imagePath) {
              //         onImagePicked(imagePath);
              //       },
              //     );
              //   },
              // );
            },
          ),
        ),
      ],
    );
  }
}