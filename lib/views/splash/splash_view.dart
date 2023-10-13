import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/LoginResponseModel.dart';
import 'package:graphqlgetxexample/widgets/animated_logo.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names
  SplashView({Key? key}) : super(key: key);
  var data = GetStorage();
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  double turns = 0.0;

  late AnimationController _controller;

  double taskFontInitial = 0.0;

  // void GoToMain() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     if (widget.data.read(USER_LOGIN_DATA) == null) {
  //       context.go(SIGNIN);
  //     } else {
  //       context.go(HOME);
  //     }
  //   });
  // }
  // if(data.read(USER_LOGIN_INFO)==null)
  // {
  // }
  // else
  // {
  // }

  var storage = GetStorage();

  late LoginResponse response;

  @override
  void initState() {
    //     response = LoginResponse.fromJson(
    //   jsonDecode(
    //     storage.read(USER_LOGIN_DATA),
    //   ),
    // );

    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _controller.repeat();

    Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          taskFontInitial = 36;
          // turns += 1;
        });
      },
    );

    loadDataAndNavigate();

    // Timer(
    //   const Duration(seconds: 4),
    //   () {
    //     if (widget.data.read(USER_LOGIN_DATA) == null) {
    //       print(widget.data.read(USER_LOGIN_DATA));
    //       print("Didn't find user going to login");
    //       context.go(SIGNIN);
    //     } else {
    //       print(widget.data.read(USER_LOGIN_DATA));
    //       print("Found user going to Home");
    //       context.go(HOME);
    //     }
    //   },
    //   // context.go(SIGNIN),
    //   // Navigator.goReplacement(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => const Home(),
    //   //   ),
    //   // ),
    // );
  }

  Future<void> loadDataAndNavigate() async {
    await Future.delayed(const Duration(seconds: 4));

    final userLoginData = storage.read(USER_LOGIN_DATA);
    if (userLoginData != null) {
      print("Found user, going to Home");
      context.go('/notification');
    } else {
      context.go(SIGNIN);
    }

    // context.go(HOME);

    // else {
    //   if (userLoginData != null) {
    //     print("Found user, going to Home");
    //     context.go(HOME);
    //   } else {
    //     if (userLoginData != null) {
    //       print("Found user going to Home");
    //       context.go(HOME);
    //     }

    //     else {
    //       print("Didn't find user going to login");
    //       context.go(SIGNIN);
    //     }
    //   }
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // GoToMain();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            AnimatedLogo(
              controller: _controller,
              turns: turns,
              taskFontInitial: taskFontInitial,
            ),
            Expanded(
              child: Lottie.asset(
                'assets/splashScreenAnimation.json',
                height: 200,
                width: 200,
              ),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size.fromHeight(50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   onPressed: () {
            //     setState(() {
            //       taskFontInitial = 36;
            //       turns += 1;
            //     });
            //   },
            //   child: const Text("Animate"),
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                loadDataAndNavigate();

                // if (widget.data.read(USER_LOGIN_DATA) == null) {
                //   print("Didn't find user going to login");
                //   context.go(SIGNIN);
                // } else {
                //   print("Found user going to Home");
                //   context.go(HOME);
                // }

                // context.go(SIGNIN);
                // Navigator.goReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Home(),
                //   ),
                // );
              },
              child: const Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}
