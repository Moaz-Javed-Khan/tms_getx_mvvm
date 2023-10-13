import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:graphqlgetxexample/GeneralReponse/CustomError.dart';
import 'package:graphqlgetxexample/generalReponse/GeneralResponse.dart';
import 'package:graphqlgetxexample/models/RoleLovResponseModel.dart';
import 'package:graphqlgetxexample/repository/roles_lov_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RoleLovController extends GetxController
    with StateMixin<GeneralResponse> {
  late final RoleLovRepository repository;

  RoleLovController(this.repository);

  bool isLoading = false;

  var connectionStatus = 0.obs;

  late StreamSubscription<InternetConnectionStatus> _listener;
  RxList<RoleLovResponse> listOfRoles = RxList();
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

  roleLov(String token) async {
    try {
      isLoading = true;
      change(null, status: RxStatus.loading());
      repository.roleLov(token: token).then((value) {
        List<RoleLovResponse> rolelist =
            List<RoleLovResponse>.empty(growable: true);
        List<CustomError> error = List<CustomError>.empty(growable: true);
        if (value["error"] != null) {
          List<Map<String, dynamic>>.from(value["error"]).forEach((element) {
            error.add((CustomError.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });
        }

        //
        // if (value["getAllRoleslov"] != null) {
        //   List<Map<String, dynamic>> userListJson =
        //       List<Map<String, dynamic>>.from(value["getAllRoleslov"]);
        //   List<RoleLovResponse> userlist = userListJson
        //       .map((json) => RoleLovResponse.fromJson(json))
        //       .toList();
        // }
        // var valueOfAPI = value!["getAllRoleslov"];
        // print(valueOfAPI);

        if (value["getAllRoleslov"] != null) {
          // fakeApiResponse.forEach((element) {
          //   userlist.add(RoleLovResponse.fromJson(element));
          // });
          //
          List<Map<String, dynamic>>.from(value["getAllRoleslov"])
              .forEach((element) {
            rolelist.add((RoleLovResponse.fromJson(
                json.decode(json.encode(element)) as Map<String, dynamic>)));
          });

          //   List<dynamic> jsonResponse = json.decode(value["getAllRoleslov"]);
          //   List<RoleLovResponse> userList =
          //       RoleLovResponse.listFromJson(jsonResponse);
          //   print("parsed list in to model $userList");
          //   for (RoleLovResponse user in userList) {
          //     print("ID: ${user.id}");
          //     print("Full Name: ${user.fullName.en} ${user.fullName.ar}");
          //     print("Email: ${user.email}");
          //     print("Profile Pic: ${user.profilePic}");
          //     print("");
          //   }

        }

        var data = GeneralResponse<List<RoleLovResponse>>(
          error.isNotEmpty ? error : null,
          value["getAllRoleslov"] != null ? rolelist : null,
        );

        if (data.data != null) {
          listOfRoles.value = data.data!;
          isLoading = false;
          change(data, status: RxStatus.success());
          print("Data.data: ${data.data}");
          print("listOfRoles: $listOfRoles");
          print("listOfRoles.value: ${listOfRoles.value}");
        } else {
          listOfRoles.value = [];
          change(null, status: RxStatus.error("No data Found"));
        }
      }).catchError((err) {
        isLoading = false;

        listOfRoles.value = [];
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (e) {
      isLoading = false;

      listOfRoles.value = [];
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
