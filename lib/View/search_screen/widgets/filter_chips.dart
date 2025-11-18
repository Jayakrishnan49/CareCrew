import 'package:flutter/material.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/search_filter_provider/search_provider.dart';

class FilterChips extends StatelessWidget {
  final SearchProvider searchProvider;

  const FilterChips({
    super.key,
    required this.searchProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[50],
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: searchProvider.appliedFilters.entries.map((entry) {
          return Chip(
            label: Text(
              '${entry.key}: ${entry.value}',
              style: const TextStyle(fontSize: 12),
            ),
            deleteIcon: const Icon(Icons.close, size: 16),
            onDeleted: () => searchProvider.removeFilter(entry.key),
            backgroundColor: AppColors.primary.withOpacity(0.1),
            side: BorderSide(color: AppColors.primary),
          );
        }).toList(),
      ),
    );
  }
}