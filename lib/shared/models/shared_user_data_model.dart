// To parse this JSON data, do
//
//     final sharedUserData = sharedUserDataFromJson(jsonString);

import 'dart:convert';

SharedUserData sharedUserDataFromJson(String str) =>
    SharedUserData.fromJson(json.decode(str));

String sharedUserDataToJson(SharedUserData data) => json.encode(data.toJson());

class SharedUserData {
  SharedUserData({
    required this.code,
    required this.data,
    required this.message,
  });

  final int code;
  final Data? data;
  final String message;

  factory SharedUserData.fromJson(Map<String, dynamic> json) => SharedUserData(
        code: int.parse(json["code"].toString()),
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        // ignore: prefer_null_aware_operators
        "data": data != null ? data?.toJson() : null,
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.role,
    required this.nip,
    required this.fullName,
    required this.department,
    required this.username,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String role;
  final String? nip;
  final String fullName;
  final int department;
  final String username;
  final dynamic avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: int.parse(json["id"].toString()),
        role: json["role"],
        nip: json["nip"],
        fullName: json["full_name"],
        department: int.parse(json["department"].toString()),
        username: json["username"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "nip": nip,
        "full_name": fullName,
        "department": department,
        "username": username,
        "avatar": avatar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
