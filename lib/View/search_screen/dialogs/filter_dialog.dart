import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2/constants/app_color.dart';
import 'package:project_2/controllers/search_filter_provider/filter_provider.dart';

class FilterDialog extends StatelessWidget {
  final Map<String, dynamic> currentFilters;
  final List<String> categories;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterDialog({
    super.key,
    required this.currentFilters,
    required this.categories,
    required this.onApplyFilters,
  });

  final List<String> genders = const ['Male', 'Female', 'Other'];
  final List<String> experienceRanges = const ['0-2 years', '3-5 years', '6-10 years', '10+ years'];

  @override
  Widget build(BuildContext context) {
    // Initialize filters when dialog is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilterProvider>().initializeFilters(currentFilters);
    });

    return Consumer<FilterProvider>(
      builder: (context, filterProvider, _) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 650, maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (categories.isNotEmpty)
                          _buildDropdownSection(
                            context,
                            'Select Category',
                            categories,
                            filterProvider.selectedCategory,
                            Icons.category,
                            (value) => filterProvider.setCategory(value),
                          ),
                        const SizedBox(height: 20),
                        _buildChipSection(
                          context,
                          'Gender',
                          genders,
                          filterProvider.selectedGender,
                          Icons.person,
                          (value) => filterProvider.setGender(value),
                        ),
                        const SizedBox(height: 20),
                        _buildChipSection(
                          context,
                          'Years of Experience',
                          experienceRanges,
                          filterProvider.selectedExperience,
                          Icons.work,
                          (value) => filterProvider.setExperience(value),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildFooter(context, filterProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.filter_alt, color: AppColors.secondary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Filter Options',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<FilterProvider>().reset();
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: AppColors.secondary),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, FilterProvider filterProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => filterProvider.clearAllFilters(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onApplyFilters(filterProvider.tempFilters);
                filterProvider.reset();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection(
    BuildContext context,
    String title,
    List<String> items,
    String? selectedValue,
    IconData icon,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              hint: Text('Select ${title.toLowerCase()}'),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChipSection(
    BuildContext context,
    String title,
    List<String> items,
    String? selectedValue,
    IconData icon,
    Function(String) onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final bool isSelected = selectedValue == item;
            return ChoiceChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (_) => onTap(item),
              selectedColor: AppColors.primary.withOpacity(0.15),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}