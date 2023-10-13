import 'dart:convert';

import 'AddressModel.dart';
import 'NameModel.dart';

class UpdateProfileDetailInput {
  UpdateProfileDetailInput({
    required this.gender,
    required this.phoneNumber,
    required this.fullName,
    required this.profilePic,
    required this.address,
  });

  String gender;
  String? phoneNumber;
  String? profilePic;
  Name? fullName;
  Address? address;

  factory UpdateProfileDetailInput.fromJson(Map<String, dynamic> json) =>
      UpdateProfileDetailInput(
        profilePic: (json["profilePic"] != null) ? json["profilePic"] : null,
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        fullName: Name.fromJson(json["fullName"]),
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "fullName": fullName?.toJson(),
        "address": address?.toJson(),
      };

  UpdateProfileDetailInput updateProfileInputFromJson(String str) =>
      UpdateProfileDetailInput.fromJson(json.decode(str));

  String updateProfileInputToJson(UpdateProfileDetailInput data) =>
      json.encode(data.toJson());
}
