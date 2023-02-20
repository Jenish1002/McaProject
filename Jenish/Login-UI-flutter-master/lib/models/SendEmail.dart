// To parse this JSON data, do
//
//     final sendEmail = sendEmailFromJson(jsonString);

import 'dart:convert';

SendEmail sendEmailFromJson(String str) => SendEmail.fromJson(json.decode(str));

String sendEmailToJson(SendEmail data) => json.encode(data.toJson());

class SendEmail {
  SendEmail({
    required this.email,
  });

  String email;

  factory SendEmail.fromJson(Map<String, dynamic> json) => SendEmail(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
