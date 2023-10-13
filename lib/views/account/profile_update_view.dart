import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/getUserById/GetUserByIdController.dart';
import 'package:graphqlgetxexample/controllers/updateUserProfile/UpdateUserProfileController.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/AddressModel.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/models/UpdateUser.dart';
import 'package:graphqlgetxexample/repository/get_user_byid_repository.dart';
import 'package:graphqlgetxexample/repository/update_user_profile_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateView extends StatefulWidget {
  ProfileUpdateView({super.key});

  final updateUserProfileController = Get.put(
    UpdateUserProfileController(
      UpdateUserProfileRepository(),
    ),
  );

  final getUserByIdController = Get.put(
    GetUserByIdController(
      GetUserByIdRepository(),
    ),
  );

  var storage = GetStorage();

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  TextEditingController updateNameEnController = TextEditingController();
  TextEditingController updateNameArController = TextEditingController();
  TextEditingController updatePhoneNumberController = TextEditingController();
  TextEditingController updateAddressEnController = TextEditingController();
  TextEditingController updateAddressArController = TextEditingController();

  String nameEn = "";
  String nameAr = "";
  String addressEn = "";
  String addressAr = "";
  String profilePic = "";
  String email = "";
  String? selected_gender;
  String phoneNumber = "";
  String status = "";

  List<String> list = <String>[
    'Male',
    'Female',
  ];

  // File? _image;
  // List<File> imgs = [];

  List<File> imglist = [];
  late String profilepic;

  late LoginResponse response;

  @override
  void initState() {
    widget.updateUserProfileController.change(null, status: RxStatus.empty());

    response = LoginResponse.fromJson(
      jsonDecode(
        widget.storage.read(USER_LOGIN_DATA),
      ),
    );

    setState(() {
      getUserDetailById(response.id);
    });

    // updateUserProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // selectedGender = gender;
    // String dropdownValue = gender;

    updateNameEnController.text = nameEn;
    updateNameArController.text = nameAr;
    updatePhoneNumberController.text = phoneNumber;
    updateAddressEnController.text = addressEn;
    updateAddressArController.text = addressAr;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        // title: const Text("Update Profile"),
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
        // ignore: prefer_const_literals_to_create_immutables
        child: SingleChildScrollView(
          child: Column(
            children: [
              (response != null && response.profilePic != null)
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: (imglist.length > 0)
                            ? DecorationImage(
                                image: FileImage(File(imglist.first.path)),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(
                                  IMG_END_POINT + (response.profilePic),
                                ),
                              ),
                        border: Border.all(
                          // Border ka color
                          color: Colors.white,
                          width: 1.0, // Border ka width
                        ),
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: (imglist.isEmpty)
                              ? const DecorationImage(
                                  image: ExactAssetImage(
                                    "assets/images/ic_placeholder.png",
                                  ),
                                  fit: BoxFit.fill,
                                )
                              : DecorationImage(
                                  image: FileImage(File(imglist.first.path)),
                                  fit: BoxFit.cover,
                                )),
                    ),

              // Container(
              //   width: 100,
              //   height: 100,
              //   decoration: BoxDecoration(
              //       border: Border.all(
              //         // Border ka color
              //         color: Colors.white,
              //         width: 1.0, // Border ka width
              //       ),
              //       shape: BoxShape.circle),
              //   child: ClipOval(
              //     child: CachedNetworkImage(
              //       fit: BoxFit.cover,
              //       imageUrl:
              //           (IMG_END_POINT + (widget?.response.profilePic ?? "")),
              //       placeholder: (context, url) =>
              //           new CircularProgressIndicator(),
              //       errorWidget: (context, url, error) => new Icon(Icons.error),
              //     ),
              //   ),
              // ),
              // Container(
              //   width: 120,
              //   height: 120,
              //   margin: EdgeInsets.only(top: 10),
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: (imgs.isEmpty)
              //           ? DecorationImage(
              //               image: ExactAssetImage(
              //                 "assets/images/ic_placeholder.png",
              //               ),
              //               fit: BoxFit.fill)
              //           : DecorationImage(
              //               image: FileImage(File(imgs.first.path)),
              //               fit: BoxFit.cover)),
              // ),

              // ignore: prefer_const_constructors
              // Center(
              //   // ignore: prefer_const_constructors
              //   child:

              //   ClipRRect(
              //     borderRadius: const BorderRadius.all(
              //       Radius.circular(60),
              //     ),
              //     child: imgs != null
              //         ? Image.file(
              //             File(imgs.first.path),
              //             fit: BoxFit.cover,
              //             height: 100,
              //             width: 100,
              //           )
              //         : Image.network(
              //             IMG_END_POINT + profilePic.toString(),
              //             fit: BoxFit.cover,
              //             width: 100,
              //             height: 100,
              //             loadingBuilder: (context, child, loadingProgress) {
              //               if (loadingProgress == null) {
              //                 return child;
              //               }
              //               return const CircularProgressIndicator();
              //             },
              //             errorBuilder: (context, error, stackTrace) =>
              //                 const Icon(
              //               Icons.account_circle_outlined,
              //               size: 100,
              //             ),
              //           ),
              //   ),
              // ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  selectfiles();
                  print("image list: ${imglist.length}");
                  print("Image Picker Clicked!");
                },
                child: const Text("Change Profile Picture"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: updateNameEnController,
                decoration: const InputDecoration(
                  labelText: 'Full Name in English',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: updateNameArController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل بالعربية',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: updatePhoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: updateAddressEnController,
                decoration: const InputDecoration(
                  labelText: 'Address in English',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: updateAddressArController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'العنوان بالعربية',
                  labelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
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
                value: selected_gender,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? value) {
                  setState(() {
                    selected_gender = value;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              widget.updateUserProfileController.obx(
                (state) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      if (state?.data != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text((state?.data as Message).message ?? ""),
                          ),
                        );
                        context.pop();
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
                  return Update();
                },
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: Update(),
                onError: (err) => _error(err.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // updateUserProfile() async {
  //   await widget.updateUserProfileController.updateUserProfile(
  //     UpdateProfileDetailInput(
  //       profilePic: response.profilePic,
  //       address: Address(
  //         en: updateAddressEnController.text.toString(),
  //         ar: updateAddressArController.text.toString(),
  //       ),
  //       fullName: Name(
  //         en: updateNameEnController.text.toString(),
  //         ar: updateNameArController.text.toString(),
  //       ),
  //       gender: selectedGender!,
  //       phoneNumber: updatePhoneNumberController.text.toString(),
  //     ),
  //     response.token,
  //   );
  // }

  getUserDetailById(int userId) async {
    // Future.delayed(const Duration(seconds: 3), () {
    await widget.getUserByIdController.getUserById(
      userId,
      response.token,
      (success, message, user) {
        if (success) {
          setState(() {
            nameEn = user?.fullName?.en.toString() ?? "";
            nameAr = user?.fullName?.ar.toString() ?? "";
            addressEn = user?.address?.en.toString() ?? "";
            addressAr = user?.address?.ar.toString() ?? "";
            response.profilePic = user!.profilePic ?? "";
            status = user.status.toString();
            selected_gender = user.gender.toString();
            phoneNumber = user.phoneNumber.toString();
          });
          print(email);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.toString())));
        }
      },
    );
    // });
    // setState(() {});
  }

  // Future getImageFromGallery() async {
  //   final FilePickerResult? picker = await .pickImage(
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

  // selectedfile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ["png", "jpg"],
  //     allowMultiple: false,
  //   );
  //   if (result != null) {
  //     bool valid = true;
  //     for (var file in result.files) {
  //       if (!["png", "jpg"].contains(file.extension?.toLowerCase())) {
  //         valid = false;
  //         break;
  //       }
  //     }
  //     if (valid) {
  //       imglist.clear();
  //       imglist
  //           .addAll(result.files.map((files) => File(files.path.toString())));
  //     } else {}
  //   }
  // }

  Future<void> selectfiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: false);
    if (result != null) {
      print("Selected image: ${result.files}");
      bool isValid = true;
      for (var file in result.files) {
        if (!['jpg', 'png'].contains(file.extension?.toLowerCase())) {
          isValid = false;
          break; // Exit loop if an invalid extension is found
        }
      }
      if (isValid) {
        imglist.clear();
        imglist.addAll(
            result.files.map((file) => File(file.path.toString())).toList());
        print("imglist.length${imglist.length}");
        print("imglist${imglist}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select a valid JPG or PNG file')),
        );
      }
    }
    setState(() {});
  }

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

  Widget _error(String error_msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error_msg)),
      );
    });
    widget.updateUserProfileController.change(null, status: RxStatus.empty());
    return Update();
  }

  Widget Update() => CustomButton(
        name: "Update",
        onClick: () async {
          await widget.updateUserProfileController.updateUserProfile(
              UpdateProfileDetailInput(
                  address: Address(
                    en: updateAddressEnController.text,
                    ar: updateAddressArController.text,
                  ),
                  fullName: Name(
                    en: updateNameEnController.text,
                    ar: updateNameArController.text,
                  ),
                  gender: selected_gender.toString(),
                  phoneNumber: updatePhoneNumberController.text,
                  profilePic:
                      (imglist.isEmpty) ? null : File(imglist.first.path).path),
              response.token);
        },
        color: Colors.tealAccent,
      );
}
