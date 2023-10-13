import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/ForgetPasswordController.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/forget_password_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final controller = Get.put(
    ForgetPasswordController(
      ForgetPasswordRepository(),
    ),
  );

  TextEditingController emailController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // ignore: invalid_use_of_protected_member
    controller.change(null, status: RxStatus.empty());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/forget.png",
              width: 200,
              height: 200,
            ),
            Expanded(
              child: Container(
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
                  child: Column(
                    children: [
                      Form(
                        key: _key,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      controller.obx(
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

                                // Get.to(
                                //   OTPView(
                                //     email: emailController.text.toString(),
                                //   ),
                                // );

                                context.push(
                                  OTP,
                                  extra: emailController.text.toString(),
                                );

                                // Get.toNamed("login",
                                //     arguments: emailController.text.toString());

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return OTPView(
                                //         email: emailController.text.toString(),
                                //       );
                                //     },
                                //   ),
                                // );
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            onPressed: () {
                              // Get.to(SignInView());

                              // Navigator.pop(context);

                              context.pop();

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return SignInView();
                              //     },
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.teal,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                    ],
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
    controller.change(null, status: RxStatus.empty());
    return SubmitButton();
  }

  Widget SubmitButton() => CustomButton(
        name: "Submit",
        onClick: () {
          if (_key.currentState!.validate()) {
            controller.forgetPassword(
              emailController.text.toString(),
            );
          }
        },
        color: Colors.teal.shade300,
      );
}
