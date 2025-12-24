import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_2/view/home_screen/home_screen_components/service_provider_list_section/service_provider_card.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/service_provider_details_provider/service_provider_details_provider.dart';
import 'package:project_2/view/view_all_service_provider_screen/view_all_service_provider_screen.dart';
import 'package:provider/provider.dart';

class ServiceProviderList extends StatelessWidget {
  const ServiceProviderList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ServiceProviderDetailsProvider>(context);

    //  Fetch providers only once when widget builds first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.providers.isEmpty && !provider.isLoading) {
        provider.fetchAllProviders();
      }
    });

    final providers = provider.providers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated Providers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllServiceProviderScreen(),));
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    // fontSize: 14,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          color: AppColors.secondary,
          height: 260,
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : providers.isEmpty
                  ? const Center(child: Text('No providers found.'))
                  : AnimationLimiter(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        itemCount: providers.length,
                        itemBuilder: (context, index) {
                          final providerData = providers[index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 3000),
                            child: SlideAnimation(
                              horizontalOffset: 10,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child:
                                      ServiceProviderCard(provider: providerData),
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

