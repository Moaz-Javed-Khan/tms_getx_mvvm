import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/getUserById/GetUserByIdController.dart';
import 'package:graphqlgetxexample/controllers/userLov/UserLovController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/models/UserLovResponseModel.dart';
import 'package:graphqlgetxexample/repository/get_user_byid_repository.dart';
import 'package:graphqlgetxexample/repository/users_lov_repository.dart';
import 'package:graphqlgetxexample/widgets/userDetailCard.dart';

class UsersLovScreen extends StatefulWidget {
  UsersLovScreen({super.key});

  final userLovController = Get.put(
    UserLovController(
      UserLovRepository(),
    ),
  );
  final getUserByIdController = Get.put(
    GetUserByIdController(
      GetUserByIdRepository(),
    ),
  );

  var storage = GetStorage();

  @override
  State<UsersLovScreen> createState() => _UsersLovScreenState();
}

class _UsersLovScreenState extends State<UsersLovScreen> {
  late LoginResponse response;
  int selectedUserID = 0;
  String name = "";
  String? profilePic;
  String email = "";
  String address = "";
  String status = "";

  @override
  void initState() {
    widget.userLovController.change(null, status: RxStatus.empty());

    response = LoginResponse.fromJson(
        jsonDecode(widget.storage.read(USER_LOGIN_DATA)));

    loadUserList();

    // getUserDetailById(selectedUserID);

    super.initState();
  }

  // String dropdownValue = 'User 1';

  @override
  Widget build(BuildContext context) {
    // String jsonList = '[{"fullName": "John Doe"}, {"fullName": "Jane Smith"}]';
    // List<dynamic> dataList = json.decode(jsonList);
    // var fullData = widget.userLovController.state!.data;
    // UserLovResponse userLov =
    //     fullData.map((e) => UserLovResponse.fromJson(e)).toList();
    // print("Api response on screen: ${widget.userLovController.listOfUsers.value}");
    // if (widget.userLovController.listOfUsers.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(),
    //     body: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // } else {

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        // title: const Text("Users"),
        // centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_rounded),
        //   onPressed: () {
        //     context.push(HOME);
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Obx(
              () =>
                  // DropdownButtonFormField<String>(
                  //   items: widget.userLovController.listOfUsers.map((item) {
                  //     return DropdownMenuItem<String>(
                  //       value: item.fullName.toString(),
                  //       child: Text(item.fullName.toString()),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     // Yahaan pe aap selected value ke kar sakte hain.
                  //   },
                  // ),

                  DropdownButtonFormField(
                menuMaxHeight: 200.0,
                // isExpanded: true,
                // itemHeight: 100.0,
                onChanged: (value) {
                  var data = widget.userLovController.listOfUsers.value
                      .firstWhere((element) =>
                          "${element.fullName.en}${element.id}" ==
                          value.toString());
                  selectedUserID = data.id;
                  print(selectedUserID);

                  getUserDetailById(selectedUserID);
                  setState(() {});

                  // final userId = getUserIdByName(value!);
                  // if (userId != null) {
                  //   print('Selected User ID: $userId');
                  // } else {
                  //   print('User not found');
                  // }
                },
                decoration: const InputDecoration(hintText: "Select User"),
                items: widget.userLovController.listOfUsers.value
                    .map((e) => "${e.fullName.en}" "${e.id}")
                    .map((String name) {
                  return DropdownMenuItem(
                    value: name.toString(),
                    child: Text(
                      removeDigit(name.toString()),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            (selectedUserID == 0)
                ? const Text(
                    "No user Selected",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : Card(
                    color: Colors.tealAccent[100],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(60),
                            ),
                            child: Image.network(
                              IMG_END_POINT + profilePic.toString(),
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.account_circle_outlined,
                                size: 90,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(email),
                              Text(address),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            status,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
            // UserDetailCard(
            //   user: ,
            // ),
            // Text("Name: $name"),
            // Text("Email: $email"),
            // Text("Address: $address"),
            // Text("DP: $IMG_END_POINT$profilePic"),
            // Text("Status: $status"),
            // Text("DP: $profilePic"),

            ElevatedButton(
              onPressed: () {
                setState(() {});
                print("Refresh Clicked");
              },
              child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
    // }
  }

  removeDigit(final String s) {
    return s.replaceAll(RegExp(r"[0-9]+"), "");
  }

  String getUserIdByName(String fullName) {
    final user = widget.userLovController.listOfUsers.value.firstWhere(
      (user) => user.fullName.en.toString() == fullName,
      orElse: () => UserLovResponse(
        id: 0,
        fullName: fullName as Name,
        email: "",
        profilePic: "",
      ),
    );

    // ignore: unnecessary_null_comparison
    if (user != null) {
      return user.id.toString();
    } else {
      return "";
    }
  }

  loadUserList() async {
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () {
    await widget.userLovController.userLov(response.token);
    print(
      "Api response in load function listOfUsers: ${widget.userLovController.listOfUsers}",
    );
    //   },
    // );
  }

  getUserDetailById(int userId) async {
    // Future.delayed(const Duration(seconds: 3), () {
    await widget.getUserByIdController.getUserById(
      userId,
      response.token,
      (success, message, user) {
        if (success) {
          setState(() {
            email = user?.email.toString() ?? "";
            name = user?.fullName?.en.toString() ?? "";
            address = user?.address?.en.toString() ?? "";
            profilePic = user?.profilePic.toString();
            status = user?.status.toString() ?? "";
          });
          print(email);
          print(name);
          print(address);
          print(profilePic);
          print(status);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.toString())));
        }
      },
    );
    // });
    // setState(() {});
  }
}
