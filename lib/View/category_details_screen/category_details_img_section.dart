import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';

class CategoryDetailsImgSection extends StatelessWidget {
  
  final dynamic imageUrl;
  
  final dynamic title;
  
  final dynamic price;

  const CategoryDetailsImgSection({super.key,required this.imageUrl,required this.title,required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                  // errorBuilder: (context, error, stackTrace) {
                  //   return Container(
                  //     width: double.infinity,
                  //     height: 400,
                  //     color: Colors.grey[300],
                  //     child: const Icon(Icons.plumbing, size: 80),
                  //   );
                  // },
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor.withValues(alpha: 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor.withValues(alpha: 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color:AppColors.primary),
                      onPressed: () {},
                    ),
                  ),
                ),
                // Overlay Card with Title, Price, and Rating
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -120,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textColor.withValues(alpha: 0.20),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                         Text(
                          '₹ $price',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '₹120 / Later Hourly Charge',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Duration :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '1 Hour',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Rating :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
}