import 'package:graphqlgetxexample/models/NameModel.dart';

class Role {
  Name name;
  bool? active;
  int id;

  Role({
    required this.name,
    this.active,
    required this.id,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: Name.fromJson(json['name']),
        active: json["active"] ?? false,
        // active: json["active"] as bool?,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "active": active,
        "id": id,
      };
}
