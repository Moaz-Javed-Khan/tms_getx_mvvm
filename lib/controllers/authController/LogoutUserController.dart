import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/logout_repository%20.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:graphqlgetxexample/extentions/constants.dart';

class LogoutUserController extends GetxController
    with StateMixin<GeneralResponse> {
  late final LogoutUserRepository repository;

  LogoutUserController(this.repository);

  var storage = GetStorage();

  var connectionStatus = 0.obs;
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

  logoutUser(String deviceId, String token) async {
    try {
      change(null, status: RxStatus.loading());
      repository.logoutUser(deviceId: deviceId, token: token).then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<Message>(
          error.isNotEmpty ? error : null,
          (value["logout"] != null)
              ? (Message.fromJson(
                  value["logout"],
                ))
              : null,
        );
        if (data.data != null) {
          print("Logged Out");
          change(data, status: RxStatus.success());
          // storage.remove(USER_LOGIN_DATA);
          // storage.erase();
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
}
