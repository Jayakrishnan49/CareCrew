import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/search_filter_provider/search_provider.dart';
import 'package:project_2/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;

  const SearchHeader({
    super.key,
    required this.searchController,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return AppBar(
      backgroundColor: AppColors.secondary,
      leading: IconButton(
        onPressed: () {
          searchProvider.clearAll();
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: AppColors.textColor),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: CustomTextFormField(
          controller: searchController,
          hintText: "Search categories or services...",
          validator: (_) => null,
          prefixIcon: Icons.search,
          onChanged: (value) => searchProvider.setSearchQuery(value),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: searchProvider.appliedFilters.isNotEmpty
                  ? AppColors.primary
                  : Colors.grey.shade300,
              width: searchProvider.appliedFilters.isNotEmpty ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: onFilterTap,
                icon: Icon(
                  Icons.tune,
                  color: searchProvider.appliedFilters.isNotEmpty
                      ? AppColors.primary
                      : Colors.grey[700],
                ),
              ),
              if (searchProvider.appliedFilters.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${searchProvider.appliedFilters.length}',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}