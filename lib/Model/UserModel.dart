// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.profileimage,
    this.email,
    this.isActive,
    this.isVerifide,
    this.address,
  });

  int id;
  String name;
  String phone;
  String password;
  String profileimage;
  String email;
  int isActive;
  int isVerifide;
  String address;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    password: json["password"],
    profileimage: json["profileimage"],
    email: json["email"],
    isActive: json["is_active"],
    isVerifide: json["is_Verifide"],
    address: json["address"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "password": password,
    "profileimage": profileimage,
    "email": email,
    "is_active": isActive,
    "is_Verifide": isVerifide,
    "address": address,

  };
}

