// ignore_for_file: avoid_unnecessary_containers, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';

import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/edit_professionalExperience.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_professtional_experience.dart';

class ProfessionalCard extends StatefulWidget {
  final ProfessionalExperience? professionalExperience;

  const ProfessionalCard({Key? key, required this.professionalExperience})
      : super(key: key);

  @override
  _ProfessionalCardState createState() => _ProfessionalCardState();
}

class _ProfessionalCardState extends State<ProfessionalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final professionalController = DeveloperController(RequestRepository());
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
      MaterialPageRoute(builder: (context) => const EditProfessionalPage()),
    );
    // showModalBottomSheet(
    //     context: context, builder: (context) => const EditProfessionalPage());
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
                        '${widget.professionalExperience?.jobName}',
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
                                  "Are you sure you want to delete this professional experience?"),
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
                                          await professionalController
                                              .deleteProfesstionalExperience(
                                                  widget.professionalExperience
                                                      ?.professionalExperienceId);
                                      if (success) {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListProfessionalPage()),
                                        );
                                        Fluttertoast.showToast(
                                          msg:
                                              "Deleted Professional Successfully.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.greenAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Failed to delete professcional.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          textColor: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 16.0,
                                        );
                                      }
                                      // Close the dialog
                                    } catch (e) {
                                      Fluttertoast.showToast(
                                        msg: "Failed to delete professcional.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 0, 0),
                                        textColor:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 16.0,
                                      );
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
                      '${widget.professionalExperience?.companyName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                      '${formatDate(widget.professionalExperience?.startDate)} - ${formatDate(widget.professionalExperience?.endDate)}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
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
                      '${widget.professionalExperience?.description}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
