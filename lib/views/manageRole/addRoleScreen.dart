import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/role/AddRoleController.dart';
import 'package:graphqlgetxexample/models/AddRoleRequestModel.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/repository/add_role_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class AddRoleScreen extends StatefulWidget {
  AddRoleScreen({super.key});

  final controller = Get.put(
    AddRoleController(AddRoleRepository()),
  );

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  TextEditingController roleNameEnController = TextEditingController();
  TextEditingController roleNameArController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // ignore: invalid_use_of_protected_member
    widget.controller.change(null, status: RxStatus.empty());
  }

  List<String> list = <String>[
    'Active',
    'In-Active',
  ];

  bool? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/forget.png",
              width: 160,
              height: 160,
            ),
            Expanded(
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
                            "Add Role",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: roleNameEnController,
                            decoration: const InputDecoration(
                              labelText: 'Role',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: roleNameArController,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              labelText: 'دور',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: "Status",
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
                            onLoading: const Center(
                                child: CircularProgressIndicator()),
                            onEmpty: SubmitButton(),
                            onError: (err) => _error(err.toString()),
                          ),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.bottomLeft,
                          //     child: IconButton(
                          //       onPressed: () {
                          //         context.push(MANAGE_ROLE);
                          //       },
                          //       icon: const Icon(
                          //         Icons.arrow_back_ios_new_rounded,
                          //         color: Colors.teal,
                          //         size: 36,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
            widget.controller.addRole(
              AddRoleModelRequest(
                active: selectedStatus,
                name: Name(
                  ar: roleNameArController.text,
                  en: roleNameEnController.text,
                ),
              ),
            );
          }
        },
        color: Colors.teal.shade300,
      );
}
