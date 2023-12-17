// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';

import 'package:we_hire/src/features/authentication/screens/my_profile/setting_dev.dart';
import 'package:we_hire/src/features/authentication/screens/notification/dev_notification.dart';
import 'package:badges/badges.dart' as badges;
import 'package:we_hire/src/features/authentication/screens/project/list_project_dev.dart';

import '../../../../common_widget/from_home_widget/form_category_widget.dart';

class MainHomePage extends StatefulWidget {
  final NotificationDev? notificationDev;

  static const String routeName = "/home";

  const MainHomePage({super.key, this.notificationDev});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var hiringController = DeveloperController(RequestRepository());

  int currentIndex = 0;
  final screens = [
    const CategoriesWidget(),
    const NotificationDevPage(),
    const SettingProfileDevPage(),
  ];

  @override
  Widget build(BuildContext context) {
    hiringController.unNewNotification(context);
    return Scaffold(
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 25,
                offset: const Offset(8, 20))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.black,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                  if (index == 1) {
                    hiringController.unNewNotification(context);
                  }
                });
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: FutureBuilder<int>(
                    future: hiringController.countNotification(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return badges.Badge(
                          badgeContent: Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: const Icon(
                            Icons.notifications_active_rounded,
                          ),
                        );
                      } else {
                        return const badges.Badge(
                          badgeContent: Text('...',
                              style: TextStyle(color: Colors.white)),
                          child: Icon(
                            Icons.notification_add_outlined,
                          ),
                        );
                      }
                    },
                  ),
                  label: "Notification",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.auto_awesome_mosaic,
                  ),
                  label: "Profile",
                ),
              ],
            ),
          )),
      body: screens[currentIndex],
    );
  }
}
