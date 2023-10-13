import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/role/UpdateRoleController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/models/RoleLovResponseModel.dart';
import 'package:graphqlgetxexample/models/UpdateRoleRequestModel.dart';
import 'package:graphqlgetxexample/repository/Update_role_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class UpdateRoleScreen extends StatefulWidget {
  UpdateRoleScreen({
    super.key,
    required this.update,
  });

  final controller = Get.put(
    UpdateRoleController(UpdateRoleRepository()),
  );

  var storage = GetStorage();

  final RoleLovResponse? update;

  @override
  State<UpdateRoleScreen> createState() => _UpdateRoleScreenState();
}

class _UpdateRoleScreenState extends State<UpdateRoleScreen> {
  TextEditingController updateRoleNameEnController = TextEditingController();
  TextEditingController updateRoleNameArController = TextEditingController();

  final _key = GlobalKey<FormState>();

  late LoginResponse response;

  @override
  void initState() {
    super.initState();

    widget.controller.change(null, status: RxStatus.empty());

    response = LoginResponse.fromJson(
      jsonDecode(
        widget.storage.read(USER_LOGIN_DATA),
      ),
    );
    updateRoleNameEnController.text = widget.update!.name.en!;
    updateRoleNameArController.text = widget.update!.name.ar!;
    initialStatus = widget.update!.active!;
    selectedStatus = initialStatus;

    // widget.update =
    //     RoleLovResponse.fromJson(Get.arguments);
  }

  List<String> list = <String>[
    'Active',
    'In-Active',
  ];

  late bool initialStatus;
  late bool selectedStatus;

  @override
  Widget build(BuildContext context) {
    // final data = GoRouter.of()

    print("Role Id: ${widget.update?.id}");
    print("Role Active: ${widget.update?.active}");
    print("Role Name: ${widget.update?.name}");

    // final args = ModalRoute.of(context)!.settings.arguments;
    // print("Role Id: ${args}");
    // final RoleLovResponse? roleLovResponse =
    //     ModalRoute.of(context)?.settings.arguments as RoleLovResponse?;
    // print("Role Id: ${roleLovResponse!.id}");
    // print("Role Active: ${roleLovResponse.active}");
    // print("Role Name: ${roleLovResponse.name}");
    // updateRoleNameEnController.text = roleLovResponse.name.en!;
    // updateRoleNameArController.text = roleLovResponse.name.ar!;
    // initialStatus = roleLovResponse.active!;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 28,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(100, 255, 218, 1),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              "assets/forget.png",
              width: 160,
              height: 160,
              // width: MediaQuery.of(context).size.width * 0.3,
              // height: MediaQuery.of(context).size.height * 0.7,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  right: 16.0,
                  bottom: 16.0,
                  left: 16.0,
                ),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Text(
                          "Update Role",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: updateRoleNameEnController,
                          decoration: const InputDecoration(
                            labelText: 'Role',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: updateRoleNameArController,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            labelText: 'دور',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.teal,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          value: initialStatus ? "Active" : "In-Active",
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            if (value == "Active") {
                              setState(() {
                                selectedStatus = true;
                              });
                            } else if (value == "In-Active") {
                              setState(() {
                                selectedStatus = false;
                              });
                            }
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        // DropdownButtonFormField<String>(
                        //   decoration: const InputDecoration(
                        //     hintText: "Status",
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Colors.teal,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Colors.teal,
                        //       ),
                        //     ),
                        //   ),
                        //   isExpanded: true,
                        //   borderRadius: BorderRadius.circular(10),
                        //   icon: const Icon(Icons.arrow_drop_down_sharp),
                        //   elevation: 16,
                        //   style: const TextStyle(color: Colors.black),
                        //   onChanged: (String? value) {
                        //     if (value == "Active") {
                        //       setState(() {
                        //         selectedStatus = true;
                        //       });
                        //     } else if (value == "In-Active") {
                        //       setState(() {
                        //         selectedStatus = false;
                        //       });
                        //     }
                        //   },
                        //   items: list
                        //       .map<DropdownMenuItem<String>>((String value) {
                        //     return DropdownMenuItem<String>(
                        //       value: value,
                        //       child: Text(value),
                        //     );
                        //   }).toList(),
                        // ),
                        const SizedBox(height: 20),
                        widget.controller.obx(
                          (state) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                if (state?.data != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        (state?.data as Message)
                                            .message
                                            .toString(),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        (state!.error!.first.extensions.code
                                            .message),
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                            return SubmitButton();
                          },
                          onLoading:
                              const Center(child: CircularProgressIndicator()),
                          onEmpty: SubmitButton(),
                          onError: (err) => _error(err.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _error(String error_msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error_msg)),
      );
    });
    widget.controller.change(null, status: RxStatus.empty());
    return SubmitButton();
  }

  Widget SubmitButton() => CustomButton(
        name: "Submit",
        onClick: () {
          if (_key.currentState!.validate()) {
            widget.controller.updateRole(
              response.token,
              UpdateRoleModelRequest(
                active: selectedStatus,
                name: Name(
                  ar: updateRoleNameArController.text,
                  en: updateRoleNameEnController.text,
                ),
                id: widget.update!.id, // 2,  roleLovResponse.id,
              ),
            );
          }
        },
        color: Colors.teal.shade300,
      );
}
