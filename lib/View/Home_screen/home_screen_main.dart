import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Utilities/get_greeting_homescreen.dart';
import 'package:project_2/View/auth/login_screen/login_main.dart';
import 'package:project_2/View/home_screen/home_screen_components/advertisement_section/add_section.dart';
import 'package:project_2/View/home_screen/home_screen_components/browse_all_category_section/browse_all_category_section.dart';
import 'package:project_2/View/home_screen/home_screen_components/service_provider_list_section/service_provider_list_section.dart';
import 'package:project_2/View/search_screen/search_screen_main.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/Utilities/app_validators.dart';
import 'package:project_2/Widgets/custom_text_form_field.dart';
import 'package:project_2/controllers/auth_provider/auth_provider.dart';
import 'package:project_2/widgets/custom_show_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:project_2/controllers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:project_2/controllers/user_provider/user_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    AppValidators formValidators = AppValidators();
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    if (userProvider.currentUser == null) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        userProvider.fetchUser(userId);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(150),
  child: AppBar(
    // leading: Icon(Icons.person, color: AppColors.secondary),
    backgroundColor: AppColors.primary,
    automaticallyImplyLeading: false,
    title: userProvider.currentUser == null
        ? Text(
            'Loading...',
            style: TextStyle(color: AppColors.secondary, fontSize: 15),
          )
        : Row(
          children: [
            Icon(getGreetingIcon(),color: AppColors.secondary,),
            SizedBox(width: 8,),
            Text(
                '${getGreetingText()}, ${userProvider.currentUser!.name}',
                style: TextStyle(color: AppColors.secondary, fontSize: 15),
              ),
          ],
        ),

    

    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomTextFormField(
          prefixIcon: Icons.search,
          controller: searchController,
          hintText: "search for 'cleaning'...",
          validator: formValidators.validateEmail,
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          //navigate to search screen
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  SearchScreen(),
                  ),
                );
        },
        icon: Icon(Icons.search,color: AppColors.secondary,),
      ),
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomShowDialog(
                title: 'Oh No, You Are Leaving...',
                subTitle: 'Are you sure want to logout',
                buttonLeft: 'No',
                buttonRight: 'Yes',
                onTap: () async {
                  Provider.of<UserAuthProvider>(context, listen: false).logout();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginMain()),
                  );
                }, imagePath: 'assets/icons/logout.png',
                
              );
            },
          );
        },
        icon: Icon(Icons.logout, color: AppColors.secondary),
      ),
    ],
  ),
),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final navProvider = Provider.of<NavigationProvider>(context, listen: false);
          if (notification.direction == ScrollDirection.reverse) {
            navProvider.hideBottomNav();
          } else if (notification.direction == ScrollDirection.forward) {
            navProvider.showBottomNav();
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: const [
                AddSection(),
                BrowseAllCategorySection(),
                ServiceProviderList(),
                SizedBox(height: 600, child: Center(child: Text("Scroll down..."))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
