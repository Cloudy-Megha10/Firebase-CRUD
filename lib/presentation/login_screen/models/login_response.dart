// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String message;
  Data? data; // 'data' can now be null

  LoginResponse({
    required this.message,
    this.data, // Nullable 'data'
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null, // Handle null case
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(), // Only convert if 'data' is not null
      };
}

class Data {
  int userId;
  String username;
  String email;
  String memberNumber;
  String role;
  int clubId;

  Data({
    required this.userId,
    required this.username,
    required this.email,
    required this.memberNumber,
    required this.role,
    required this.clubId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        memberNumber: json["member_number"],
        role: json["role"],
        clubId: json["club_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "member_number": memberNumber,
        "role": role,
        "club_id": clubId,
      };
}
