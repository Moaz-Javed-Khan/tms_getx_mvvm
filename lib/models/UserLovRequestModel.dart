import 'dart:convert';

import 'package:graphqlgetxexample/models/NameModel.dart';

class UserLovRequest {
  UserLovRequest({
    required this.active,
    required this.pageStart,
    required this.roleId,
    required this.status,
    required this.fullName,
  });

  String? active;
  String? pageStart;
  String? roleId;
  String? status;
  Name? fullName;

  factory UserLovRequest.fromJson(Map<String, dynamic> json) => UserLovRequest(
        active: json["active"],
        pageStart: json["pageStart"],
        roleId: json["roleId"],
        status: json["status"],
        fullName: Name.fromJson(json["fullName"]),
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "pageStart": pageStart,
        "roleId": roleId,
        "status": status,
        "fullName": fullName?.toJson(),
      };

  UserLovRequest userLovRequestFromJson(String str) =>
      UserLovRequest.fromJson(json.decode(str));

  String userLovRequestToJson(UserLovRequest data) =>
      json.encode(data.toJson());
}
