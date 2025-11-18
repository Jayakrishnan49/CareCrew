
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Set<String> _favoriteIds = {};
  bool _isLoading = false;

  Set<String> get favoriteIds => _favoriteIds;
  bool get isLoading => _isLoading;
  int get favoriteCount => _favoriteIds.length;

  // Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  // Check if a provider is favorite
  bool isFavorite(String providerId) {
    return _favoriteIds.contains(providerId);
  }

  // Load favorites from Firestore when provider initializes
  Future<void> loadFavorites() async {
    if (_currentUserId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('favorites')
          .get();

      _favoriteIds = snapshot.docs.map((doc) => doc.id).toSet();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String providerId) async {
    if (_currentUserId == null) {
      debugPrint('User not logged in');
      return;
    }

    final isFav = _favoriteIds.contains(providerId);

    // Optimistically update UI
    if (isFav) {
      _favoriteIds.remove(providerId);
    } else {
      _favoriteIds.add(providerId);
    }
    notifyListeners();

    try {
      final docRef = _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('favorites')
          .doc(providerId);

      if (isFav) {
        // Remove from favorites
        await docRef.delete();
      } else {
        // Add to favorites
        await docRef.set({
          'addedAt': FieldValue.serverTimestamp(),
          'providerId': providerId,
        });
      }
    } catch (e) {
      // Revert on error
      if (isFav) {
        _favoriteIds.add(providerId);
      } else {
        _favoriteIds.remove(providerId);
      }
      notifyListeners();
      debugPrint('Error toggling favorite: $e');
      rethrow; // Re-throw to handle in UI
    }
  }

  // Get all favorite provider IDs as stream
  Stream<List<String>> getFavoritesStream() {
    if (_currentUserId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  // Get favorite providers with full details
  Future<List<String>> getFavoriteProviderIds() async {
    if (_currentUserId == null) return [];

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('favorites')
          .get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      debugPrint('Error getting favorite IDs: $e');
      return [];
    }
  }
  // Clear all favorites
  Future<void> clearAllFavorites() async {
    if (_currentUserId == null) return;

    try {
      final batch = _firestore.batch();
      final snapshot = await _firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('favorites')
          .get();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      _favoriteIds.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing favorites: $e');
      rethrow;
    }
  }
}