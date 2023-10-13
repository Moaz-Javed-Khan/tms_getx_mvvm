import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/models/RoleModel.dart';

// AdminSignInReponse signInResponseFromJson(String str) =>
//     AdminSignInReponse.fromJson(json.decode(str));

// String signInResponseToJson(AdminSignInReponse data) =>
//     json.encode(data.toJson());

// class AdminSignInReponse {
//   Data data;

//   AdminSignInReponse({
//     required this.data,
//   });

//   factory AdminSignInReponse.fromJson(Map<String, dynamic> json) =>
//       AdminSignInReponse(
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//       };
// }

class Data {
  LoginResponse loginAdmin;

  Data({
    required this.loginAdmin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loginAdmin: LoginResponse.fromJson(json["loginAdmin"]),
      );

  Map<String, dynamic> toJson() => {
        "loginAdmin": loginAdmin.toJson(),
      };
}

class LoginResponse {
  int id;
  String token;
  Name fullName;
  String email;
  Role role;
  String profilePic;

  LoginResponse({
    required this.id,
    required this.token,
    required this.fullName,
    required this.email,
    required this.role,
    required this.profilePic,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        token: json["token"],
        fullName: Name.fromJson(json["fullName"]),
        email: json["email"],
        role: Role.fromJson(json["role"]),
        profilePic: json["profilePic"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "fullName": fullName.toJson(),
        "email": email,
        "role": role.toJson(),
        "profilePic": profilePic,
      };
}
