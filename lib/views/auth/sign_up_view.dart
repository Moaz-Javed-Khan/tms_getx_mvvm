import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/CreateUsercontroler.dart';
import 'package:graphqlgetxexample/models/AddressModel.dart';
import 'package:graphqlgetxexample/models/CreateUserInputModel.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/models/NameModel.dart';
import 'package:graphqlgetxexample/repository/create_user_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  final controller = Get.put(CreateUserController(CreateUserRepository()));

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressEnController = TextEditingController();
  TextEditingController addressArController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  final _key = GlobalKey<FormState>();

  late String newtoken;

  late AnimationController _controller;
  double _offset = 0.0;
  double initailHeight = 10.0;

  @override
  void initState() {
    super.initState();
    // ignore: invalid_use_of_protected_member
    widget.controller.change(null, status: RxStatus.empty());
    requestPermission();
    getToken();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          _offset = _controller.value * 50.0;
        });
      });
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
                //   width: 150,
                //   height: 150,
                // ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
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
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Enter Name correctly";
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
                  controller: nameEnController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name in English',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
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
                  controller: nameArController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل بالعربية',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^(?:[+0]9)?[0-9]{10,12}$').hasMatch(value)) {
                      return "Enter Phone Number correctly";
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
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Address";
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
                  controller: addressEnController,
                  decoration: const InputDecoration(
                    labelText: 'Address in English',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Address";
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
                  controller: addressArController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    labelText: 'العنوان بالعربية',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                        ).hasMatch(value)) {
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
                  controller: passwordController,
                  obscureText: isObscure,
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
                      (_) {
                        if (state?.data != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                (state?.data as Message).message!,
                              ),
                            ),
                          );
                          context.push(SIGNIN);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return SignInView();
                          //     },
                          //   ),
                          // );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                (state!.error!.first.extensions.code.message
                                        as Message)
                                    .message!,
                              ),
                            ),
                          );
                        }
                      },
                    );
                    return SignUpButton();
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: SignUpButton(),
                  onError: (err) => _error(err.toString()),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Already Have an Account?"),
                    TextButton(
                      onPressed: () {
                        context.pop();

                        // Navigator.pop(context);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return SignInView();
                        //     },
                        //   ),
                        // );
                      },
                      child: const Text("Login"),
                    )
                  ],
                )
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
    return SignUpButton();
  }

  Widget SignUpButton() => CustomButton(
        name: "Sign Up",
        onClick: () {
          if (_key.currentState!.validate()) {
            widget.controller.createUser(CreateUserInput(
              deviceId: newtoken,
              // "fQPaehnIQRWOJIDYb9RbSS:APA91bHg0GjXdguEZp-8eVrbl2kuLDNFBOEG-el5__yNdgyYlc6ES6HGiziA4z1gnTeq6PzbhRkqMrOz8TVBKqWixJN6UqbrWfAXAszdnXg9J89D7n4SqSu1ZxbhZfurdaLcvSmsiIsN",
              email: emailController.text.toString(),
              fullName: Name(
                ar: nameArController.text.toString(),
                en: nameEnController.text.toString(),
              ),
              phoneNumber: phoneNumberController.text.toString(),
              address: Address(
                ar: addressArController.text.toString(),
                en: addressEnController.text.toString(),
              ),
              password: passwordController.text.toString(),
            ));
          }
        },
        color: Colors.teal.shade300,
      );
}
