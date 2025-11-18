
import 'package:flutter/material.dart';
import 'package:project_2/services/service_details_service.dart';

class BrowseAllCategoryProvider with ChangeNotifier {
  final ServiceDetailsService _workService = ServiceDetailsService();

  List<String> _categories = [];
  List<String> get categories => _categories;

  // Map to store image for each category
  Map<String, String> _categoryImages = {};
  Map<String, String> get categoryImages => _categoryImages;

  // Fetch categories and images
  Future<void> fetchCategories() async {
    final works = await _workService.getAllWorks();

    // Extract unique categories
    _categories = works.map((w) => w.name).toSet().toList();

    // Store first image of each category
    _categoryImages = {};
    for (var category in _categories) {
      final work = works.firstWhere((w) => w.name == category);
      _categoryImages[category] = work.image;
    }

    notifyListeners();
  }
}
