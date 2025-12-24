import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/model/service_model.dart';
import 'package:project_2/view/service_provider_details_page/service_provider_details_page.dart';

class ProviderDetailCard extends StatelessWidget {
  final ServiceProviderModel provider;

  const ProviderDetailCard({
    super.key,
    required this.provider,
  });

  Color _getResponseBadgeColor() {
  final minutes = provider.averageResponseTimeMinutes;

  if (minutes == null) {
    return Colors.blue; // New
  }

  if (minutes < 30) {
    return Colors.green; // Fast
  }

  if (minutes < 120) {
    return Colors.orange; // Medium
  }

  return Colors.red; // Slow
}


  @override
  Widget build(BuildContext context) {
    final experienceYears = int.tryParse(provider.yearsOfexperience) ?? 0;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceProviderDetailsPage(provider: provider),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.10),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Profile Image
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.buttonColor,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: provider.profilePhoto.isNotEmpty
    ? Image.network(
        provider.profilePhoto,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;

          // PLACEHOLDER (loading)
          return Container(
            color: Colors.grey[200],
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.grey,
            ),
          );
        },
        errorBuilder: (context, error, stack) {
          // ERROR
          return Container(
            color: Colors.grey[200],
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.grey,
            ),
          );
        },
      )
    : Container(
        // NO IMAGE URL
        color: Colors.grey[200],
        child: const Icon(
          Icons.person,
          size: 35,
          color: Colors.grey,
        ),
      ),

                    ),
                  ),
                  const SizedBox(width: 14),
                  
                  // Name and Service
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                provider.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (provider.status == 'approved')
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.verified.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.verified, size: 12, color: AppColors.verified),
                                    SizedBox(width: 2),
                                    Text(
                                      'Verified',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.verified,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            provider.selectService,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 14),
              
              // Info Grid
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      Icons.work_outline,
                      '$experienceYears+ Years',
                      'Experience',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.location_on_outlined,
                      provider.location.split(',').first,
                      'Location',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.currency_rupee,
                      '${provider.firstHourPrice}/hr',
                      'Starting',
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Response Time Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _getResponseBadgeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getResponseBadgeColor().withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: _getResponseBadgeColor(),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Response time: ${provider.formattedResponseTime}',
                      style: TextStyle(
                        fontSize: 12,
                        color: _getResponseBadgeColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '• ${provider.responseSpeedBadge}',
                      style: TextStyle(
                        fontSize: 11,
                        color: _getResponseBadgeColor().withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}