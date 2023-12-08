import 'package:flutter/material.dart';
import 'package:we_hire/src/common_widget/form/form_header_widget.dart';
import 'package:we_hire/src/constants/image_strings.dart';
import 'package:we_hire/src/constants/sizes.dart';
import 'package:we_hire/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

import '../../../../../constants/text_strings.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                SizedBox(height: tDefaultSize * 4),
                FormHeaderWidget(
                  image: tForgetPasswordImage,
                  title: tForgetPasswordTitle,
                  subTitle: tForgetPasswordSubTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: tFormHeight,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(tEmail),
                          hintText: tEmail,
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OTPScreen()),
                                );
                              },
                              child: const Text(tNext))),
                    ],
                  ),
                ),
              ],
            )),
      )),
    );
  }
}
