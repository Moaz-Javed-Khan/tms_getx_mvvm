import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/GetAllUsersRequestModel.dart';
import 'package:graphqlgetxexample/models/GetAllUsersResponseModel.dart';
import 'package:graphqlgetxexample/repository/get_all_user_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GetAllUsersController extends GetxController
    with StateMixin<GeneralResponse> {
  late final GetAllUsersRepository repository;

  GetAllUsersController(this.repository);

  var connectionStatus = 0.obs;
  late StreamSubscription<InternetConnectionStatus> _listener;

  RxList<GetAllUsersResponse> listOfUsers = RxList();

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

  getAllUsers(String token, GetAllUsersRequest input) async {
    try {
      change(null, status: RxStatus.loading());
      repository.getAllUsers(token: token, input: input).then((value) {
        List<GetAllUsersResponse> userlist =
            List<GetAllUsersResponse>.empty(growable: true);
        List<CustomError> error = List<CustomError>.empty(growable: true);
        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        //
        // if (value["getAllUser"] != null) {
        //   List<Map<String, dynamic>> userListJson =
        //       List<Map<String, dynamic>>.from(value["getAllUser"]);
        //   List<getAllUsersResponse> userlist = userListJson
        //       .map((json) => getAllUsersResponse.fromJson(json))
        //       .toList();
        // }

        if (value["getAllUser"] != null) {
          // fakeApiResponse.forEach((element) {
          //   userlist.add(getAllUsersResponse.fromJson(element));
          // });
          //
          List<Map<String, dynamic>>.from(value["getAllUser"])
              .forEach((element) {
            userlist.add((GetAllUsersResponse.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });

          //   List<dynamic> jsonResponse = json.decode(value["getAllUser"]);
          //   List<getAllUsersResponse> userList =
          //       getAllUsersResponse.listFromJson(jsonResponse);
          //   print("parsed list in to model $userList");
          //   for (getAllUsersResponse user in userList) {
          //     print("ID: ${user.id}");
          //     print("Full Name: ${user.fullName.en} ${user.fullName.ar}");
          //     print("Email: ${user.email}");
          //     print("Profile Pic: ${user.profilePic}");
          //     print("");
          //   }

        }

        var data = GeneralResponse<List<GetAllUsersResponse>>(
          error.isNotEmpty ? error : null,
          value["getAllUser"] != null ? userlist : null,
        );

        if (data.data != null) {
          listOfUsers.value = data.data!;
          change(data, status: RxStatus.success());
          print("Data.data: ${data.data}");
          print("listOfUsers: $listOfUsers");
          print("listOfUsers.value: ${listOfUsers.value}");
        } else {
          listOfUsers.value = [];
          change(null, status: RxStatus.error("No data Found"));
        }
      }).catchError((err) {
        listOfUsers.value = [];
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      listOfUsers.value = [];
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
