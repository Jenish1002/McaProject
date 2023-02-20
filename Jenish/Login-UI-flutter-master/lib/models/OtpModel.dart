// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    required this.userId,
    required this.uOtp,
  });

  String userId;
  int uOtp;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    userId: json["user_id"],
    uOtp: json["u_otp"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "u_otp": uOtp,
  };
}
