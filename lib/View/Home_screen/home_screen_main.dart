import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_2/widgets/shimmer/homescreen_shimmer.dart';
import 'package:provider/provider.dart';

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
import 'package:project_2/controllers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:project_2/controllers/user_provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final searchController = TextEditingController();
    final formValidators = AppValidators();

    /// 🔥 SAFE fetch (runs once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userProvider.currentUser == null && userProvider.isHomeLoading) {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          userProvider.fetchUser(uid);
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.secondary,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,

          title: userProvider.isHomeLoading
              ? const Text(
                  'Loading...',
                  style: TextStyle(color: AppColors.secondary, fontSize: 15),
                )
              : Row(
                  children: [
                    Icon(getGreetingIcon(), color: AppColors.secondary),
                    const SizedBox(width: 8),
                    Text(
                      '${getGreetingText()}, ${userProvider.currentUser!.name}',
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    prefixIcon: Icons.search,
                    controller: searchController,
                    hintText: "Search categories or services...",
                    validator: formValidators.validateEmail,
                  ),
                ),
              ),
            ),
          ),

          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.secondary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CustomShowDialog(
                    title: 'Oh No, You Are Leaving...',
                    subTitle: 'Are you sure want to logout',
                    buttonLeft: 'No',
                    buttonRight: 'Yes',
                    imagePath: 'assets/icons/logout.png',
                    onTap: () async {
                      Provider.of<UserAuthProvider>(
                        context,
                        listen: false,
                      ).logout();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginMain()),
                        (_) => false,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: userProvider.isHomeLoading
          ? const HomeScreenShimmer()
          : NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final navProvider =
                    Provider.of<NavigationProvider>(context, listen: false);

                if (notification.direction == ScrollDirection.reverse) {
                  navProvider.hideBottomNav();
                } else if (notification.direction ==
                    ScrollDirection.forward) {
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
                      SizedBox(
                        height: 600,
                        child: Center(child: Text("Scroll down...")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
