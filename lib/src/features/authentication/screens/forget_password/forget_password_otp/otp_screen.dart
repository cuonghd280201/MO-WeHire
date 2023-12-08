import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:we_hire/src/constants/sizes.dart';
import 'package:we_hire/src/constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(tDefaultSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tOtpTitle,
            // style: GoogleFonts.montserrat(
            //   fontWeight: FontWeight.bold,
            //   fontSize: 100.0,
            // ),
          ),
          Text(
            tOtpSubTitle.toUpperCase(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            "$tOtpMessage supportforme@wehire.com",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30.0,
          ),
          OtpTextField(
            numberOfFields: 6,
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            onSubmit: (code) {
              print("OTP is => $code");
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(tNext),
            ),
          )
        ],
      ),
    ));
  }
}
