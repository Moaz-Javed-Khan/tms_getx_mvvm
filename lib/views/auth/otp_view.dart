import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/NestedShellRouting.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';
import 'package:graphqlgetxexample/controllers/authController/VerifyOTPController.dart';
import 'package:graphqlgetxexample/models/MessageModel.dart';
import 'package:graphqlgetxexample/repository/verify_otp_repository.dart';
import 'package:graphqlgetxexample/widgets/CutomButton.dart';

class OTPView extends StatefulWidget {
  OTPView({
    super.key,
    required this.email,
  });

  final controller = Get.put(
    VerifyOTPController(
      VerifyOTPRepository(),
    ),
  );

  final String email;

  // final email = Get.arguments;

  // final email = ;

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  String? OTP;

  @override
  void initState() {
    super.initState();
    // ignore: invalid_use_of_protected_member
    widget.controller.change(null, status: RxStatus.empty());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "We mailed you a code at ${widget.email}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const Text(
                "Please enter it below",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 24),
              OtpTextField(
                numberOfFields: 4,
                showFieldAsBox: false,
                borderColor: Colors.black,
                //set to true to show as box or false to show as dash
                fieldWidth: 50.0,
                keyboardType: TextInputType.number,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                  OTP = code;
                },
                onSubmit: (String code) {
                  //handle validation or checks here
                  OTP = code;
                },
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
                              (state?.data as Message).message.toString(),
                            ),
                          ),
                        );

                        // Get.to(CreateNewPasswordView(
                        //   email: widget.email,
                        //   otp: OTP!,
                        // ));

                        context.goNamed(
                          'newPass',
                          pathParameters: {
                            'email': widget.email,
                            'otp': OTP!,
                          },
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return CreateNewPasswordView(
                        //         email: widget.email,
                        //         otp: OTP!,
                        //       );
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
                  return verifiyOtpbtn();
                },
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: verifiyOtpbtn(),
                onError: (err) => _error(err.toString()),
              ),
              const SizedBox(height: 12),
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
                child: const Text("Didn't get code?"),
              )
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
    widget.controller.change(null, status: RxStatus.empty());
    return verifiyOtpbtn();
  }

  Widget verifiyOtpbtn() => CustomButton(
        name: "Verifiy OTP",
        onClick: () {
          widget.controller.verifyOTP(
            OTP!,
            widget.email,
            "",
          );
        },
        color: Colors.teal,
      );
}
