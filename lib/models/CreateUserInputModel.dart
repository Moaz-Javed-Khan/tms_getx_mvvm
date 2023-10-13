import 'dart:convert';

import 'package:graphqlgetxexample/models/AddressModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';

class CreateUserInput {
  CreateUserInput({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.phoneNumber,
    required this.fullName,
    required this.address,
  });

  String? deviceId;
  String? email;

  String? password;
  String? phoneNumber;
  Name? fullName;
  Address? address;

  factory CreateUserInput.fromJson(Map<String, dynamic> json) =>
      CreateUserInput(
        deviceId: json["deviceId"],
        email: json["email"],
        password: json["password"],
        fullName: Name.fromJson(json["fullName"]),
        address: Address.fromJson(json["address"]),
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "email": email,
        "password": password,
        "fullName": fullName?.toJson(),
        "address": address?.toJson(),
        "phoneNumber": phoneNumber,
      };

  CreateUserInput createUserInputFromJson(String str) =>
      CreateUserInput.fromJson(json.decode(str));

  String userLoginToJson(CreateUserInput data) => json.encode(data.toJson());
}
