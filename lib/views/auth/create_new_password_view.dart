import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/CreateNewPasswordController.dart';
import 'package:graphqlgetxexample/repository/create_new_password_repository%20.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class CreateNewPasswordView extends StatefulWidget {
  CreateNewPasswordView({
    super.key,
    required this.otp,
    required this.email,
  });

  String otp;
  String email;

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final controller = Get.put(
    CreateNewPasswordController(
      CreateNewPasswordRepository(),
    ),
  );

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (Value) {
                            if (newPasswordController.text.toString() ==
                                confirmPasswordController.text.toString()) {
                              return null;
                            } else {
                              return 'Both passwords should be same';
                            }
                          },
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        //
                        Text("email: ${widget.email}"),
                        Text("otp: ${widget.otp}"),
                        //
                        const SizedBox(height: 20),
                        controller.obx(
                          (state) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                // if (state?.data != null) {
                                //   if (state!.data != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      // (state!.data as Message)
                                      //     .message
                                      //     .toString()
                                      "Password Changed",
                                    ),
                                  ),
                                );
                                Future.delayed(
                                  const Duration(seconds: 2),
                                );
                                print("After 2 seconds");

                                controller.change(null,
                                    status: RxStatus.empty());

                                // Get.to(SignInView());

                                context.push(SIGNIN);

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return SignInView();
                                //     },
                                //   ),
                                // );

                                // }
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //         (state!.error!.first.extensions.code
                                //             .message),
                                //       ),
                                //     ),
                                //   );
                                // }
                              },
                            );
                            return ChangePasswordButton();
                          },
                          onLoading:
                              const Center(child: CircularProgressIndicator()),
                          onEmpty: ChangePasswordButton(),
                          onError: (err) => _error(err.toString()),
                        ),
                      ],
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
        const SnackBar(content: Text("")),
      );
    });
    controller.change(null, status: RxStatus.empty());
    return ChangePasswordButton();
  }

  Widget ChangePasswordButton() => CustomButton(
        name: "Change Password",
        onClick: () {
          if (_key.currentState!.validate()) {
            controller.createNewPassword(
              widget.otp,
              widget.email,
              newPasswordController.text.toString(),
            );
          }
        },
        color: Colors.teal.shade300,
      );
}
