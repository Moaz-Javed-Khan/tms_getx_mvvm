import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';

class SideDrawerHeader extends StatefulWidget {
  const SideDrawerHeader({super.key});

  @override
  State<SideDrawerHeader> createState() => _SideDrawerHeaderState();
}

class _SideDrawerHeaderState extends State<SideDrawerHeader> {
  var storage = GetStorage();
  late LoginResponse response;

  var storedData;
  var decodedData;
  var loginData;

  void getData() {
    storedData = GetStorage().read("LoginData");
    if (storedData != null) {
      decodedData = jsonDecode(storedData);
      loginData = LoginResponse.fromJson(decodedData);
      print("Data Found");
      // print(decodedData['fullName']['en']);
      // print(decodedData['fullName']['ar']);
      // print(loginData['fullName']);
      // var name = decodedData['name'];
      // var image = decodedData['image'];
    } else {
      print("No data Found");
    }
  }

  @override
  void initState() {
    super.initState();

    response = LoginResponse.fromJson(
      jsonDecode(
        storage.read(USER_LOGIN_DATA),
      ),
    );
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // print("in build method: ${decodedData['fullName']['en']}");
    // print("in build method: ${decodedData['fullName']['ar']}");
    // print("in build method: ${decodedData['profilePic']}");

    String? image; //= decodedData['profilePic'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(60),
              ),
              child: Image.network(
                IMG_END_POINT + response.profilePic.toString(),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.account_circle_outlined,
                  size: 100,
                ),
              ),
            ),

            // (image != null)
            //     ? ClipRRect(
            //         borderRadius: const BorderRadius.all(
            //           Radius.circular(60),
            //         ),
            //         child: Image.network(
            //           IMG_END_POINT + image,
            //           fit: BoxFit.cover,
            //           width: 80,
            //           height: 80,
            //         ),
            //       )
            //     : const Icon(
            //         Icons.account_circle,
            //         size: 120,
            //       ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // decodedData['fullName']['en'],
                response.fullName.en ?? "Not Found",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // decodedData['fullName']['ar'],
                response.fullName.ar ?? "غير معثور عليه",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
