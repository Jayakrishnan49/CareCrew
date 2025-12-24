class UserModel {
  final String userId;
  final String profilePhoto;
  final String name;
  final String gender;
  final String phoneNumber;
  final String email;
  final double? latitude;
  final double? longitude;
  final DateTime? locationUpdatedAt;

  UserModel({
    required this.userId,
    required this.profilePhoto,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    this.latitude,
    this.longitude,
    this.locationUpdatedAt,
  });

  //convert from json
  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
      userId: json['userId']??'',
      profilePhoto: json['profilePhoto']??'',
      name: json['name']??'', 
      gender: json['gender']??'', 
      phoneNumber: json['phoneNumber']??'', 
      email: json['email']??'',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      locationUpdatedAt: json['locationUpdatedAt'] != null
          ? DateTime.parse(json['locationUpdatedAt'])
          : null,
      );
  }

   // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'profilePhoto': profilePhoto,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'locationUpdatedAt': locationUpdatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
  String? userId,
  String? profilePhoto,
  String? name,
  String? gender,
  String? phoneNumber,
  String? email,
  double? latitude,
  double? longitude,
  DateTime? locationUpdatedAt,
}) {
  return UserModel(
    userId: userId ?? this.userId,
    profilePhoto: profilePhoto ?? this.profilePhoto,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    locationUpdatedAt: locationUpdatedAt ?? this.locationUpdatedAt,    
  );
}
}



