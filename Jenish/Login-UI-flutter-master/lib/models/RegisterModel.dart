// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.phone,
    required this.username,
    required this.password,
  });

  String name;
  String email;
  String gender;
  String phone;
  String username;
  String password;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "phone": phone,
        "username": username,
        "password": password,
      };
}
