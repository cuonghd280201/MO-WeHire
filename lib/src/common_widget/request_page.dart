// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/main.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/request_controller.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class RequestPageDetail extends StatefulWidget {
  static const String routeName = "/requestDetail";

  final int? requestId;

  const RequestPageDetail(this.requestId, {Key? key}) : super(key: key);

  // final HiringNew? yard;

  // YardDetail({Key? key, required this.yard}) : super(key: key);

  @override
  _YardDetailState createState() => _YardDetailState();
}

class _YardDetailState extends State<RequestPageDetail> {
  final hiringController = RequestController(RequestRepository());
  HiringNew? hiringNew;
  @override
  bool mounted = false;

  @override
  void initState() {
    super.initState();
    mounted = true;
    fetchData();
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  Future<void> fetchData() async {
    final hiringnew =
        await hiringController.fetchHiringById(context, widget.requestId);
    if (mounted) {
      setState(() {
        hiringNew = hiringnew;
      });
    }
  }

  bool showFullDescription = false;
  HtmlUnescape htmlUnescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        title: const Text('Detail Request'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, ListViewPage.routeName);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: tBottomNavigation,
                              ),
                              child: const Icon(
                                Icons.add_task,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${hiringNew?.requestCode}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: tBottomNavigation,
                                borderRadius: BorderRadius.circular(
                                    20), // Optional: Set border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    10.0), // Adjust the padding as needed
                                child: Text(
                                  '${hiringNew?.statusString}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 249, 248, 248),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Job Title",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${hiringNew?.jobTitle}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${hiringNew?.duration}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Level",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            '${hiringNew?.levelRequireName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Salary PerDev",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${hiringNew?.salaryPerDev}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Type Requirement",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${hiringNew?.typeRequireName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: const Text(
                            "Type Employment",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: tBottomNavigation,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${hiringNew?.employmentTypeName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Skill',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (hiringNew?.skillRequireStrings != null)
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hiringNew?.skillRequireStrings!.length,
                          itemBuilder: (context, index) {
                            final skill =
                                hiringNew?.skillRequireStrings![index];
                            return Container(
                              margin: const EdgeInsets.only(right: 8, left: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: tPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                skill!,
                                style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ) ??
                                    const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Job Description',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set width to match the screen width
                      padding: EdgeInsets.all(
                          5.0), // Add padding to the outer container

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Specify your border color
                          width: 1.0, // Specify your border width
                        ),
                        borderRadius: BorderRadius.circular(
                            4), // Adjust the radius as needed
                      ),
                      child: Html(
                        data: showFullDescription
                            ? '${htmlUnescape.convert(hiringNew?.jobDescription ?? '')}'
                            : (hiringNew?.jobDescription?.length ?? 0) <= 100
                                ? '${htmlUnescape.convert(hiringNew?.jobDescription ?? '')}'
                                : '${htmlUnescape.convert(hiringNew?.jobDescription?.substring(0, 100) ?? '')}...', // Show the first 100 characters
                        style: {
                          'body': Style(
                            fontSize: FontSize
                                .medium, // or FontSize.small, FontSize.large, etc.
                          ),
                        },
                      ),
                    ),
                    if (hiringNew?.jobDescription != null &&
                        hiringNew!.jobDescription!.isNotEmpty &&
                        hiringNew!.jobDescription!.length > 100)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showFullDescription = !showFullDescription;
                          });
                        },
                        child: Text(
                          showFullDescription ? 'Read Less' : 'Read More',
                          style: const TextStyle(
                            color: tBottomNavigation,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null) {
      return '';
    }
    final dateTime = DateTime.parse(date);
    final formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
