import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/delete_role_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DeleteRoleController extends GetxController
    with StateMixin<GeneralResponse> {
  late final DeleteRoleRepository repository;

  DeleteRoleController(this.repository);

  var connectionStatus = 0.obs;
  bool listloader = false;
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

  deleteRole(String token, int roleId, Function(bool) callback) async {
    try {
      change(null, status: RxStatus.loading());
      repository.deleteRole(token: token, roleId: roleId).then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<Message>(
          error.isNotEmpty ? error : null,
          (value["deleteRole"] != null)
              ? (Message.fromJson(
                  value["deleteRole"],
                ))
              : null,
        );
        if (data.data != null) {
          callback(true);
          change(data, status: RxStatus.success());
        } else {
          callback(false);
          change(null, status: RxStatus.error("No data Found"));
        }
      }).catchError((err) {
        callback(false);
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      callback(false);
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
