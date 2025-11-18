// logout_button.dart
import 'package:flutter/material.dart';
import 'package:project_2/View/auth/login_screen/login_main.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/auth_provider/auth_provider.dart';
import 'package:project_2/widgets/custom_show_dialog.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _handleLogout(BuildContext context) {  
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    // Show confirmation dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       title: const Text('Logout'),
    //       content: const Text('Are you sure you want to logout?'),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text(
    //             'Cancel',
    //             style: TextStyle(color: Colors.grey.shade600),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //             // Add your logout logic here
    //             // Example: Clear user data, navigate to login screen
    //           },
    //           child: Text(
    //             'Logout',
    //             style: TextStyle(
    //               color: AppColors.primary,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
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
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginMain()),
                            (Route<dynamic> route) => false, // removes all previous routes
                           );
                      }, imagePath: 'assets/icons/logout.png',
                    );
                  },
                );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleLogout(context),
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}