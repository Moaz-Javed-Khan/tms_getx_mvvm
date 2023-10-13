import 'dart:convert';

class UserLoginRequest {
  UserLoginRequest({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.loginIp,
  });

  String? deviceId;
  String? email;
  String? password;
  String? loginIp;

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) =>
      UserLoginRequest(
        deviceId: json["deviceId"],
        email: json["email"],
        password: json["password"],
        loginIp: json["loginIp"],
      );

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "email": email,
        "password": password,
        "loginIp": loginIp,
      };

  UserLoginRequest loginUserRequestFromJson(String str) =>
      UserLoginRequest.fromJson(json.decode(str));

  String userLoginToJson(UserLoginRequest data) => json.encode(data.toJson());
}
