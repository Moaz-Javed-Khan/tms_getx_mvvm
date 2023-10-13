import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/GeneralReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/CreateUserInputModel.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/create_user_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CreateUserController extends GetxController
    with StateMixin<GeneralResponse> {
  late final CreateUserRepository repo;

  CreateUserController(this.repo);

  var connectionStatus = 0.obs;

  late StreamSubscription<InternetConnectionStatus> _listner;
  @override
  void onInit() {
    super.onInit();
    _listner = InternetConnectionChecker()
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

  createUser(CreateUserInput model) async {
    try {
      change(null, status: RxStatus.loading());
      await repo.createUser(input: model).then(
        (value) {
          List<CustomError> error = List<CustomError>.empty(growable: true);

          if (value["error"] != null) {
            List<Map<String, dynamic>>.from(value["error"]).forEach(
              (element) {
                error.add(
                  (CustomError.fromJson(json.decode(json.encode(element))
                      as Map<String, dynamic>)),
                );
              },
            );
          }
          var data = GeneralResponse<Message>(
            error.isNotEmpty ? error : null,
            (value["createUser"] != null)
                ? (Message.fromJson(
                    value["createUser"],
                  ))
                : null,
          );
          if (data.data != null) {
            change(data, status: RxStatus.success());
          } else {
            change(null, status: RxStatus.error("No data Found"));
          }
        },
      ).catchError(
        (error) {
          change(null, status: RxStatus.error(error.toString()));
        },
      );
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }
}
