import 'dart:convert';

import 'NameModel.dart';

class AddRoleModelRequest {
  AddRoleModelRequest({
    required this.active,
    required this.name,
  });

  Name? name;
  bool? active;

  factory AddRoleModelRequest.fromJson(Map<String, dynamic> json) =>
      AddRoleModelRequest(
        name: Name.fromJson(json["name"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "active": active,
      };

  AddRoleModelRequest addRoleModelRequestFromJson(String str) =>
      AddRoleModelRequest.fromJson(json.decode(str));

  String addRoleModelRequestToJson(AddRoleModelRequest data) =>
      json.encode(data.toJson());
}
