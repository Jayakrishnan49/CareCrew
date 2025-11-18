import 'package:flutter/material.dart';
import 'package:project_2/Constants/app_color.dart';
import 'package:project_2/model/service_model.dart';

class ProviderInfoCard extends StatelessWidget {
  final ServiceProviderModel provider;
  final double rating;
  final int totalReviews;

  const ProviderInfoCard({
    super.key,
    required this.provider,
    this.rating = 4.5,
    this.totalReviews = 124,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  provider.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  provider.selectService,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFFFC107),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                ' ($totalReviews reviews)',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.hintText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.location_on_outlined, provider.location),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.work_outline,
              '${provider.yearsOfexperience} years of experience'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.phone_outlined, provider.phoneNumber),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.email_outlined, provider.email),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.person_outline, provider.gender),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.hintText,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}