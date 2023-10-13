import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/UserModel.dart';
import 'package:graphqlgetxexample/repository/get_user_byid_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GetUserByIdController extends GetxController
    with StateMixin<GeneralResponse> {
  late final GetUserByIdRepository repository;

  GetUserByIdController(this.repository);

  var user;

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

  getUserById(
      int userId, String token, Function(bool, String, User?) callback) async {
    try {
      change(null, status: RxStatus.loading());

      repository.getUserById(userId: userId, token: token).then((value) {
        List<CustomError> error = List<CustomError>.empty(growable: true);

        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        var data = GeneralResponse<User>(
          error.isNotEmpty ? error : null,
          (value["getUserById"] != null)
              ? (User.fromJson(value["getUserById"]))
              : null,
        );
        if (data.data != null) {
          callback(true, "", data.data!);
          print("User data: ${data.data}");
        } else {
          callback(false, data.error!.first.extensions.code.message, null!);
        }
      }).catchError((err) {
        callback(false, err.toString(), null!);
      });
    } catch (e) {
      callback(false, e.toString(), null!);
    }
  }
}
