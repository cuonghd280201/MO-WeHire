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
        parent: animationController,
        curve: Curves.easeInToLinear,
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 8, left: 8),
        width: cardWidth,
        child: InkWell(
          onTap: viewYard,
          child: Stack(
            children: <Widget>[
              buildInfoCard(context, cardWidth),
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
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: cardWidth,
            child: Row(
              children: <Widget>[
                Container(
                  width: 5,
                  height: 70,
                  decoration: BoxDecoration(
                    color: () {
                      switch (widget.interview?.statusString) {
                        case 'Approved':
                          return tBottomNavigation;
                        case 'Waiting Approval':
                          return Colors.orangeAccent;
                        case 'Completed':
                          return Colors.blueAccent;
                        default:
                          return Colors.grey;
                      }
                    }(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.loose,
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
                                color: () {
                                  switch (widget.interview?.statusString) {
                                    case 'Approved':
                                      return tBottomNavigation;
                                    case 'Waiting Approval':
                                      return Colors
                                          .orangeAccent; // Change this to the desired color
                                    case 'Completed':
                                      return Colors.blueAccent;
                                    default:
                                      return Colors.grey;
                                  }
                                }(),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${widget.interview?.statusString}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            width: cardWidth / 3,
                            child: const Text(
                              "Date Of Interview: ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth / 3,
                            child: Text(
                              '${widget.interview?.dateOfInterviewMMM}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: cardWidth / 3,
                            child: const Text(
                              "Start- End Time:",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: cardWidth / 3,
                            child: Text(
                              '${widget.interview?.startTime} - ${widget.interview?.endTime}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
