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
  });

  final String qrCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrCode: json["qr_code"],
      );

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
      };
}
