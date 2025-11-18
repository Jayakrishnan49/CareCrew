import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CloudinaryService {
  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'dq4gjskwm',  
    'user_profile_image', 
    cache: false,
  );

  // Upload single image
  Future<String?> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      debugPrint("Cloudinary upload error: $e");
      return null;
    }
  }

  // Upload multiple images
  Future<List<String>> uploadMultipleImages(List<File> images) async {
    List<String> imageUrls = [];
    
    for (File image in images) {
      try {
        CloudinaryResponse response = await _cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        imageUrls.add(response.secureUrl);
        debugPrint("Image uploaded: ${response.secureUrl}");
      } catch (e) {
        debugPrint("Failed to upload image: $e");
      }
    }
    
    return imageUrls;
  }
}