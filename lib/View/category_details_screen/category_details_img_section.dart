// import 'package:flutter/material.dart';
// import 'package:project_2/constants/app_color.dart';

// class CategoryDetailsImgSection extends StatelessWidget {
  
//   final dynamic imageUrl;
  
//   final dynamic title;
  
//   final dynamic price;

//   const CategoryDetailsImgSection({super.key,required this.imageUrl,required this.title,required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Image.network(
//                   imageUrl,
//                   width: double.infinity,
//                   height: 500,
//                   fit: BoxFit.cover,
//                   // errorBuilder: (context, error, stackTrace) {
//                   //   return Container(
//                   //     width: double.infinity,
//                   //     height: 400,
//                   //     color: Colors.grey[300],
//                   //     child: const Icon(Icons.plumbing, size: 80),
//                   //   );
//                   // },
//                 ),
//                 Positioned(
//                   top: 40,
//                   left: 16,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.textColor.withValues(alpha: 0.1),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 40,
//                   right: 16,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.textColor.withValues(alpha: 0.1),
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.favorite_border, color:AppColors.primary),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//                 // Overlay Card with Title, Price, and Rating
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: -120,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.textColor.withValues(alpha: 0.20),
//                           blurRadius: 20,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                          Text(
//                           title,
//                           style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.textColor,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                          Text(
//                           '₹ $price',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primary,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           '₹120 / Later Hourly Charge',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Duration :',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: AppColors.textColor,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               '1 Hour',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Rating :',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: AppColors.textColor,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   '4.5',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColors.textColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//   }
// }





import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/model/work_model.dart';
import 'package:project_2/services/service_details_service.dart';
import 'package:project_2/view/show_particular_service_providers/show_particular_service_providers_main.dart';
import 'package:project_2/widgets/custom_button.dart';

class CategoryDetailsImgSection extends StatelessWidget {
  final dynamic imageUrl;
  final dynamic title;

  const CategoryDetailsImgSection({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Hero Image with Gradient Overlay
        Container(
          height: 400,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress==null){
                    return child;
                  }
                  else{
                    return Container(
                      color:Colors.grey.shade300,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 48,
                          color: AppColors.secondary,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                        color: AppColors.secondary,
                      ),
                    ),
                  );
                },
              ),
              // Gradient overlay for better text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Back Button
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // Favorite Button
        // Positioned(
        //   top: 40,
        //   right: 16,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       shape: BoxShape.circle,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.2),
        //           blurRadius: 8,
        //           offset: Offset(0, 2),
        //         ),
        //       ],
        //     ),
        //     child: IconButton(
        //       icon: Icon(Icons.favorite_border, color: AppColors.primary),
        //       onPressed: () {},
        //     ),
        //   ),
        // ),

        // Title Overlay Card
        Positioned(
          left: 0,
          right: 0,
          bottom: -80,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_repair_service,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Service Category',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),

                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                // Quick Info Row
                Row(
                  children: [
                    // Duration
                    _buildQuickInfo(
                      icon: Icons.access_time_rounded,
                      label: 'Duration',
                      value: '1 Hour',
                      color: AppColors.primary,
                    ),
                    
                    const SizedBox(width: 20),
                    
                    // Warranty
                    _buildQuickInfo(
                      icon: Icons.verified_rounded,
                      label: 'Warranty',
                      value: '15 Days',
                      color: const Color(0xFF10B981),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickInfo({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated Main Screen with adjusted spacing
class CategoryDetailsScreenMain extends StatelessWidget {
  final String category;
  const CategoryDetailsScreenMain({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: FutureBuilder<List<WorkModel>>(
        future: ServiceDetailsService().getAllWorks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final works = snapshot.data!
              .where((work) => work.name == category)
              .toList();

          if (works.isEmpty) {
            return const Center(child: Text("No services available."));
          }
          
          final work = works.first;
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // Image Section with Overlay Card
                CategoryDetailsImgSection(
                  imageUrl: work.image,
                  title: work.name,
                ),
                
                // Content Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Adjusted spacing for smaller card
                      const SizedBox(height: 100),
                      
                      // Description Section
                      _buildSectionHeader(
                        icon: Icons.description_rounded,
                        title: 'Description',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        work.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5A6C7D),
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Included Section
                      _buildSectionHeader(
                        icon: Icons.check_circle_rounded,
                        title: 'Included',
                        color: const Color(0xFF10B981),
                      ),
                      const SizedBox(height: 12),
                      buildIncludedItem('Inspection & Labour charges for Repair Services.'),
                      buildIncludedItem('15 Days Service Warranty.'),
                      buildIncludedItem('Professional and certified.'),
                      buildIncludedItem('Procurement of materials at additional Cost.'),
                      buildIncludedItem('If work requires a helper, an additional charge is applicable. (80% of Main labour cost)'),
                      
                      const SizedBox(height: 32),
                      
                      // Excluded Section
                      _buildSectionHeader(
                        icon: Icons.cancel_rounded,
                        title: 'Excluded',
                        color: const Color(0xFFEF4444),
                      ),
                      const SizedBox(height: 12),
                      buildExcludedItem('Major Masonry Work like tiling, granite installation etc.'),
                      buildExcludedItem('Please Provide ladder, if required.'),
                      buildExcludedItem('Cementing and painting of damaged walls.'),
                      buildExcludedItem('Toilet and drainage related issues'),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: 'Continue',
          width: double.infinity,
          borderRadius: 15,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowParticularServiceProvidersMain(category: category),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    Color? color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (color ?? AppColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: color ?? AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }

  Widget buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExcludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}