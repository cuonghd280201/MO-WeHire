import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/controllers/interview_controller.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/interview/list_interview_dev_receive.dart';
import 'package:motion_toast/motion_toast.dart';

class InterviewPageDetail extends StatefulWidget {
  final int? interviewId;

  const InterviewPageDetail(this.interviewId, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InterviewPageDetailState createState() => _InterviewPageDetailState();
}

class _InterviewPageDetailState extends State<InterviewPageDetail> {
  final interviewController = DeveloperController(RequestRepository());
  final interview = InterviewController(RequestRepository());

  Interview? interviewList;

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
    mounted = true;
    super.dispose();
  }

  Future<void> fetchData() async {
    final interviewFetch = await interviewController.fetchInterviewById(
        context, widget.interviewId);
    if (mounted) {
      setState(() {
        interviewList = interviewFetch;
      });
    }
  }

  TextEditingController reasonController = TextEditingController(text: '');

  bool showFullDescription = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 129, 84),
        title: const Text('Interview Detail Page'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, ListInterviewDevReceive.routeName);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(35),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 1000,
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
                                Icons.video_file_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${interviewList?.title}',
                              style: const TextStyle(
                                fontSize: 20,
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
                                color: () {
                                  switch (interviewList?.statusString) {
                                    case 'Approved':
                                      return tBottomNavigation;
                                    case 'Waiting Approval':
                                      return Colors.orangeAccent;
                                    case 'Completed':
                                      return Colors.blueAccent;
                                    case 'Cancelled':
                                      return Colors.black;
                                    default:
                                      return Colors.grey;
                                  }
                                }(),
                                borderRadius: BorderRadius.circular(
                                    20), // Optional: Set border radius
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    10.0), // Adjust the padding as needed
                                child: Text(
                                  '${interviewList?.statusString}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Title",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${interviewList?.title}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Date of Interview",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${interviewList?.dateOfInterview}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Start - End Time",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${interviewList?.startTime} - ${interviewList?.endTime}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Number Of Interview",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${interviewList?.numOfInterviewee}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Post Time",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            '${interviewList?.postedTime}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
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
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      showFullDescription
                          ? '${interviewList?.description}'
                          : (interviewList?.description?.length ?? 0) <= 100
                              ? '${interviewList?.description}'
                              : '${interviewList?.description?.substring(0, 100)}...', // Show the first 100 characters
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic, color: Colors.black),
                    ),
                    if (interviewList?.description != null &&
                        interviewList!.description!.isNotEmpty &&
                        interviewList!.description!.length > 100)
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
                    const SizedBox(
                      height: 20,
                    ),
                    if (interviewList?.statusString == "Approved")
                      const SizedBox(
                        child: Text(
                          "Link Meet",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    SizedBox(
                      child: Text(
                        '${interviewList?.meetingUrl}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (interviewList?.statusString == "Waiting Approval")
            Visibility(
              visible: true, // Adjust the condition as needed
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white, // Chọn màu nền cho Row
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).primaryColor,
                          backgroundColor: tHeader,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize:
                              const Size(150, 40), // Adjust the width as needed
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Do you want ensure approved this request?',
                                  style: TextStyle(color: tBottomNavigation),
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'No',
                                      style:
                                          TextStyle(color: tBottomNavigation),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style:
                                          TextStyle(color: tBottomNavigation),
                                    ),
                                    onPressed: () async {
                                      final approvalSuccess =
                                          await interview.approvedInterview(
                                              context,
                                              interviewList!.interviewId);

                                      if (approvalSuccess) {
                                        final updatedInterview =
                                            await interviewController
                                                .fetchInterviewById(context,
                                                    widget.interviewId);

                                        setState(() {
                                          interviewList = updatedInterview;
                                        });

                                        Navigator.of(context).pop();
                                        // ignore: use_build_context_synchronously
                                        MotionToast.success(
                                          description: const Text(
                                              "Successful interview approval"),
                                        ).show(context);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 8),
                            Text(
                              'Approved ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).primaryColor,
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Do you want ensure reject this request?',
                                  style: TextStyle(color: tBottomNavigation),
                                ),
                                content: TextFormField(
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    labelText: 'Reason Reject',
                                    prefixIcon: Icon(Icons.read_more_sharp),
                                  ),
                                  controller: reasonController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid last name.';
                                    }
                                    return null; // Return null if the value is valid.
                                  },
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'No',
                                      style:
                                          TextStyle(color: tBottomNavigation),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style:
                                          TextStyle(color: tBottomNavigation),
                                    ),
                                    onPressed: () async {
                                      String reason = reasonController.text;
                                      final rejectSuccess =
                                          await interview.rejectInterview(
                                              context,
                                              interviewList!.interviewId,
                                              reason);

                                      if (rejectSuccess) {
                                        final updatedInterview =
                                            await interviewController
                                                .fetchInterviewById(context,
                                                    widget.interviewId);

                                        setState(() {
                                          interviewList = updatedInterview;
                                        });
                                        Navigator.of(context).pop();
                                        MotionToast.success(
                                          description: const Text(
                                              "Successful interview reject"),
                                        ).show(context);
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(width: 8),
                            Text(
                              'Rejected',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
