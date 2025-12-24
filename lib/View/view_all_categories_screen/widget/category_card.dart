
import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String? image;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.buttonColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: (image != null && image!.isNotEmpty)
                    ? Image.network(
                        image!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: AppColors.buttonColor.withOpacity(0.5),
                              size: 32,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.buttonColor.withOpacity(0.5),
                              size: 32,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.category_outlined,
                          color: AppColors.buttonColor,
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Category Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}