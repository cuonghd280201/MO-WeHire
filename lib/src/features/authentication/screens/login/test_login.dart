// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/constants/image_strings.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class TestLoginScreen extends StatefulWidget {
  const TestLoginScreen({super.key});

  @override
  State<TestLoginScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<TestLoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool passToggle = true;
  var signIncontroller = DeveloperController(RequestRepository());

  @override
  void initState() {
    super.initState();
    // Fetch the user's profile using DeveloperController
    signIncontroller.fetchEducationList().then((education) {
      setState(() {
        education = education;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleLoginFormSubmit(String email, String password) async {
      try {
        print("checkin handleLoginForm");
        await signIncontroller.SignIn(email, password);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainHomePage(),
          ),
        );
      } catch (error) {
        print("Login failed with error: $error");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Email or Password Not Correct"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(tWelcomeScreenImage)),
          ],
        ),
        Form(
          key: _formfield,
          child: Column(children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: tBottomNavigation,
                  ),
                  labelText: 'E-Mail',
                  hintText: '@gmail.com',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: tBottomNavigation),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: tBottomNavigation)),
                  contentPadding: EdgeInsets.only(top: 15)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter email";
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "Please enter a valid email address";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: passToggle,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.password_rounded,
                  color: tBottomNavigation,
                ),
                labelText: 'Password',
                suffix: InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                    passToggle ? Icons.visibility : Icons.visibility_off,
                    color: headerDashboard,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: tBottomNavigation),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: tBottomNavigation)),
                contentPadding: const EdgeInsets.only(top: 15),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter password";
                }
                // bool passwordvalid =
                //     RegExp(r'^(?=.*[A-Z])(?=.*\d)').hasMatch(value);
                // if (!passwordvalid) {
                //   return "Capital letters and numbers";
                // }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // Row(children: [
            //   Row(
            //     children: [
            //       Checkbox(value: true, onChanged: (value) {}),
            //       const Text('Remember ME'),
            //     ],
            //   ),
            //   TextButton(
            //       onPressed: () {}, child: const Text("Forget Password")),
            // ]),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: rememberMe,
            //       onChanged: (value) {
            //         setState(() {
            //           rememberMe = value ?? false;
            //         });
            //       },
            //     ),
            //     Text('Remember Me'),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formfield.currentState!.validate()) {
                    print("Success");
                    handleLoginFormSubmit(
                        emailController.text, passwordController.text);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      tBottomNavigation), // Đổi màu ở đây
                ),
                child: const Text('Login'),
              ),
            ),
          ]),
        ),
      ]),
    )));
  }
}
