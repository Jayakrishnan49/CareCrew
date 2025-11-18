import 'package:flutter/material.dart';
import 'package:project_2/model/service_model.dart';

class SearchProvider extends ChangeNotifier {
  String _searchQuery = '';
  Map<String, dynamic> _appliedFilters = {};
  bool _isSearching = false;

  String get searchQuery => _searchQuery;
  Map<String, dynamic> get appliedFilters => _appliedFilters;
  bool get isSearching => _isSearching;

  void setSearchQuery(String query) {
    _searchQuery = query;
    _isSearching = query.isNotEmpty || _appliedFilters.isNotEmpty;
    notifyListeners();
  }

  void applyFilters(Map<String, dynamic> filters) {
    _appliedFilters = filters;
    _isSearching = _searchQuery.isNotEmpty || filters.isNotEmpty;
    notifyListeners();
  }

  void removeFilter(String key) {
    _appliedFilters.remove(key);
    _isSearching = _searchQuery.isNotEmpty || _appliedFilters.isNotEmpty;
    notifyListeners();
  }

  void clearAll() {
    _searchQuery = '';
    _appliedFilters.clear();
    _isSearching = false;
    notifyListeners();
  }

  // Filter categories based on search query
  List<String> filterCategories(List<String> allCategories) {
    var filtered = allCategories;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((category) =>
              category.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  // Filter providers based on search query and filters
  List<ServiceProviderModel> filterProviders(List<ServiceProviderModel> allProviders) {
    var filtered = allProviders;

    // Filter by search query (name or service)
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((provider) {
        final name = provider.name.toLowerCase();
        final service = provider.selectService.toLowerCase();
        final location = provider.location.toLowerCase();
        final query = _searchQuery.toLowerCase();
        
        return name.contains(query) || 
               service.contains(query) || 
               location.contains(query);
      }).toList();
    }

    // Filter by category/service
    if (_appliedFilters.containsKey('Category')) {
      final selectedCategory = _appliedFilters['Category'].toString();
      filtered = filtered.where((provider) {
        return provider.selectService == selectedCategory;
      }).toList();
    }

    // Filter by gender
    if (_appliedFilters.containsKey('Gender')) {
      final selectedGender = _appliedFilters['Gender'].toString();
      filtered = filtered.where((provider) {
        return provider.gender == selectedGender;
      }).toList();
    }

    // Filter by years of experience
    if (_appliedFilters.containsKey('Experience')) {
      filtered = _filterByExperience(filtered, _appliedFilters['Experience']);
    }

    // Filter by location
    if (_appliedFilters.containsKey('Location')) {
      final selectedLocation = _appliedFilters['Location'].toString();
      filtered = filtered.where((provider) {
        return provider.location.toLowerCase().contains(selectedLocation.toLowerCase());
      }).toList();
    }

    // Filter by status (only show approved providers)
    filtered = filtered.where((provider) {
      return provider.status.toLowerCase() == 'approved';
    }).toList();

    return filtered;
  }

  List<ServiceProviderModel> _filterByExperience(
    List<ServiceProviderModel> providers, 
    String experienceRange
  ) {
    return providers.where((provider) {
      final experience = int.tryParse(provider.yearsOfexperience) ?? 0;
      
      if (experienceRange == '0-2 years') return experience >= 0 && experience <= 2;
      if (experienceRange == '3-5 years') return experience >= 3 && experience <= 5;
      if (experienceRange == '6-10 years') return experience >= 6 && experience <= 10;
      if (experienceRange == '10+ years') return experience > 10;
      
      return true;
    }).toList();
  }
}