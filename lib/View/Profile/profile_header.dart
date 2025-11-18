// // profile_header.dart
// import 'package:flutter/material.dart';
// import 'package:project_2/constants/app_color.dart';

// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(100),
//           bottomRight: Radius.circular(100),
//         ),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             AppColors.primary,
//             AppColors.primary.withValues(alpha: 0.9),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primary.withValues(alpha: 0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 40),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               _buildProfileImage(),
//               const SizedBox(height: 20),
//               _buildName(),
//               const SizedBox(height: 8),
//               _buildEmail(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileImage() {
//     return Stack(
//       children: [
//         Container(
//           width: 130,
//           height: 130,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Colors.white.withValues(alpha: 0.3),
//               width: 4,
//             ),
//             gradient: const LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFFFF4444),
//                 Color(0xFFDD2222),
//               ],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.2),
//                 blurRadius: 15,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: const Center(
//             child: Icon(
//               Icons.person,
//               size: 70,
//               color: Colors.black54,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 5,
//           right: 5,
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.secondary,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: AppColors.primary,
//                 width: 3,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.15),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Icon(
//               Icons.edit_rounded,
//               size: 20,
//               color: AppColors.primary,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildName() {
//     return const Text(
//       'Ashutosh Pandey',
//       style: TextStyle(
//         fontSize: 26,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//         letterSpacing: 0.5,
//       ),
//     );
//   }

//   Widget _buildEmail() {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 8,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.2),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: const Text(
//         'ashutosh@amitcorpo.com',
//         style: TextStyle(
//           fontSize: 15,
//           color: Colors.white,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:project_2/controllers/user_provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_2/constants/app_color.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    final name = user?.name ?? 'Guest';
    final email = user?.email ?? 'No email';
    final imageUrl = user?.profilePhoto??
        "https://res.cloudinary.com/dq4gjskwm/image/upload/v1759235279/default_profile_x437jc.png";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileImage(imageUrl),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              _buildEmail(email),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(String imageUrl) {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.edit_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail(String email) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        email,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
