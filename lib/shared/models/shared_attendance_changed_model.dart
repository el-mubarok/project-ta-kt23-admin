// To parse this JSON data, do
//
//     final sharedAttendanceChanged = sharedAttendanceChangedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedAttendanceChanged sharedAttendanceChangedFromJson(String str) =>
    SharedAttendanceChanged.fromJson(json.decode(str));

String sharedAttendanceChangedToJson(SharedAttendanceChanged data) =>
    json.encode(data.toJson());

class SharedAttendanceChanged {
  SharedAttendanceChanged({
    required this.qrCode,
    required this.presentOnTime,
    required this.presentLate,
    required this.created,
  });

  final String qrCode;
  final dynamic presentOnTime;
  final dynamic presentLate;
  final DateTime created;

  factory SharedAttendanceChanged.fromJson(Map<String, dynamic> json) =>
      SharedAttendanceChanged(
        qrCode: json["qr_code"],
        presentOnTime: json["present_on_time"],
        presentLate: json["present_late"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "present_on_time": presentOnTime,
        "present_late": presentLate,
        "created": created.toIso8601String(),
      };
}
