// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/models/splash_model.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentIndex = 0;

  List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        "assets/images/splash_images/splash1.png",
        "Find Jobs Easily",
        "Helps you discover ideal job opportunities quickly and conveniently"),
    AllinOnboardModel(
        "assets/images/splash_images/splash2.png",
        "Connect Company and Devlopers",
        "Be a trusted bridge between job seekers and those who can introduce job opportunities."),
    AllinOnboardModel(
        "assets/images/splash_images/splash3.png",
        "New Job Opportunities Right Here",
        "We continuously update our job listings to ensure you don't miss out on any opportunities"),
  ];
  void goToPreviousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void goToNextPage() {
    if (currentIndex < allinonboardlist.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "We-Hire",
          style: TextStyle(color: primarygreen),
        ),
        backgroundColor: lightgreenshede,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: allinonboardlist.length,
            itemBuilder: (context, index) {
              return PageBuilderWidget(
                  title: allinonboardlist[index].titlestr,
                  description: allinonboardlist[index].description,
                  imgurl: allinonboardlist[index].imgStr);
            },
            controller: PageController(initialPage: currentIndex),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allinonboardlist.length,
                (index) => buildDot(index: index),
              ),
            ),
          ),
          currentIndex < allinonboardlist.length - 1
              ? Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          goToPreviousPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightgreenshede1,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                        ),
                        child: Text(
                          "Previous",
                          style: TextStyle(fontSize: 18, color: primarygreen),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          goToNextPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tBottomNavigation,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0))),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 18, color: primarygreen),
                        ),
                      )
                    ],
                  ),
                )
              : Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.36,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TestLoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightgreenshede1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, color: primarygreen),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primarygreen : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  String title;
  String description;
  String imgurl;
  PageBuilderWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.imgurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(imgurl),
          ),
          const SizedBox(
            height: 20,
          ),
          // Title Text
          Text(title,
              style: TextStyle(
                  color: primarygreen,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 20,
          ),
          // Description
          Text(description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: primarygreen,
                fontSize: 14,
              ))
        ],
      ),
    );
  }
}
