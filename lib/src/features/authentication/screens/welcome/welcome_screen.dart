import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/sizes.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

import '../../../../constants/button.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image(
            image: AssetImage(tWelcomeScreenImage),
            height: height * 0.6,
          ),
          Text(tWelcomeTitle, style: Theme.of(context).textTheme.headlineLarge),
          Text(
            tWelcomeSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestLoginScreen()),
                        );
                      },
                      style: buttomPrimary,
                      child: Text(tLogin.toUpperCase()))),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainHomePage()),
                        );
                      },
                      style: buttomPrimary,
                      child: Text(tOut.toUpperCase()))),
            ],
          )
        ]),
      ),
    );
  }
}
