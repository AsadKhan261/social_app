// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) =>
    json.encode(data.toJson(data.userId!));

class UserModel {
  String? name;
  String? email;
  String? userId;

  UserModel({
    this.name,
    this.email,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        userId: json["userID"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "name": name,
        "email": email,
        "userID": docID,
      };
}
