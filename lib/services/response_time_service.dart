import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResponseTimeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // When Provider Accepts/Rejects Request 
  Future<void> recordProviderResponse({
    required String bookingId,
    required String providerId,
    required String userId,
    required String newStatus,
  }) async {
    try {
      final now = DateTime.now();

      // Get the booking request to find requestSentAt time
      final bookingDoc = await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(bookingId)
          .get();

      if (!bookingDoc.exists) {
        throw Exception('Booking not found');
      }

      final bookingData = bookingDoc.data()!;
      final requestSentAt = (bookingData['requestSentAt'] as Timestamp).toDate();

      // Calculate response time in minutes
      final responseTimeMinutes = now.difference(requestSentAt).inMinutes;

      // Update the booking with response info
      final updateData = {
        'status': newStatus,
        'responseAt': Timestamp.fromDate(now),
        'responseTimeMinutes': responseTimeMinutes,
      };

      // Update in provider's collection
      await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(bookingId)
          .update(updateData);

      // Update in user's collection
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_bookings')
          .doc(bookingId)
          .update(updateData);

      // Update provider's average response time
      await _updateProviderAverageResponseTime(
        providerId: providerId,
        newResponseTimeMinutes: responseTimeMinutes,
      );

      print('Response recorded: $responseTimeMinutes minutes');
    } catch (e) {
      print('Error recording response: $e');
      rethrow;
    }
  }

  //  Update Provider's Average Response Time
  Future<void> _updateProviderAverageResponseTime({
    required String providerId,
    required int newResponseTimeMinutes,
  }) async {
    try {
      final providerRef = _firestore.collection('users').doc(providerId);
      final providerDoc = await providerRef.get();

      if (!providerDoc.exists) return;

      final data = providerDoc.data()!;
      final currentAverage = (data['averageResponseTimeMinutes'] ?? 0.0).toDouble();
      final totalResponses = (data['totalResponses'] ?? 0) as int;

      // Calculate new average
      // Formula: ((old_average * old_count) + new_value) / (old_count + 1)
      final newAverage = totalResponses == 0
          ? newResponseTimeMinutes.toDouble()
          : ((currentAverage * totalResponses) + newResponseTimeMinutes) / (totalResponses + 1);

      // Update provider document
      await providerRef.update({
        'averageResponseTimeMinutes': newAverage,
        'totalResponses': totalResponses + 1,
        'lastResponseAt': Timestamp.now(),
      });

      print('Updated provider average: ${newAverage.toStringAsFixed(1)} mins');
    } catch (e) {
      print('Error updating average: $e');
    }
  }

  //Get Provider's Response Time Stats
  Future<Map<String, dynamic>> getProviderResponseStats(String providerId) async {
    try {
      // Get all responded bookings
      final bookingsSnapshot = await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .where('responseTimeMinutes', isNotEqualTo: null)
          .get();

      if (bookingsSnapshot.docs.isEmpty) {
        return {
          'averageMinutes': 0.0,
          'totalResponses': 0,
          'fastestMinutes': 0.0,
          'slowestMinutes': 0.0,
        };
      }

      final responseTimes = bookingsSnapshot.docs
          .map((doc) => (doc.data()['responseTimeMinutes'] as int).toDouble())
          .toList();

      final average = responseTimes.reduce((a, b) => a + b) / responseTimes.length;
      final fastest = responseTimes.reduce((a, b) => a < b ? a : b);
      final slowest = responseTimes.reduce((a, b) => a > b ? a : b);

      return {
        'averageMinutes': average,
        'totalResponses': responseTimes.length,
        'fastestMinutes': fastest,
        'slowestMinutes': slowest,
      };
    } catch (e) {
      print('Error getting stats: $e');
      return {
        'averageMinutes': 0.0,
        'totalResponses': 0,
        'fastestMinutes': 0.0,
        'slowestMinutes': 0.0,
      };
    }
  }

  //  Format Response Time for Display 
  String formatResponseTime(double minutes) {
    if (minutes < 1) {
      return 'Just now';
    } else if (minutes < 60) {
      return '${minutes.round()} mins';
    } else if (minutes < 1440) { // Less than 24 hours
      final hours = (minutes / 60);
      return hours < 2 
          ? '${hours.toStringAsFixed(1)} hour'
          : '${hours.round()} hours';
    } else {
      final days = (minutes / 1440);
      return days < 2
          ? '${days.toStringAsFixed(1)} day'
          : '${days.round()} days';
    }
  }

  // Get Response Speed Badge 
  Map<String, dynamic> getResponseSpeedBadge(double? averageMinutes) {
    if (averageMinutes == null || averageMinutes == 0) {
      return {
        'label': 'New Provider',
        'color': Colors.grey,
        'icon': Icons.new_releases,
      };
    }

    if (averageMinutes < 30) {
      return {
        'label': 'Lightning Fast ⚡',
        'color': Colors.green,
        'icon': Icons.flash_on,
      };
    } else if (averageMinutes < 120) {
      return {
        'label': 'Quick Response',
        'color': Colors.lightGreen,
        'icon': Icons.speed,
      };
    } else if (averageMinutes < 1440) {
      return {
        'label': 'Responsive',
        'color': Colors.orange,
        'icon': Icons.schedule,
      };
    } else {
      return {
        'label': 'Slow Response',
        'color': Colors.red,
        'icon': Icons.hourglass_empty,
      };
    }
  }
}

