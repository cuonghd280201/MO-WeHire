// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/project_controller.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class ProjectPageDetail extends StatefulWidget {
  static const String routeName = "/projectDetail";

  final int? projectId;

  const ProjectPageDetail(this.projectId, {Key? key}) : super(key: key);

  @override
  _ProjectPageDetailState createState() => _ProjectPageDetailState();
}

class _ProjectPageDetailState extends State<ProjectPageDetail> {
  final projectController = ProjectController(RequestRepository());
  Project? projectNew;
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
    final project = await projectController.fetchProjectById(widget.projectId);
    if (mounted) {
      setState(() {
        projectNew = project;
      });
    }
  }

  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                Icons.assignment,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${projectNew?.projectCode}',
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
                                  '${projectNew?.devStatusInProject}',
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
                            "Project Name",
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
                            '${projectNew?.projectName}',
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
                            "Project Type Name",
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
                            '${projectNew?.projectTypeName}',
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
                            "Post Time",
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
                            '${projectNew?.postedTime}',
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
                            "Company Name",
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
                            '${projectNew?.companyName}',
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
                            "Start Date",
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
                            '${projectNew?.startDate}',
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
                            "End Date",
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
                            '${projectNew?.endDate}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                    Text(
                      showFullDescription
                          ? '${projectNew?.description}'
                          : (projectNew?.description?.length ?? 0) <= 100
                              ? '${projectNew?.description}'
                              : '${projectNew?.description?.substring(0, 100)}...', // Show the first 100 characters
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (projectNew?.description != null &&
                        projectNew!.description!.isNotEmpty &&
                        projectNew!.description!.length > 100)
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
