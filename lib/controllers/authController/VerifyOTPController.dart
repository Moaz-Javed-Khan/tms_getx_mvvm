import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/verify_otp_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class VerifyOTPController extends GetxController
    with StateMixin<GeneralResponse> {
  late final VerifyOTPRepository repository;

  VerifyOTPController(this.repository);

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

  verifyOTP(
    String otp,
    String email,
    String? password,
  ) async {
    try {
      change(null, status: RxStatus.loading());
      repository
          .verifyOTP(
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
          (value["verifyOTP"] != null)
              ? (Message.fromJson(
                  value["verifyOTP"],
                ))
              : null,
        );
        if (data.data != null) {
          change(data, status: RxStatus.success());
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
