// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/edit_education.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_education_page.dart';

class EducationCard extends StatefulWidget {
  final Education? education;

  const EducationCard({Key? key, required this.education}) : super(key: key);

  @override
  _EducationCardState createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool showFullDescription = false;
  final educationController = DeveloperController(RequestRepository());
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void viewYard() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const EditEducationPage()),
    );
  }

  Widget onImageLoading(context, Widget child, ImageChunkEvent? progress) {
    if (progress == null) return child;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 1;
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: animationController, curve: Curves.easeInToLinear),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: cardWidth,
        child: InkWell(
          onTap: viewYard,
          child: Stack(
            children: <Widget>[
              buildInfoCard(context, cardWidth),
              //buildImageCard(cardWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(context, cardWidth) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        '${widget.education?.majorName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: tBottomNavigation),
                      onPressed: () {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text(
                                  "Are you sure you want to delete this education?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("No",
                                      style:
                                          TextStyle(color: tBottomNavigation)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Call the delete function
                                    try {
                                      final bool success =
                                          await educationController
                                              .deleteEducation(
                                                  context,
                                                  widget
                                                      .education?.educationId);
                                      if (success) {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListEducationPage()),
                                        );
                                        MotionToast.success(
                                          description: const Text(
                                              "Successfully deleted education"),
                                        ).show(context);
                                      } else {
                                        MotionToast.error(
                                          description: const Text(
                                              "Delete education failed"),
                                        ).show(context);
                                      }
                                      // Close the dialog
                                    } catch (e) {
                                      MotionToast.error(
                                        description: const Text(
                                            "Delete education failed"),
                                      ).show(context);
                                    }
                                  },
                                  child: const Text("Yes",
                                      style:
                                          TextStyle(color: tBottomNavigation)),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
                    child: const Text(
                      "School:    ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${widget.education?.schoolName}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    child: const Text(
                      "Start/End Time:    ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${formatDate(widget.education?.startDate)} - ${formatDate(widget.education?.endDate)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                child: const Text(
                  "Description:    ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: tBottomNavigation,
                  ),
                ),
              ),
              Container(
                child: Text(
                  showFullDescription
                      ? '${widget.education?.description}'
                      : (widget.education?.description?.length ?? 0) <= 100
                          ? '${widget.education?.description}'
                          : '${widget.education?.description?.substring(0, 100)}...', // Show the first 100 characters
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              if (widget.education?.description != null &&
                  widget.education!.description!.isNotEmpty &&
                  widget.education!.description!.length > 100)
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
