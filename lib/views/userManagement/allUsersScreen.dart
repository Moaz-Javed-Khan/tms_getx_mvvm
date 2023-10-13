import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/getAllUsers/getAllUsersController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/GetAllUsersRequestModel.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/repository/get_all_user_repository.dart';

class AllUsersScreen extends StatefulWidget {
  AllUsersScreen({super.key});

  final controller = Get.put(
    GetAllUsersController(
      GetAllUsersRepository(),
    ),
  );

  var storage = GetStorage();

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  late LoginResponse response;

  @override
  void initState() {
    widget.controller.change(null, status: RxStatus.empty());

    response = LoginResponse.fromJson(
        jsonDecode(widget.storage.read(USER_LOGIN_DATA)));

    loadUsers();

    // getUserDetailById(selectedUserID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userList = widget.controller.listOfUsers;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        // title: const Text("All Users"),
        // centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_rounded),
        //   onPressed: () {
        //     context.push(HOME);
        //   },
        // ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Text("All Users"),
        ),
        // ListView.builder(
        //   itemCount: userList.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       title: Text(userList[index].user!.fullName!.en.toString()),
        //       subtitle: Text(userList[index].user!.address!.en.toString()),
        //     );
        //   },
        // ),
      ),
    );
  }

  loadUsers() async {
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () {
    await widget.controller.getAllUsers(
      response.token,
      GetAllUsersRequest(
        active: true,
        fullName: response.fullName,
        // Name(
        //   ar: "",
        //   en: "",
        // ),
        pageStart: 10,
        roleId: response.role.id,
        status: "",
      ),
    );
    print(
      "Api response in load function listOfUsers: ${widget.controller.listOfUsers}",
    );
    //   },
    // );
  }
}
