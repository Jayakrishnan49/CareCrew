import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/Auth/Login%20screen/login_main.dart';
import 'package:project_2/View/Profile/profile_avatar_section.dart';
import 'package:project_2/Widgets/custom_show_dialog.dart';
import 'package:provider/provider.dart';
import '../../Controllers/Auth Provider/auth_provider.dart';

class ProfilePageMain extends StatelessWidget {
  const ProfilePageMain({super.key});

  @override
  Widget build(BuildContext context) {
     final userProvider = Provider.of<UserAuthProvider>(context, listen: true);
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfileAvatarSection(),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,color: Colors.red,),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        showDialog(
                  context: context,
                  builder: (context) {
                    return CustomShowDialog(
                      title: 'Oh No, You Are Leaving...',
                      subTitle: 'Are you sure want to logout',
                      // icon: Icon(Icons.logout, color: Colors.red),
                      buttonLeft: 'No',
                      buttonRight: 'Yes',
                      onTap: () async {
                        userProvider.logout();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginMain()),
                        );
                      },
                    );
                  },
                );
                      },
                      child: Text('LogOut',style: TextStyle(
                        fontSize: 18
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        // appBar: AppBar(title: Text('Profile'),
        //   actions: [
        //     IconButton(onPressed: (){
        //   userProvider.logout();
        //   Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginMain(),));
        //   }, 
        //   icon: Icon(Icons.logout,color: Colors.red,))
        //   ],
        // ),
        // body: Center(
        //   child: Column(
        //     children: [
              
        //     ],
        //   ),
        // ),
      ),
    );
  }
}