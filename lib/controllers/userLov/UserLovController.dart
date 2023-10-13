import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/UserLovResponseModel.dart';
import 'package:graphqlgetxexample/repository/users_lov_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UserLovController extends GetxController
    with StateMixin<GeneralResponse> {
  late final UserLovRepository repository;

  UserLovController(this.repository);

  var connectionStatus = 0.obs;
  late StreamSubscription<InternetConnectionStatus> _listener;
  RxList<UserLovResponse> listOfUsers = RxList();
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

  // List<Map<String, dynamic>> fakeApiResponse = [
  //   {
  //     "id": 1,
  //     "fullName": "John Doe",
  //     "email": "a@a.com",
  //     "profilePic": "abc",
  //   },
  //   {
  //     "id": 2,
  //     "fullName": "Jane Smith",
  //     "email": "b@b.com",
  //     "profilePic": "xyz",
  //   },
  // ];

  userLov(String token) async {
    try {
      change(null, status: RxStatus.loading());
      repository.userLov(token: token).then((value) {
        List<UserLovResponse> userlist =
            List<UserLovResponse>.empty(growable: true);
        List<CustomError> error = List<CustomError>.empty(growable: true);
        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        //
        // if (value["getAllUserslov"] != null) {
        //   List<Map<String, dynamic>> userListJson =
        //       List<Map<String, dynamic>>.from(value["getAllUserslov"]);
        //   List<UserLovResponse> userlist = userListJson
        //       .map((json) => UserLovResponse.fromJson(json))
        //       .toList();
        // }

        // var valueOfAPI = value!["getAllUserslov"];
        // print(valueOfAPI);

        if (value["getAllUserslov"] != null) {
          // fakeApiResponse.forEach((element) {
          //   userlist.add(UserLovResponse.fromJson(element));
          // });
          //
          List<Map<String, dynamic>>.from(value["getAllUserslov"])
              .forEach((element) {
            userlist.add((UserLovResponse.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });

          //   List<dynamic> jsonResponse = json.decode(value["getAllUserslov"]);
          //   List<UserLovResponse> userList =
          //       UserLovResponse.listFromJson(jsonResponse);
          //   print("parsed list in to model $userList");
          //   for (UserLovResponse user in userList) {
          //     print("ID: ${user.id}");
          //     print("Full Name: ${user.fullName.en} ${user.fullName.ar}");
          //     print("Email: ${user.email}");
          //     print("Profile Pic: ${user.profilePic}");
          //     print("");
          //   }

        }

        var data = GeneralResponse<List<UserLovResponse>>(
          error.isNotEmpty ? error : null,
          value["getAllUserslov"] != null ? userlist : null,
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
