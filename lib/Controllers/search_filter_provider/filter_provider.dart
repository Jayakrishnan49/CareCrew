import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  Map<String, dynamic> _tempFilters = {};
  String? _selectedCategory;
  String? _selectedGender;
  String? _selectedExperience;

  // Getters
  Map<String, dynamic> get tempFilters => _tempFilters;
  String? get selectedCategory => _selectedCategory;
  String? get selectedGender => _selectedGender;
  String? get selectedExperience => _selectedExperience;

  // Initialize with current filters
  void initializeFilters(Map<String, dynamic> currentFilters) {
    _tempFilters = Map.from(currentFilters);
    _selectedCategory = _tempFilters['Category'];
    _selectedGender = _tempFilters['Gender'];
    _selectedExperience = _tempFilters['Experience'];
    notifyListeners();
  }

  // Set category
  void setCategory(String? value) {
    _selectedCategory = value;
    if (value != null) {
      _tempFilters['Category'] = value;
    } else {
      _tempFilters.remove('Category');
    }
    notifyListeners();
  }

  // Set gender
  void setGender(String value) {
    _selectedGender = _selectedGender == value ? null : value;
    if (_selectedGender != null) {
      _tempFilters['Gender'] = _selectedGender;
    } else {
      _tempFilters.remove('Gender');
    }
    notifyListeners();
  }

  // Set experience
  void setExperience(String value) {
    _selectedExperience = _selectedExperience == value ? null : value;
    if (_selectedExperience != null) {
      _tempFilters['Experience'] = _selectedExperience;
    } else {
      _tempFilters.remove('Experience');
    }
    notifyListeners();
  }

  // Clear all filters
  void clearAllFilters() {
    _tempFilters.clear();
    _selectedCategory = null;
    _selectedGender = null;
    _selectedExperience = null;
    notifyListeners();
  }

  // Reset provider
  void reset() {
    _tempFilters = {};
    _selectedCategory = null;
    _selectedGender = null;
    _selectedExperience = null;
  }
}