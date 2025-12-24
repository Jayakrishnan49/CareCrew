
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/category_details_screen/category_details_screen_main.dart';
import 'package:project_2/controllers/browse_all_category_provider/browse_all_category_provider.dart';
import 'package:project_2/view/view_all_categories_screen/view_all_categories_screen.dart';
import 'package:project_2/widgets/shimmer/category_grid_shimmer.dart';
import 'package:provider/provider.dart';

class BrowseAllCategorySection extends StatelessWidget {
  const BrowseAllCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<BrowseAllCategoryProvider>(context);
    Future.microtask(() => categoryProvider.fetchCategories());

    final displayedCategories = categoryProvider.categories.length > 8
        ? categoryProvider.categories.sublist(0, 8)
        : categoryProvider.categories;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Browse all categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllCategoriesScreen(),));
                },
                child: const Text("View all",style: TextStyle(color: AppColors.buttonColor),),
              ),
            ],
          ),
        ),

        // Grid with animation
        categoryProvider.categories.isEmpty
            // ? const Center(child: CircularProgressIndicator())
            ?CategoryGridShimmer()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimationLimiter(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: displayedCategories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final category = displayedCategories[index];
                      final image = categoryProvider.categoryImages[category];

                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 4,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CategoryDetailsScreenMain(category: category),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  // CircleAvatar(
                                  //   radius: 30,
                                  //   backgroundImage: (image != null && image.isNotEmpty)
                                  //       ? NetworkImage(image)
                                  //       : null,
                                  //   child: (image == null || image.isEmpty)
                                  //       ? Text(
                                  //           category[0],
                                  //           style: const TextStyle(
                                  //             fontSize: 18,
                                  //             color: Colors.white,
                                  //           ),
                                  //         )
                                  //       : null,
                                  // ),

                                  CircleAvatar(
  radius: 30,
  backgroundColor: Colors.grey[300],
  child: ClipOval(
    child: (image != null && image.isNotEmpty)
        ? Image.network(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // image loaded
              // show icon while loading
              return const Icon(
                Icons.image,
                color: Colors.white,
                size: 30,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              // show icon if image fails
              return const Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 30,
              );
            },
          )
        : const Icon(
            Icons.category, // placeholder icon when no image
            color: Colors.white,
            size: 30,
          ),
  ),
),

                                  const SizedBox(height: 8),
                                  Text(
                                    category,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

