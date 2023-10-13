import 'dart:convert';

import 'package:graphqlgetxexample/models/NameModel.dart';

class GetAllUsersRequest {
  GetAllUsersRequest({
    required this.status,
    required this.roleId,
    required this.pageStart,
    required this.active,
    required this.fullName,
  });

  int? pageStart;
  String? status;
  int? roleId;
  bool? active;
  Name? fullName;

  factory GetAllUsersRequest.fromJson(Map<String, dynamic> json) =>
      GetAllUsersRequest(
        pageStart: json["pageStart"],
        status: json["status"],
        roleId: json["roleId"],
        active: json["active"],
        fullName: Name.fromJson(json["fullName"]),
      );

  Map<String, dynamic> toJson() => {
        "pageStart": pageStart,
        "status": status,
        "roleId": roleId,
        "active": active,
        "fullName": fullName!.toJson(),
      };

  GetAllUsersRequest getAllUsersRequestFromJson(String str) =>
      GetAllUsersRequest.fromJson(json.decode(str));

  String getAllUsersRequestToJson(GetAllUsersRequest data) =>
      json.encode(data.toJson());
}
