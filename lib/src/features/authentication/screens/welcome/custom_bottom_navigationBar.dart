import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:badges/badges.dart' as badges;

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  CustomBottomNavigationBar(
      {required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    var hiringController = DeveloperController(RequestRepository());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 25,
          offset: const Offset(8, 20),
        )
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black,
          currentIndex: currentIndex,
          onTap: onTabTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FutureBuilder<int>(
                future: hiringController.countNotification(),
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
                      badgeContent:
                          Text('...', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}
