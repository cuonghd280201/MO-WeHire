// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/interview/list_interview_dev_receive.dart';
import 'package:we_hire/src/features/authentication/screens/list_request_by_status/list_view_dev_interview.dart';
import 'package:we_hire/main.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/project/list_project_dev.dart';

import '../../constants/colors.dart';

class CategoriesWidget extends StatefulWidget {
  static const String routeName = "/home";

  const CategoriesWidget({super.key});

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  User? userProfile;
  final developerController = DeveloperController(RequestRepository());
  late bool _isDisposed; // Add this variable

  @override
  void initState() {
    super.initState();
    _isDisposed = false; // Initialize the variable

    // Fetch the user's profile using DeveloperController
    developerController.fetchUserList(context).then((user) {
      if (!_isDisposed) {
        setState(() {
          userProfile = user;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true; // Set the flag to true when the widget is disposed
    super.dispose();
  }

  List status = [
    "Request",
    "Project",
    "Interview",
  ];

  List<Color> listColors = [
    const Color(0xFFFFCDD2),
    const Color(0xFFB3E5FC),
    const Color(0xFFFAF0DA),
  ];

  List<Icon> listIcon = [
    const Icon(
      Icons.refresh,
      color: Colors.redAccent,
      size: 30,
    ),
    const Icon(
      Icons.badge,
      color: Colors.blueAccent,
      size: 30,
    ),
    const Icon(
      Icons.calendar_month_sharp,
      color: Colors.orangeAccent,
      size: 30,
    ),
  ];

  int currentIndex = 0;
  final screens = [
    const CategoriesWidget(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreenshede,
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
                color: tHeader,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.dashboard,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () async {
                      bool tokenRevoked =
                          await developerController.revokeToken(context);
                      if (tokenRevoked) {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const TestLoginScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        print("Token revocation failed.");
                      }
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 15),
                child: Text(
                  "Welcome, "
                  ' ${userProfile?.firstName}'
                  ' '
                  '${userProfile?.lastName}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 5, bottom: 20),
              //   width: MediaQuery.of(context).size.width,
              //   height: 40,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: "Search hiring request....",
              //         hintStyle: TextStyle(
              //           color: Colors.black.withOpacity(0.5),
              //         ),
              //         prefixIcon: const Icon(
              //           Icons.search,
              //           size: 25,
              //         )),
              //   ),
              // )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dash Board",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (MediaQuery.of(context).size.height - 50 - 25) /
                          (4 * 150),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: status.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (status[index] == "Request") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListViewPage()));
                      } else if (status[index] == "Project") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListProjectDev()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ListInterviewDevReceive()));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: listColors[index],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listIcon[index],
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            status[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ]),
          )
        ],
      ),
    );
  }
}
