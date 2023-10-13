import 'dart:convert';

import 'NameModel.dart';

class UpdateRoleModelRequest {
  UpdateRoleModelRequest({
    required this.active,
    required this.name,
    required this.id,
  });

  Name? name;
  bool? active;
  int id;

  factory UpdateRoleModelRequest.fromJson(Map<String, dynamic> json) =>
      UpdateRoleModelRequest(
        name: Name.fromJson(json["name"]),
        active: json["active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "active": active,
        "id": id,
      };

  UpdateRoleModelRequest updateRoleModelRequestFromJson(String str) =>
      UpdateRoleModelRequest.fromJson(json.decode(str));

  String updateRoleModelRequestToJson(UpdateRoleModelRequest data) =>
      json.encode(data.toJson());
}
