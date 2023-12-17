// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';

import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/post_education.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/setting_dev.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/widget_profile/education_card.dart';

class ListEducationPage extends StatefulWidget {
  const ListEducationPage({super.key});

  @override
  _ListEducationPageState createState() => _ListEducationPageState();
  static const String routeName = "/status/interview";
}

class _ListEducationPageState extends State<ListEducationPage> {
  var hiringController = DeveloperController(RequestRepository());

  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, SettingProfileDevPage.routeName);
          },
        ),
        title: const Text('Education'),
        centerTitle: true,
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
                    color: greenshede1.withOpacity(0.1),
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
          // Positioned(
          //   bottom: 10,
          //   right: 10,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const ListEducationPage()));
          //     },
          //     style: ElevatedButton.styleFrom(
          //       shape: const CircleBorder(),
          //       backgroundColor: tBottomNavigation,
          //     ),
          //     child: const Icon(Icons.refresh),
          //   ),
          // ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostEducationPage()));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: tBottomNavigation,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<Education>>(
        future: hiringController.fetchEducationList(context),
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
                height: 1000,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return EducationCard(education: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
