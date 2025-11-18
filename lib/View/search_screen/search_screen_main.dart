
import 'package:flutter/material.dart';
import 'package:project_2/View/search_screen/dialogs/filter_dialog.dart';
import 'package:project_2/View/search_screen/widgets/category_suggestions.dart';
import 'package:project_2/View/search_screen/widgets/filter_chips.dart';
import 'package:project_2/View/search_screen/widgets/search_header.dart';
import 'package:project_2/View/search_screen/widgets/search_results.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/browse_all_category_provider/browse_all_category_provider.dart';
import 'package:project_2/controllers/search_filter_provider/search_provider.dart';
import 'package:project_2/controllers/service_provider_details_provider/service_provider_details_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final categoryProvider = Provider.of<BrowseAllCategoryProvider>(context);
    final providerDetailsProvider = Provider.of<ServiceProviderDetailsProvider>(context);

    final filteredCategories = searchProvider.filterCategories(categoryProvider.categories);
    final filteredProviders = searchProvider.filterProviders(providerDetailsProvider.providers);

    // Sync controller with search query
    if (searchController.text != searchProvider.searchQuery) {
      searchController.text = searchProvider.searchQuery;
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: searchController.text.length),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SearchHeader(
          searchController: searchController,
          onFilterTap: () => _showFilterDialog(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (searchProvider.appliedFilters.isNotEmpty)
              FilterChips(searchProvider: searchProvider),
            Expanded(
              child: searchProvider.isSearching
                  ? SearchResults(
                      filteredCategories: filteredCategories,
                      filteredProviders: filteredProviders,
                      categoryProvider: categoryProvider,
                    )
                  : CategorySuggestions(categoryProvider: categoryProvider),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final categoryProvider = Provider.of<BrowseAllCategoryProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        currentFilters: searchProvider.appliedFilters,
        categories: categoryProvider.categories,
        onApplyFilters: (filters) {
          searchProvider.applyFilters(filters);
        },
      ),
    );
  }
}