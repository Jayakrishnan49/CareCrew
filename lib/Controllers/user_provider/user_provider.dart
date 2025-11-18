import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2/model/user_model.dart';
import 'package:project_2/services/user_firebase_service.dart';

class UserProvider extends ChangeNotifier {
  final UserFirebaseService _userService = UserFirebaseService();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _currentUser;
    String? userId;

  String? _gender;
  String? _imagePath;

  UserModel? get currentUser => _currentUser;
  String? get imagePath => _imagePath;
  String? get gender => _gender;

  // Setters from UI
  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void setImage(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void clearImage() {
    _imagePath = null;
    notifyListeners();
  }

  // READ user
  Future<void> fetchUser(String userId) async {
    _currentUser = await _userService.getUser(userId);

    // Sync UI state with fetched user data
    if (_currentUser != null) {
      _gender = _currentUser!.gender;
      _imagePath = _currentUser!.profilePhoto;
    }
    notifyListeners();
  }

Future<void> saveUser(UserModel user) async {
  String imageUrl;

  if (_imagePath != null && _imagePath!.isNotEmpty) {
    // Upload user-selected image
    final uploadedUrl = await uploadImageToCloudinary(_imagePath!);
    imageUrl = uploadedUrl ?? "https://res.cloudinary.com/dq4gjskwm/image/upload/v1759235279/default_profile_x437jc.png";
  } else {
    // Use default image if user didn't select any
    imageUrl = "https://res.cloudinary.com/dq4gjskwm/image/upload/v1759235279/default_profile_x437jc.png"; // ✅ Replace with your Cloudinary URL
  }

  final updatedUser = user.copyWith(
    profilePhoto: imageUrl, 
    gender: _gender ?? user.gender,
  );

  await _userService.createOrUpdateUser(updatedUser);
  _currentUser = updatedUser;
  log(updatedUser.email);
  notifyListeners();
}




  // UPDATE user (includes _imagePath and _gender from UI)
  Future<void> updateUser(Map<String, dynamic> updates) async {
    if (_currentUser == null) return;

    updates['profilePhoto'] = _imagePath ?? updates['profilePhoto'];
    updates['gender'] = _gender ?? updates['gender'];

    await _userService.updateUser(_currentUser!.userId, updates);

    _currentUser = _currentUser!.copyWith(
      profilePhoto: updates['profilePhoto'],
      name: updates['name'] ?? _currentUser!.name,
      gender: updates['gender'],
      phoneNumber: updates['phoneNumber'] ?? _currentUser!.phoneNumber,
      email: updates['email'] ?? _currentUser!.email,
    );
    notifyListeners();
  }

  // DELETE user
  Future<void> deleteUser() async {
    if (_currentUser == null) return;
    await _userService.deleteUser(_currentUser!.userId);
    _currentUser = null;
    _gender = null;
    _imagePath = null;
    notifyListeners();
  }

    Future<String?> checkUserRegistration() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        this.userId = userQuery.docs.first.id;
        return this.userId;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel registration: $e');
      return null;
    }
  }


Future<String?> uploadImageToCloudinary(String imagePath) async {
  final cloudinary = CloudinaryPublic(
    'dq4gjskwm', 
    'user_profile_image',
    cache: false,
  );

  try {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        imagePath,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    return response.secureUrl; // This URL will be stored in Firestore
  } catch (e) {
    debugPrint("Cloudinary upload error: $e");
    return null;
  }
}
}