import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/LoginUserController.dart';
import 'package:graphqlgetxexample/models/LoginRequestModel.dart';
import 'package:graphqlgetxexample/repository/login_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class SignInView extends StatefulWidget {
  SignInView({Key? key}) : super(key: key);

  final controller = Get.put(
    LoginUserController(LoginUserRepository()),
  );

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  final _key = GlobalKey<FormState>();

  late String newtoken;

  late AnimationController _controller;
  double _offset = 0.0;
  double initailHeight = 10.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ignore: invalid_use_of_protected_member
      widget.controller.change(null, status: RxStatus.empty());
      requestPermission();
      getToken();
      widget.controller.fetchPublicIP();

      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      )..addListener(() {
          setState(() {
            _offset = _controller.value * 50.0;
          });
        });
    });

    super.initState();
  }

  void _startAnimationPencil() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  void _stopAnimationPencil() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  void _startAnimationShhh() {
    setState(() {
      initailHeight = 80;
    });
  }

  void _stopAnimationShhh() {
    setState(() {
      initailHeight = 10.0;
    });
  }

  Future<void> sizeChange() async {
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      initailHeight = 80;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        newtoken = token!;
        print("Token: $newtoken");
      });
    });
    return newtoken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/paper.png',
                      width: 210,
                      height: 210,
                    ),
                    Positioned(
                      top: 32,
                      left: 67,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceOut,
                        height: initailHeight,
                        child: isObscure
                            ? const SizedBox()
                            : Image.asset(
                                'assets/shhhh.png',
                                width: 80,
                                height: 80,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 48,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.translationValues(_offset, 0, 0),
                        child: Image.asset(
                          'assets/pencil.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                // Image.asset(
                //   "assets/login.png",
                //   width: 200,
                //   height: 200,
                // ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 68,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) return "Enter Email";
                    if (value.isEmpty ||
                        !RegExp(
                          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                        ).hasMatch(value)) {
                      return "Enter Email correctly";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      _startAnimationPencil();
                    } else {
                      _stopAnimationPencil();
                    }
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty
                        // ||
                        //     !RegExp(
                        //       r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                        //     ).hasMatch(value)
                        ) {
                      return "Enter Password correctly";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      _startAnimationPencil();
                    } else {
                      _stopAnimationPencil();
                    }
                  },
                  obscureText: isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                          if (!isObscure) {
                            _startAnimationShhh();
                          } else {
                            _stopAnimationShhh();
                          }
                          // sizeChange();
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                widget.controller.obx(
                  (state) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        if (state?.data != null) {
                          if (state!.data != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Login Succesffuly",
                                ),
                              ),
                            );

                            context.go('/notification');
                          }

                          // Get.toNamed(HomeScreen());
                          // Get.to(const HomeScreen());

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return const HomeScreen();
                          //     },
                          //   ),
                          // );
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
                    return SignInButton();
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: SignInButton(),
                  onError: (err) => _error(err.toString()),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.push(FORGET_PASSWORD);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return ForgetPasswordView();
                    //     },
                    //   ),
                    // );
                  },
                  child: const Text("Forget Password?"),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Don't Have an Account?"),
                    TextButton(
                      onPressed: () {
                        // Navigator.pop(context);

                        context.push(SIGNUP);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return SignUpView();
                        //     },
                        //   ),
                        // );
                      },
                      child: const Text("Sign Up"),
                    )
                  ],
                ),
              ],
            ),
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
    widget.controller.change(null, status: RxStatus.empty());
    return SignInButton();
  }

  Widget SignInButton() => CustomButton(
        name: "Sign In",
        onClick: () {
          // widget.controller.change(null, status: RxStatus.loading());
          if (_key.currentState!.validate()) {
            widget.controller.loginUser(UserLoginRequest(
              loginIp: widget.controller.ipAddress,
              deviceId: newtoken,
              email: emailController.text.toString(),
              password: passwordController.text.toString(),
            ));
          }
        },
        color: Colors.teal.shade300,
      );
}
