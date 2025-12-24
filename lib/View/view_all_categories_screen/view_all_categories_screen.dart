import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/View/category_details_screen/category_details_screen_main.dart';
import 'package:project_2/controllers/browse_all_category_provider/browse_all_category_provider.dart';
import 'package:project_2/view/view_all_categories_screen/widget/category_card.dart';
import 'package:project_2/widgets/shimmer/category_grid_shimmer.dart';
import 'package:provider/provider.dart';



class ViewAllCategoriesScreen extends StatelessWidget {
  const ViewAllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<BrowseAllCategoryProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        // elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: categoryProvider.categories.isEmpty
          ? const CategoryGridShimmer()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories count
                    Text(
                      '${categoryProvider.categories.length} Categories',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Grid with animation
                    AnimationLimiter(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryProvider.categories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final category = categoryProvider.categories[index];
                          final image = categoryProvider.categoryImages[category];

                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 3,
                            duration: const Duration(milliseconds: 900),
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: CategoryCard(
                                  category: category,
                                  image: image,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CategoryDetailsScreenMain(
                                          category: category,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
