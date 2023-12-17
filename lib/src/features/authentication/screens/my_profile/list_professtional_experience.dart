// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/post_professional.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/setting_dev.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/widget_profile/professional_card.dart';

class ListProfessionalPage extends StatefulWidget {
  const ListProfessionalPage({super.key});

  @override
  _ListProfessionalPageState createState() => _ListProfessionalPageState();
  static const String routeName = "/status/interview";
}

class _ListProfessionalPageState extends State<ListProfessionalPage> {
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
        title: const Text('Professional Experience'),
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
          //               builder: (context) => const ListProfessionalPage()));
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
                        builder: (context) => const PostProfessionalPage()));
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
    return FutureBuilder<List<ProfessionalExperience>>(
        future: hiringController.fetchProfessionalExperience(context),
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
                    return ProfessionalCard(
                        professionalExperience: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
