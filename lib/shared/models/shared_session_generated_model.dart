// To parse this JSON data, do
//
//     final sharedSessionGenerated = sharedSessionGeneratedFromJson(jsonString);
import 'dart:convert';

SharedSessionGenerated sharedSessionGeneratedFromJson(String str) =>
    SharedSessionGenerated.fromJson(json.decode(str));

String sharedSessionGeneratedToJson(SharedSessionGenerated data) =>
    json.encode(data.toJson());

class SharedSessionGenerated {
  SharedSessionGenerated({
    required this.code,
    required this.data,
    required this.message,
  });

  final int code;
  final Data? data;
  final String message;

  factory SharedSessionGenerated.fromJson(Map<String, dynamic> json) =>
      SharedSessionGenerated(
        code: json["code"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data != null ? data?.toJson() : null,
        "message": message,
      };
}

class Data {
  Data({
    required this.qrCode,
    required this.start,
    required this.end,
    required this.endSession,
  });

  final String qrCode;
  final DateTime? start;
  final DateTime? end;
  final DateTime? endSession;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      qrCode: json["qr_code"],
      start: json["start"] != null ? DateTime.parse(json["start"]) : null,
      end: json["end"] != null ? DateTime.parse(json["end"]) : null,
      endSession: json["end_session"] != null
          ? DateTime.parse(json["end_session"])
          : null);

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "start": start != null ? start?.toIso8601String() : null,
        "end": end != null ? end?.toIso8601String() : null,
        "end_session":
            endSession != null ? endSession?.toIso8601String() : null,
      };
}
