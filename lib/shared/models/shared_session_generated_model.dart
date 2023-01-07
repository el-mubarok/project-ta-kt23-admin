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
  final Data data;
  final String message;

  factory SharedSessionGenerated.fromJson(Map<String, dynamic> json) =>
      SharedSessionGenerated(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.qrCode,
    required this.start,
    required this.end,
  });

  final String qrCode;
  final DateTime start;
  final DateTime end;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrCode: json["qr_code"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
      };
}
