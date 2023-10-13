import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/role/DeleteRoleController.dart';
import 'package:graphqlgetxexample/controllers/role/RoleLovController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/models/UpdateRoleRequestModel.dart';
import 'package:graphqlgetxexample/repository/delete_role_repository.dart';
import 'package:graphqlgetxexample/repository/roles_lov_repository.dart';
import 'package:graphqlgetxexample/views/manageRole/updateRoleScreen.dart';
import 'package:graphqlgetxexample/widgets/shimmer_list_item.dart';
import 'package:shimmer/shimmer.dart';

class ManageRolesLovScreen extends StatefulWidget {
  ManageRolesLovScreen({super.key});

  final roleLovController = Get.put(
    RoleLovController(
      RoleLovRepository(),
    ),
  );

  final deleteRoleController = Get.put(
    DeleteRoleController(
      DeleteRoleRepository(),
    ),
  );

  var storage = GetStorage();

  @override
  State<ManageRolesLovScreen> createState() => _ManageRolesLovScreenState();
}

class _ManageRolesLovScreenState extends State<ManageRolesLovScreen> {
  late LoginResponse response;

  bool longPressed = false;

  int? longPressedIndex;

  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.roleLovController.change(null, status: RxStatus.empty());

      response = LoginResponse.fromJson(
        jsonDecode(
          widget.storage.read(USER_LOGIN_DATA),
        ),
      );

      print("response Manage Role screen: $response");

      loadRoleList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        widget.roleLovController.listOfRoles.value.map((e) => "${e.name.en}"));

    print(widget.roleLovController.listOfRoles.length);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        // title: const Text("Roles"),
        // centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_rounded),
        //   onPressed: () {
        //     context.push(NOTIFICATION_VIEW);
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push("/addRole");
        },
      ),
      body:
          // isLoading
          //     ? getShimmerLoading()
          //     :
          RefreshIndicator(
        onRefresh: () async {
          loadRoleList();
        },
        child: Obx(
          () => ListView.builder(
            itemCount: widget.roleLovController.listOfRoles.length,
            itemBuilder: (context, index) {
              final isLongPressed = index == longPressedIndex;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  onDismissed: (direction) {
                    // if (direction == DismissDirection.endToStart) {
                    widget.deleteRoleController.deleteRole(
                      response.token,
                      widget.roleLovController.listOfRoles[index].id,
                      (isdeleted) {
                        if (isdeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Delete Successfully")));
                          widget.roleLovController.listOfRoles.removeAt(index);
                          // context.push("/manageRole");
                          //       .removeAt(index);
                          // setState(() {
                          //
                          // });
                        } else if (!isdeleted) {
                          setState(() {
                            loadRoleList();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Can't delete this Role\nBecause it is assigned to users",
                              ),
                            ),
                          );
                        }
                      },
                    );
                    // }
                  },
                  child: ListTile(
                    onTap: () {
                      // context.push(
                      //   UPDATE_ROLE,
                      //   extra: widget.roleLovController.listOfRoles[index].id,
                      // );

                      print(
                          "on screen: ${widget.roleLovController.listOfRoles.value[index]}");
                      print(
                          "on screen: ${widget.roleLovController.listOfRoles.value[index].toJson()}");

                      //
                      // context.pushNamed(UPDATE_ROLE, queryParameters: {
                      //   'roldata':
                      //       widget.roleLovController.listOfRoles.value[index]
                      // });

                      context.push(
                        '/updateRole',
                        extra:
                            widget.roleLovController.listOfRoles.value[index],
                      );

                      // context.push(UPDATE_ROLE,
                      //     pa: widget
                      //         .roleLovController.listOfRoles.value[index]);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return UpdateRoleScreen(
                      //         update: widget.roleLovController.listOfRoles
                      //             .value[index] as UpdateRoleModelRequest,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    onLongPress: () {
                      setState(() {
                        longPressedIndex = index;
                      });
                    },
                    tileColor: Colors.tealAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      widget.roleLovController.listOfRoles[index].name.en!,
                    ),
                    subtitle: Text(
                      ("Active: ${widget.roleLovController.listOfRoles[index].active.toString()}"),
                    ),
                    trailing: isLongPressed
                        ? IconButton(
                            icon: const Icon(
                              Icons.delete_rounded,
                              size: 32,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Are you sure"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () async {
                                          setState(() {
                                            longPressedIndex = null;
                                          });
                                          widget.deleteRoleController
                                              .deleteRole(
                                                  response.token,
                                                  widget
                                                      .roleLovController
                                                      .listOfRoles[index]
                                                      .id, (isdeleted) {
                                            if (isdeleted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Delete Successfully")));
                                              setState(() {
                                                widget.roleLovController
                                                    .listOfRoles
                                                    .removeAt(index);
                                              });
                                              context.push("/manageRole");
                                            } else if (!isdeleted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Can't delete this Role\nBecause it is assigned to users",
                                                  ),
                                                ),
                                              );
                                            }
                                          });

                                          // deleteRole(index);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            setState(() {
                                              longPressedIndex = null;
                                            });
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : const SizedBox(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  deleteRole(index) async {
    print(
      "Role Id: ${widget.roleLovController.listOfRoles[index].id}",
    );
    await widget.deleteRoleController.deleteRole(
        response.token, widget.roleLovController.listOfRoles[index].id,
        (isdeleted) {
      if (isdeleted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Delete Successfully")));
        widget.roleLovController.listOfRoles.removeAt(index);
        context.push("/manageRole");
      }
    });
  }

  removeDigit(final String s) {
    return s.replaceAll(RegExp(r"[0-9]+"), "");
  }

  loadRoleList() async {
    await Future.delayed(
      const Duration(milliseconds: 3),
      () {
        // await
        widget.roleLovController.roleLov(response.token);
        print(
          "Api response in load function listOfRoles: ${widget.roleLovController.listOfRoles}",
        );
      },
    );
  }

  showAletDialogbox(BuildContext context, String heading, String message,
      String confirmbutton, String cancelbutton, int index) {}

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
          ],
        ),
      ),
    );
  }
}
