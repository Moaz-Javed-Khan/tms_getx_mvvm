import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/LogoutUserController.dart';
import 'package:graphqlgetxexample/controllers/getUserById/GetUserByIdController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/repository/get_user_byid_repository.dart';
import 'package:graphqlgetxexample/repository/logout_repository%20.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  final logoutUserController = Get.put(
    LogoutUserController(
      LogoutUserRepository(),
    ),
  );

  final getUserByIdController = Get.put(
    GetUserByIdController(
      GetUserByIdRepository(),
    ),
  );

  var storage = GetStorage();

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late LoginResponse? response;
  bool isLoading = false;
  final router = goRouter;

  late String deviceId;

  @override
  void initState() {
    super.initState();

    widget.logoutUserController.change(null, status: RxStatus.empty());

    getToken();

    response = LoginResponse.fromJson(
      jsonDecode(
        widget.storage.read(USER_LOGIN_DATA),
      ),
    );
  }

  Future<String> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceId = token!;
        print("Token: $deviceId");
      });
    });
    return deviceId;
  }

  // XFile? _image;
  // final picker = ImagePicker();
  // Future getImageFromGallery() async {
  //   final pickedImage = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 80,
  //   );
  //   setState(() {
  //     if (pickedImage != null) {
  //       _image = pickedImage;
  //       print("Image picked $_image");
  //     } else {
  //       print("No image picked");
  //     }
  //   });
  // }

  // Future getImageByCamera() async {
  //   final pickedImage = await picker.pickImage(
  //     source: ImageSource.camera,
  //     imageQuality: 80,
  //   );
  //   setState(() {
  //     if (pickedImage != null) {
  //       _image = pickedImage;
  //       print("Image picked $_image");
  //     } else {
  //       print("No image picked");
  //     }
  //   });
  // }

  // void _showImageSourceMenu(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: const EdgeInsets.symmetric(vertical: 20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Choose from Gallery'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 getImageFromGallery();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: const Text('Take a Photo'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 getImageByCamera();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14,
            right: 8.0,
            bottom: 8.0,
            left: 8.0,
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(60),
                      ),
                      child: Image.network(
                        IMG_END_POINT + response!.profilePic ?? "",
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        loadingBuilder: (context, child, loadingProgress) {
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(6.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         // decodedData['fullName']['en'],
                  //         // widget.response.fullName.en ?? "Not Found",
                  //         nameEn,
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       Text(
                  //         // decodedData['fullName']['ar'],
                  //         // widget.response.fullName.ar ?? "غير معثور عليه",
                  //         nameAr,
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // decodedData['fullName']['en'],
                          response!.role.name.en ?? "Not Found",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // decodedData['fullName']['ar'],
                          response!.role.name.ar ?? "غير معثور عليه",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey[200],
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Accounts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          context.push('/profile/updateProfile');
                        },
                        child: const Text(
                          "Account Settings",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.black),
                      const Text(
                        "Manage User Accounts",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey[200],
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "User Control",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          print("Clicked");
                          context.push('/profile/manageRole');
                        },
                        child: const Text(
                          "Manage Roles",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.black),
                      const Text(
                        "Manage Role Permissions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Divider(color: Colors.black),
                      const Text(
                        "Email Permissions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              widget.logoutUserController.obx(
                (state) {
                  SchedulerBinding.instance.scheduleFrameCallback(
                    (_) {
                      if (state?.data != null) {
                        if (state!.data != null) {
                          widget.storage.erase();

                          context.pushReplacement(SIGNIN);
                          print("Logged out");

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Logout Succesffuly",
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              (state!.error!.first.extensions.code.message),
                            ),
                          ),
                        );
                      }
                    },
                  );
                  return LogoutButton();
                },
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: LogoutButton(),
                onError: (err) => _error(err.toString()),
              ),
            ],
          ),
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
    widget.logoutUserController.change(null, status: RxStatus.empty());
    return LogoutButton();
  }

  Widget LogoutButton() => CustomButton(
        name: "Logout",
        onClick: () async {
          await widget.logoutUserController.logoutUser(
            deviceId,
            response!.token ?? "",
          );
        },
        color: Colors.teal.shade300,
      );
}
