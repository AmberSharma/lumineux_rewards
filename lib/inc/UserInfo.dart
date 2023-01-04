import 'dart:convert';

import 'package:lumineux_rewards_app/BaseConstants.dart';
import 'package:http/http.dart' as http;

class UserInfo {
  final String uuid;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String address;
  final String mobile;
  final String points;
  final String type;
  final String img;

  const UserInfo({
    this.uuid = "",
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    this.email = "",
    this.address = "",
    this.mobile = "",
    this.points = "",
    this.type = "",
    this.img = "",
  });

  UserInfo copy({
    String uuid = "",
    String firstName = "",
    String lastName = "",
    String username = "",
    String email = "",
    String address = "",
    String mobile = "",
    String points = "",
    String type = "",
    String img = ""
  }) => UserInfo(
    uuid: uuid ?? this.uuid,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    username: username ?? this.username,
    email: email ?? this.email,
    address: address ?? this.address,
    mobile: mobile ?? this.mobile,
    points: points ?? this.points,
    type: type ?? this.type,
    img: img ?? this.img,
  );

  static UserInfo fromJson(Map<String, dynamic> json) => UserInfo(
    uuid: json["uuid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    username: json["username"],
    email: json["email"],
    address: json["address"],
    mobile: json["mobile"],
    points: json["points"],
    type: json["type"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "firstName": firstName,
    "lastName": lastName,
    "username": username,
    "email": email,
    "address": address,
    "mobile": mobile,
    "points": points,
    "type": type,
    "img": img
  };
}
