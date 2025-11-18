import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';

class ProviderExperienceSection extends StatelessWidget {
  final String yearsOfExperience;
  final String service;

  const ProviderExperienceSection({
    super.key,
    required this.yearsOfExperience,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Professional Experience',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'With $yearsOfExperience years of experience in $service, this provider has built a strong reputation for quality service and customer satisfaction.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor.withValues(alpha: 0.7),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}