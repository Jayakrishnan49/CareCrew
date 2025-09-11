class UserModel {
  final String userId;
  final String profilePhoto;
  final String name;
  final String gender;
  final String phoneNumber;
  final String email;

  UserModel({
    required this.userId,
    required this.profilePhoto,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.email
  });

  //convert from json
  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
      userId: json['userId']??'',
      profilePhoto: json['profilePhoto'],
      name: json['name']??'', 
      gender: json['gender']??'', 
      phoneNumber: json['phoneNumber']??'', 
      email: json['email']??'',
      );
  }

   // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'profileImage': profilePhoto,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  UserModel copyWith({
  String? userId,
  String? profilePhoto,
  String? name,
  String? gender,
  String? phoneNumber,
  String? email,
}) {
  return UserModel(
    userId: userId ?? this.userId,
    profilePhoto: profilePhoto ?? this.profilePhoto,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,    
  );
}
}



