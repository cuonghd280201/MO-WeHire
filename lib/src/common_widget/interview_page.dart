// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/common_widget/interview_page_detail.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';

class InterviewPageCard extends StatefulWidget {
  final Interview? interview;

  const InterviewPageCard({Key? key, required this.interview})
      : super(key: key);

  @override
  _InterviewPageState createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

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
      MaterialPageRoute(
        builder: (context) => InterviewPageDetail(
          widget.interview!.interviewId,
          key: Key('${widget.interview?.interviewId}'),
        ),
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
        margin: const EdgeInsets.only(right: 10, left: 10),
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
              BorderRadius.circular(12.0), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${widget.interview?.title}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: tPrimaryColor,
                        border: Border.all(
                            color:
                                tPrimaryColor), // Add a border around duration
                        borderRadius: BorderRadius.circular(
                            8.0), // Add border radius if desired
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.interview?.statusString}',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Text(
                      "Date Of Interview",
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
                      '${widget.interview?.dateOfInterview}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Text(
                      "Start- End Time:",
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
                      '${widget.interview?.startTime} - ${widget.interview?.endTime}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width / 3,
              //       child: Text(
              //         "Type Employment :",
              //         style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //           color: tBottomNavigation,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width / 3,
              //       child: Text(
              //         '${widget.interview?.statusString}',
              //         style: TextStyle(
              //           fontSize: 15,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
