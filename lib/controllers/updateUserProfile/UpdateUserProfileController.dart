import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/update_user_profile_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../models/UpdateUser.dart';

class UpdateUserProfileController extends GetxController
    with StateMixin<GeneralResponse> {
  late final UpdateUserProfileRepository repository;

  UpdateUserProfileController(this.repository);

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

  updateUserProfile(UpdateProfileDetailInput input, String token) async {
    try {
      change(null, status: RxStatus.loading());

      repository.updateUserProfile(input: input, token: token).then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<Message>(
          error.isNotEmpty ? error : null,
          (value["updateProfileDetail"] != null)
              ? (Message.fromJson(
                  value["updateProfileDetail"],
                ))
              : null,
        );
        if (data.data != null) {
          change(data, status: RxStatus.success());

          print("data.data: ${data.data}");
          print("data: $data");
        } else {
          change(null,
              status: RxStatus.error(error.first.extensions.code.message));
        }
      }).catchError((err) {
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
