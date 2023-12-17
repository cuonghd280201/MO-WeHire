// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/dev_profile.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_education_page.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_professtional_experience.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class SettingProfileDevPage extends StatefulWidget {
  const SettingProfileDevPage({super.key});

  @override
  State<SettingProfileDevPage> createState() => _SettingProfileDevPageState();
  static const String routeName = "/setting";
}

class _SettingProfileDevPageState extends State<SettingProfileDevPage> {
  User? userProfile;
  final developerController = DeveloperController(RequestRepository());
  bool isMenuVisible = false;
  @override
  void initState() {
    super.initState();
    // Fetch the user's profile using DeveloperController
    developerController.fetchUserList(context).then((user) {
      if (mounted) {
        setState(() {
          userProfile = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tBottomNavigation,
        centerTitle: true,
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainHomePage.routeName);
          },
        ),
        // actions: [ElevatedButton(onPressed: () {}, child: Text("Edit"))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: tBottomNavigation.withOpacity(0.5), width: 2.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: userProfile?.userImage != null
                          ? NetworkImage('${userProfile?.userImage}')
                          : const NetworkImage(
                              'https://as2.ftcdn.net/v2/jpg/04/70/29/97/1000_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg'),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Coding With '
                '${userProfile?.firstName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '${userProfile?.email}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // const Icon(Icons.check_circle_outline, color: tBottomNavigation),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => (const UserProfileScreen())),
                  );
                },
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Set the desired background color
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                              12), // Set the desired border radius
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.withOpacity(
                                          0.1), // Set the desired color
                                      borderRadius: BorderRadius.circular(
                                          8), // Set the desired border radius
                                    ),
                                    child: const Icon(
                                      Icons.person_2_rounded,
                                      color: Colors
                                          .deepPurple, // Set the icon color to white or another contrasting color
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text("My Account"),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                              color: tBottomNavigation,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    (const ListEducationPage())),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set the desired background color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                12), // Set the desired border radius
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(
                                            0.1), // Set the desired color
                                        borderRadius: BorderRadius.circular(
                                            8), // Set the desired border radius
                                      ),
                                      child: const Icon(
                                        Icons.house_rounded,
                                        color: Colors
                                            .blue, // Set the icon color to white or another contrasting color
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text("Education"),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                                color: tBottomNavigation,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    (const ListProfessionalPage())),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set the desired background color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                12), // Set the desired border radius
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.pink.withOpacity(
                                            0.1), // Set the desired color
                                        borderRadius: BorderRadius.circular(
                                            8), // Set the desired border radius
                                      ),
                                      child: const Icon(
                                        Icons.badge_rounded,
                                        color: Colors
                                            .pink, // Set the icon color to white or another contrasting color
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text("Professional Experience"),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                                color: tBottomNavigation,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TestLoginScreen()),
                              (route) => false);
                          MotionToast.success(
                            description: const Text("Logout in successfully"),
                          ).show(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set the desired background color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                12), // Set the desired border radius
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bool tokenRevoked = await developerController
                                      .revokeToken(context);

                                  if (tokenRevoked) {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    await preferences.clear();

                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TestLoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    print("Token revocation failed.");
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(
                                              0.1), // Set the desired color
                                          borderRadius: BorderRadius.circular(
                                              8), // Set the desired border radius
                                        ),
                                        child: const Icon(
                                          Icons.logout_rounded,
                                          color: Colors
                                              .orange, // Set the icon color to white or another contrasting color
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text("LogOut"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
