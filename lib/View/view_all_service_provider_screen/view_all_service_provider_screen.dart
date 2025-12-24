import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/search_filter_provider/search_provider.dart';
import 'package:project_2/controllers/service_provider_details_provider/service_provider_details_provider.dart';
import 'package:project_2/model/service_model.dart';
import 'package:project_2/view/view_all_service_provider_screen/widget/provider_detail_card.dart';
import 'package:provider/provider.dart';

class ViewAllServiceProviderScreen extends StatelessWidget {
  const ViewAllServiceProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerDetailsProvider = Provider.of<ServiceProviderDetailsProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    
    // Use the existing filterProviders method from SearchProvider
    List<ServiceProviderModel> filteredProviders = searchProvider.filterProviders(
      providerDetailsProvider.providers,
    );

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
          onPressed: () {
            // Clear search when leaving screen
            searchProvider.clearAll();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'All Service Providers',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => searchProvider.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search by name or service...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: searchProvider.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400]),
                        onPressed: () => searchProvider.clearAll(),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProviders.length} Provider${filteredProviders.length != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (searchProvider.searchQuery.isNotEmpty)
                  Flexible(
                    child: Text(
                      'Showing results for "${searchProvider.searchQuery}"',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),

          // Providers List
          Expanded(
            child: providerDetailsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredProviders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            Text(
                              searchProvider.searchQuery.isNotEmpty
                                  ? 'No providers found for "${searchProvider.searchQuery}"'
                                  : 'No providers available',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (searchProvider.searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => searchProvider.clearAll(),
                                child: const Text('Clear search'),
                              ),
                            ],
                          ],
                        ),
                      )
                    : AnimationLimiter(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredProviders.length,
                          itemBuilder: (context, index) {
                            final providerData = filteredProviders[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1500),
                              child: SlideAnimation(
                                verticalOffset: 20,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ProviderDetailCard(
                                      provider: providerData,
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
      ),
    );
  }
}