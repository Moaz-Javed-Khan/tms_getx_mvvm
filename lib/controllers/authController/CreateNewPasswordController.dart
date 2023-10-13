import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/create_new_password_repository%20.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CreateNewPasswordController extends GetxController
    with StateMixin<GeneralResponse> {
  late final CreateNewPasswordRepository repository;

  CreateNewPasswordController(this.repository);

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

  createNewPassword(
    String otp,
    String email,
    String password,
  ) async {
    try {
      change(null, status: RxStatus.loading());
      repository
          .createNewPassword(
        email: email,
        otp: otp,
        password: password,
      )
          .then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<Message>(
          error.isNotEmpty ? error : null,
          (value["resetPasswordDetail"] != null)
              ? (Message.fromJson(
                  value["resetPasswordDetail"],
                ))
              : null,
        );
        // if (data.data != null) {
        change(data, status: RxStatus.success());
        // } else {
        //   change(null, status: RxStatus.error("No data Found"));
        // }
      }).catchError((err) {
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
