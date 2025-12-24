import 'package:flutter/material.dart';
import 'package:project_2/View/category_details_screen/category_details_img_section.dart';
import 'package:project_2/View/category_details_screen/widgets/included_excluded_items.dart';
import 'package:project_2/View/show_particular_service_providers/show_particular_service_providers_main.dart';
import 'package:project_2/Widgets/custom_button.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/model/work_model.dart';
import 'package:project_2/services/service_details_service.dart';

class CategoryDetailsScreenMain extends StatelessWidget {
  final String category;
  const CategoryDetailsScreenMain({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    // final providerData=Provider.of<ServiceProviderDetailsProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: FutureBuilder<List<WorkModel>>(
        future: ServiceDetailsService().getAllWorks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
           // Filter by category
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
                // price: work.price,
                ),
              // Content Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                     Text(
                      work.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5A6C7D),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Included
                    const Text(
                      'Included',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    buildIncludedItem(
                        'Inspection & Labour charges for Repair Services.'),
                    buildIncludedItem('15 Days Service Warranty.'),
                    buildIncludedItem('Professional and certified.'),
                    buildIncludedItem(
                        'Procurement of materials at additional Cost.'),
                    buildIncludedItem(
                        'If work requires a helper, an additional charge is applicable. (80% of Main labour cost)'),
                    const SizedBox(height: 24),
                    // Excluded
                    const Text(
                      'Excluded',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 12),
                    buildExcludedItem(
                        'Major Masonry Work like tiling, granite installation etc.'),
                    buildExcludedItem('Please Provide ladder, if required.'),
                    buildExcludedItem(
                        'Cementing and painting of damaged walls.'),
                    buildExcludedItem('Toilet and drainage related issues'),
                    const SizedBox(height: 40),
                  ////
                    ],
                  ),
                ),
            ]
              ),
            );
  }
      ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Continue',
              width: double.infinity,
              borderRadius: 15,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ShowParticularServiceProvidersMain(category: category,),));
              },
              ),
          ),
        
      );
  }

}