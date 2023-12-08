import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/change_password.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/edit_dev_profile.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_education_page.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_professtional_experience.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/setting_dev.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreenState createState() => _UserProfileScreenState();
  static const String routeName = "/user";
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? userProfile;
  final developerController = DeveloperController(RequestRepository());
  bool isMenuVisible = false;
  File? _image;
  final picker = ImagePicker();

  Future getImageProfile() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user's profile using DeveloperController
    developerController.fetchUserList().then((user) {
      setState(() {
        userProfile = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile'),
        backgroundColor: tHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, SettingProfileDevPage.routeName);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Height of the Divider
          child: Divider(
            thickness: 0.4,
            color: Colors.grey[200], // Màu của đường kẻ
          ),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                        value: 0, child: Text('Change Password')),
                    const PopupMenuItem<int>(
                        value: 1,
                        child: Row(children: [
                          Icon(
                            Icons.logout,
                            color: tBottomNavigation,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Sign Out'),
                        ])),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: userProfile?.userImage != null
                              ? NetworkImage('${userProfile?.userImage}')
                              : const NetworkImage(
                                  'https://as2.ftcdn.net/v2/jpg/04/70/29/97/1000_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg'),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userProfile?.lastName}'
                          ''
                          ' ${userProfile?.firstName}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${userProfile?.level!.levelName} - ${userProfile?.yearOfExperience} years experience',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.email, // Choose the appropriate email icon
                              color: tBottomNavigation,
                              size: 18, // Adjust the size as needed
                            ),
                            const SizedBox(
                                width:
                                    8), // Add some spacing between the icon and the text
                            Text(
                              '${userProfile?.email}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.phone,
                              color: tBottomNavigation,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${userProfile?.phoneNumber}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.summarize_outlined,
                              color: tBottomNavigation,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${userProfile?.summary}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            userProfile?.genderName == 'Male'
                                ? const Icon(
                                    Icons.male,
                                    color: tBottomNavigation,
                                    size: 18,
                                  )
                                : const Icon(
                                    Icons.female,
                                    color: tBottomNavigation,
                                    size: 18,
                                  ),
                            const SizedBox(width: 8),
                            Text(
                              '${userProfile?.genderName}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.cake_outlined,
                              color: tBottomNavigation,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${userProfile?.dateOfBirth}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.money_off,
                              color: tBottomNavigation,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${userProfile?.averageSalary}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tBottomNavigation, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()),
                    );
                  },
                  child: const Text('Edit Basic Information',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 20, bottom: 20),
              //   child: Divider(
              //     thickness: 1,
              //     color: Colors.grey[200],
              //   ),
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: greenshede1.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: ListTile(
              //     leading: Container(
              //       width: 40,
              //       height: 40,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //       ),
              //       child: const Icon(
              //         Icons.home_work_rounded,
              //         color: tBottomNavigation,
              //       ),
              //     ),
              //     title: Text(
              //       'Education',
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodyMedium
              //           ?.copyWith(fontWeight: FontWeight.bold),
              //     ),
              //     trailing: GestureDetector(
              //       onTap: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //               builder: (context) => ListEducationPage()),
              //         );
              //       },
              //       child: Container(
              //         width: 30,
              //         height: 30,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: const Icon(
              //           Icons.arrow_circle_right_rounded,
              //           color: tBottomNavigation,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: greenshede1.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: ListTile(
              //     leading: Container(
              //       width: 40,
              //       height: 40,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //       ),
              //       child: const Icon(
              //         Icons.work,
              //         color: tBottomNavigation,
              //       ),
              //     ),
              //     title: Text(
              //       'Professional Experience',
              //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //             fontWeight: FontWeight.bold,
              //           ),
              //     ),
              //     trailing: GestureDetector(
              //       onTap: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => ListProfessionalPage(),
              //           ),
              //         );
              //       },
              //       child: Container(
              //         width: 30,
              //         height: 30,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: const Icon(
              //           Icons.arrow_circle_right_rounded,
              //           color: tBottomNavigation,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Divider(
              //     thickness: 1,
              //     color: Colors.blueGrey[200],
              //   ),
              // ),
              Text(
                'Top Skill',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              if (userProfile?.skills != null)
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userProfile!.skills!.length,
                    itemBuilder: (context, index) {
                      final skill = userProfile!.skills![index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: tPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          skill.skillName!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),
              Text(
                ' Type',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              if (userProfile?.types != null)
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userProfile!.types!.length,
                    itemBuilder: (context, index) {
                      final type = userProfile!.types![index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: tPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          type.typeName!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChangePasswordPage()));
        break;
      case 1:
        developerController.revokeToken();
        // SharedPreferences.getInstance().then((preferences) {
        //   preferences.clear();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const TestLoginScreen()),
          (route) => false,
        );
        // });

        break;
    }
  }
}
