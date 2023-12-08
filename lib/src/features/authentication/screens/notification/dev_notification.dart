// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/notification/widget/notification_card.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class NotificationDevPage extends StatefulWidget {
  const NotificationDevPage({super.key});

  @override
  _NotificationDevPageState createState() => _NotificationDevPageState();
  static const String routeName = "/status/devRejected";
}

class _NotificationDevPageState extends State<NotificationDevPage> {
  var notificationController = DeveloperController(RequestRepository());

  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        title: const Text('Notifications'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainHomePage.routeName);
          },
        ),
        // actions: <Widget>[
        //   IconButton(
        //       onPressed: () async {
        //         SharedPreferences preferences =
        //             await SharedPreferences.getInstance();
        //         await preferences.clear();
        //         Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(builder: (context) => TestLoginScreen()),
        //             (route) => false);
        //       },
        //       icon: Icon(Icons.logout)),
        //],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color:
                        const Color.fromARGB(255, 63, 151, 98).withOpacity(0.1),
                  )),
            ],
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text('List View Status'),
                  const SizedBox(
                    height: 10,
                  ),
                  buildStaticYardList(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10, // Điều chỉnh vị trí dọc của nút
            right: 10, // Điều chỉnh vị trí ngang của nút
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationDevPage()));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: primarygreen, // Màu nền của nút
              ),
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<NotificationDev>>(
        future: notificationController.fetchNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('error'),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 600,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationCard(
                        notificationDev: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
