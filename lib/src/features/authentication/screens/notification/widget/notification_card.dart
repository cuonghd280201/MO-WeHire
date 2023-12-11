// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:we_hire/main.dart';
import 'package:we_hire/src/common_widget/interview_page_detail.dart';
import 'package:we_hire/src/common_widget/request_page.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';

import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';

class NotificationCard extends StatefulWidget {
  final NotificationDev? notificationDev;

  const NotificationCard({Key? key, required this.notificationDev})
      : super(key: key);

  @override
  _YardSimpleCardState createState() => _YardSimpleCardState();
}

class _YardSimpleCardState extends State<NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final notificationController = DeveloperController(RequestRepository());

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
    notificationController
        .readNotification(widget.notificationDev?.notificationId)
        .then((success) {
      // Check if the notification was successfully read
      if (success != null && success) {
        if (widget.notificationDev?.routeId != null &&
            widget.notificationDev?.notificationTypeName != null) {
          if (widget.notificationDev?.notificationTypeName ==
              'Hiring Request') {
            Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                builder: (context) =>
                    RequestPageDetail(widget.notificationDev?.routeId),
              ),
            );
          } else if (widget.notificationDev?.notificationTypeName ==
              'Interview') {
            Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                builder: (context) =>
                    InterviewPageDetail(widget.notificationDev?.routeId),
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 1;
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: animationController, curve: Curves.easeInToLinear),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 15),
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
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        '${widget.notificationDev?.notificationTypeName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.notificationDev?.isRead == false
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Content:",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: tBottomNavigation,
                ),
              ),
              Text(
                '${widget.notificationDev?.content}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.notificationDev?.createdTime}',
                style: const TextStyle(
                  fontSize: 15,
                  color: headerDashboard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
