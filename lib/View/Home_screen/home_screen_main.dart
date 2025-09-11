import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2/Utilities/app_validators.dart';
import 'package:project_2/View/Auth/Login%20screen/login_main.dart';
import 'package:project_2/View/Home_screen/add_section.dart';
import 'package:project_2/Widgets/custom_show_dialog.dart';
import 'package:project_2/Widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    AppValidators formValidators = AppValidators();
    final userProvider = Provider.of<UserAuthProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          leading: Icon(Icons.person,color: AppColors.secondary,),
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Good evening, Jayakrishnan',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 15
              ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFormField(
                prefixIcon: Icons.search,
                controller: searchController,
                hintText: 'search...',
                validator: formValidators.validateEmail,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
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
              icon: Icon(Icons.logout, color: AppColors.secondary),
            ),
          ],
        ),
      ),

      body:Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            AddSection(),
          ],
        ),
      ),
      // body: Center(
      //   child:IconButton(onPressed: (){
      //   userProvider.logout();
      //   Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginMain(),));
      //   },
      //   icon: Icon(Icons.logout)) ,
      // ),
    );
  }
}
