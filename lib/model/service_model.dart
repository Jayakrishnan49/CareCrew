import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderModel {
  final String providerId;
  final String profilePhoto;
  final String name;
  final String gender;
  final String phoneNumber;
  final String location;
  final String email;
  final String idCardPhoto;
  final String experienceCertificate;
  final String yearsOfexperience;
  final String selectService;
  final String status;
  final Timestamp? approvedAt;
  
  final double? averageResponseTimeMinutes;
  final int totalResponses;
  final Timestamp? lastResponseAt;

  ServiceProviderModel({
    required this.providerId,
    required this.profilePhoto,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.location,
    required this.email,
    required this.idCardPhoto,
    required this.experienceCertificate,
    required this.yearsOfexperience,
    required this.selectService,
    required this.status,
    this.approvedAt,
    this.averageResponseTimeMinutes,
    this.totalResponses = 0,
    this.lastResponseAt,
  });

  // Helper methods for response time display
  String get formattedResponseTime {
    if (averageResponseTimeMinutes == null || averageResponseTimeMinutes == 0) {
      return 'New';
    }
    
    if (averageResponseTimeMinutes! < 60) {
      return '~${averageResponseTimeMinutes!.round()} mins';
    } else if (averageResponseTimeMinutes! < 1440) {
      final hours = (averageResponseTimeMinutes! / 60).round();
      return '~$hours ${hours == 1 ? 'hour' : 'hours'}';
    } else {
      final days = (averageResponseTimeMinutes! / 1440).round();
      return '~$days ${days == 1 ? 'day' : 'days'}';
    }
  }

  String get responseSpeedBadge {
    if (averageResponseTimeMinutes == null || averageResponseTimeMinutes == 0) {
      return 'New';
    }
    if (averageResponseTimeMinutes! < 30) {
      return 'Lightning Fast';
    }
    if (averageResponseTimeMinutes! < 120) {
      return 'Quick';
    }
    if (averageResponseTimeMinutes! < 1440) {
      return 'Responsive';
    }
    return 'Slow';
  }

  factory ServiceProviderModel.fromMap(String userId, Map<String, dynamic> data) {
    return ServiceProviderModel(
      providerId: userId,
      profilePhoto: data['profilePhoto'] ?? '',
      name: data['name'] ?? '',
      gender: data['gender'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      location: data['location'] ?? '',
      email: data['email'] ?? '',
      idCardPhoto: data['idCardPhoto'] ?? '',
      experienceCertificate: data['experienceCertificate'] ?? '',
      yearsOfexperience: data['yearsOfexperience'] ?? '',
      selectService: data['selectService'] ?? '',
      status: data['status'] ?? '',
      approvedAt: data['approvedAt'] as Timestamp?,
      averageResponseTimeMinutes: data['averageResponseTimeMinutes']?.toDouble(),
      totalResponses: data['totalResponses'] ?? 0,
      lastResponseAt: data['lastResponseAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profilePhoto': profilePhoto,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'location': location,
      'email': email,
      'idCardPhoto': idCardPhoto,
      'experienceCertificate': experienceCertificate,
      'yearsOfexperience': yearsOfexperience,
      'selectService': selectService,
      'status': status,
      'approvedAt': approvedAt,
   
      'averageResponseTimeMinutes': averageResponseTimeMinutes,
      'totalResponses': totalResponses,
      'lastResponseAt': lastResponseAt,
    };
  }

  ServiceProviderModel copyWith({
    String? userId,
    String? profilePhoto,
    String? name,
    String? gender,
    String? phoneNumber,
    String? location,
    String? email,
    String? idCardPhoto,
    String? experienceCertificate,
    String? yearsOfexperience,
    String? selectService,
    String? status,
    Timestamp? approvedAt,
    double? averageResponseTimeMinutes,
    int? totalResponses,
    Timestamp? lastResponseAt,
  }) {
    return ServiceProviderModel(
      providerId: userId ?? this.providerId,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      email: email ?? this.email,
      idCardPhoto: idCardPhoto ?? this.idCardPhoto,
      experienceCertificate: experienceCertificate ?? this.experienceCertificate,
      yearsOfexperience: yearsOfexperience ?? this.yearsOfexperience,
      selectService: selectService ?? this.selectService,
      status: status ?? this.status,
      approvedAt: approvedAt ?? this.approvedAt,
      averageResponseTimeMinutes: averageResponseTimeMinutes ?? this.averageResponseTimeMinutes,
      totalResponses: totalResponses ?? this.totalResponses,
      lastResponseAt: lastResponseAt ?? this.lastResponseAt,
    );
  }
}


//  Response Time Statistics 
class ResponseTimeStats {
  final double averageMinutes;
  final int totalResponses;
  final double fastestMinutes;
  final double slowestMinutes;

  ResponseTimeStats({
    required this.averageMinutes,
    required this.totalResponses,
    required this.fastestMinutes,
    required this.slowestMinutes,
  });

  String get formattedAverage {
    if (averageMinutes < 60) {
      return '${averageMinutes.round()} mins';
    } else if (averageMinutes < 1440) {
      return '${(averageMinutes / 60).toStringAsFixed(1)} hours';
    } else {
      return '${(averageMinutes / 1440).toStringAsFixed(1)} days';
    }
  }
}