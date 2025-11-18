import 'package:flutter/material.dart';
import 'package:project_2/view/service_provider_details_page/service_provider_details_page.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/service_provider_details_provider/service_provider_details_provider.dart';
import 'package:project_2/widgets/response_time_badge.dart';
import 'package:provider/provider.dart';

class ShowParticularServiceProvidersMain extends StatelessWidget {
  final String category;
  const ShowParticularServiceProvidersMain({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ServiceProviderDetailsProvider>(context);
    if (providerData.providers.isEmpty && !providerData.isLoading) {
      Future.microtask(() => providerData.fetchAllProviders());
    }
    final filteredProvider = providerData.getProvidersByCategory(category);
    
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.secondary),
        elevation: 0,
        title: Text(
          'Select Worker',
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: providerData.isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.primary))
          : filteredProvider.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/worker_not_available.png', width: 300),
                      const SizedBox(height: 20),
                      Text(
                        'No workers yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No $category workers available',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProvider.length,
                  itemBuilder: (context, index) {
                    final worker = filteredProvider[index];
                    return _buildWorkerCard(context, worker);
                  },
                ),
    );
  }

  Widget _buildWorkerCard(BuildContext context, worker) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: worker.profilePhoto.isNotEmpty
                        ? Image.network(
                            worker.profilePhoto,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildAvatarFallback(worker.name);
                            },
                          )
                        : _buildAvatarFallback(worker.name),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Worker Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Response Time Badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              worker.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3748),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ResponseTimeBadge(provider: worker), // ← NEW: Response time badge
                        ],
                      ),
                      const SizedBox(height: 6),
                      
                      // Service Type
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          worker.selectService,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Experience and Rating Row
                      Row(
                        children: [
                          // Experience
                          Icon(
                            Icons.work_outline,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${worker.yearsOfexperience} yrs',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Rating
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(120)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      
                      // Location if available
                      if (worker.location.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                worker.location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          
          // Continue Booking Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceProviderDetailsPage(provider: worker),
                  ),
                );
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue Booking',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback(String name) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
