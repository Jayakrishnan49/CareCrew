
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_2/services/booking_service.dart';
import 'package:project_2/model/service_model.dart';

class BookingRequestProvider extends ChangeNotifier {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _serviceType = '';
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  
  final BookingService _bookingService = BookingService();

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String get serviceType => _serviceType;
  String get selectedServiceType => _serviceType;
  List<File> get selectedImages => _selectedImages;

  void initializeServiceType(String service) {
    _serviceType = service;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void addImage(File image) {
    if (_selectedImages.length < 5) {
      _selectedImages.add(image);
      notifyListeners();
    }
  }

  void removeImage(File image) {
    _selectedImages.remove(image);
    notifyListeners();
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        for (var image in images) {
          if (_selectedImages.length < 5) {
            _selectedImages.add(File(image.path));
          }
        }
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Helper method to format TimeOfDay to string
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Submit booking method - Updated to work without price
  Future<void> submitBooking(ServiceProviderModel provider) async {
    try {
      await _bookingService.submitBookingRequest(
        providerId: provider.providerId,
        providerName: provider.name,
        providerPhoto: provider.profilePhoto,
        serviceType: _serviceType,
        date: _selectedDate!,
        time: _formatTimeOfDay(_selectedTime!),
        address: addressController.text.trim(),
        //  phoneNumber: provider.phoneNumber,
        notes: notesController.text.trim(),
        images: _selectedImages,
        price: null, // Your model doesn't have price
      );
    } catch (e) {
      rethrow;
    }
  }

  void reset() {
    _selectedDate = null;
    _selectedTime = null;
    _selectedImages.clear();
    addressController.clear();
    notesController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}