import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/LoginRequestModel.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/repository/login_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class LoginUserController extends GetxController
    with StateMixin<GeneralResponse> {
  late final LoginUserRepository repository;
  var storage = GetStorage();

  LoginUserController(this.repository);

  var token = "";
  var connectionStatus = 0.obs;
  var ipAddress = "";
  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    super.onInit();

    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;
          break;
      }
    });
  }

  Future<String?> getToken() async =>
      await FirebaseMessaging.instance.getToken().then((value) {
        token = value ?? "";
        print("DEVICE_TOKEN ${token}");
      });

  loginUser(UserLoginRequest model) async {
    try {
      change(null, status: RxStatus.loading());
      await fetchPublicIP();
      model.loginIp = ipAddress;
      await getToken();
      model.deviceId = token;
      repository.userLogin(input: model).then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<LoginResponse>(
          error.isNotEmpty ? error : null,
          (value["loginUser"] != null)
              ? (LoginResponse.fromJson(value["loginUser"]))
              : null,
        );
        if (data.data != null) {
          change(data, status: RxStatus.success());
          storage.write(USER_LOGIN_DATA, jsonEncode(data.data!.toJson()));
        } else {
          change(null, status: RxStatus.error("No data Found"));
        }
      }).catchError((err) {
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<String> fetchPublicIP() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));

    if (response.statusCode == 200) {
      final address = jsonDecode(response.body)['ip'];
      ipAddress = address;
      return ipAddress;
    } else {
      throw Exception('Failed to fetch public IP');
    }
  }
}
