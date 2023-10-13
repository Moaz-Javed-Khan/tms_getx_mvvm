import 'dart:convert';

import 'package:graphqlgetxexample/models/UserModel.dart';

class GetAllUsersResponse {
  GetAllUsersResponse({
    required this.pageStart,
    required this.limit,
    required this.totalCount,
    required this.user,
  });

  String? pageStart;
  String? limit;
  String? totalCount;
  User? user;

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) =>
      GetAllUsersResponse(
        pageStart: json["pageStart"],
        limit: json["limit"],
        totalCount: json["totalCount"],
        user: User.fromJson(json["totalCount"]),
      );

  Map<String, dynamic> toJson() => {
        "pageStart": pageStart,
        "limit": limit,
        "totalCount": totalCount,
        "user": user?.toJson(),
      };

  GetAllUsersResponse getAllUsersResponseFromJson(String str) =>
      GetAllUsersResponse.fromJson(json.decode(str));

  String getAllUsersResponseToJson(GetAllUsersResponse data) =>
      json.encode(data.toJson());
}
