// To parse this JSON data, do
//
//     final sharedSessionHistory = sharedSessionHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedSessionHistory sharedSessionHistoryFromJson(String str) =>
    SharedSessionHistory.fromJson(json.decode(str));

String sharedSessionHistoryToJson(SharedSessionHistory data) =>
    json.encode(data.toJson());

class SharedSessionHistory {
  SharedSessionHistory({
    required this.code,
    required this.data,
    required this.message,
  });

  final int code;
  final List<Datum> data;
  final String message;

  factory SharedSessionHistory.fromJson(Map<String, dynamic> json) =>
      SharedSessionHistory(
        code: int.parse(json["code"].toString()),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.adminId,
    required this.sessionDate,
    required this.sessionDateEnd,
    required this.presentOnTime,
    required this.presentLate,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int adminId;
  final DateTime sessionDate;
  final DateTime sessionDateEnd;
  final int presentOnTime;
  final int presentLate;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: int.parse(json["id"].toString()),
        adminId: int.parse(json["admin_id"].toString()),
        sessionDate: DateTime.parse(json["session_date"]),
        sessionDateEnd: DateTime.parse(json["session_date_end"]),
        presentOnTime: int.parse(json["present_on_time"].toString()),
        presentLate: int.parse(json["present_late"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "session_date": sessionDate.toIso8601String(),
        "session_date_end": sessionDateEnd.toIso8601String(),
        "present_on_time": presentOnTime,
        "present_late": presentLate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
