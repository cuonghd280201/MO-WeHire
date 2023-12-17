// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/dev_profile.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var hiringController = DeveloperController(RequestRepository());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return ScaffoldMessenger(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Change Password',
            ),
            backgroundColor: tHeader,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, UserProfileScreen.routeName);
              },
            ),
          ),
          backgroundColor: const Color(0xFFffffff),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                key: formKey, //key for form
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),
                    Text(
                      "Here to Get",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Change Password Now !",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: currentPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your current password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: tBottomNavigation)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter correct name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: newPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your new password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: tBottomNavigation)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter correct name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your confirm password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: tBottomNavigation)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter correct name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign Up',
                          style:
                              TextStyle(fontSize: 22, color: Color(0x0ff363f9)),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                const snackBar =
                                    SnackBar(content: Text('Submit Form'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                // Fluttertoast.showToast(
                                //   msg:
                                //       "Mật khẩu mới và xác nhận mật khẩu không trùng khớp.",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor:
                                //       Color.fromARGB(255, 255, 0, 0),
                                //   textColor: Color.fromARGB(255, 0, 0, 0),
                                //   fontSize: 16.0,
                                // );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                          "Mật khẩu mới và xác nhận mật khẩu không trùng khớp."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Đóng"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                            String current = currentPasswordController.text;
                            String newPassword = newPasswordController.text;
                            String confirmPassword =
                                confirmPasswordController.text;

                            try {
                              final bool success =
                                  await hiringController.updatePassword(context,
                                      current, newPassword, confirmPassword);

                              if (success) {
                                Fluttertoast.showToast(
                                  msg: "Education Posted Successfully.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 255, 115),
                                  textColor: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16.0,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfileScreen()),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Failed to post education.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 0, 0),
                                  textColor: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16.0,
                                );
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "Thông tin nhập chưa chính xác",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: tPrimaryColor,
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                tBottomNavigation),
                          ),
                          child: const Text('Save'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
