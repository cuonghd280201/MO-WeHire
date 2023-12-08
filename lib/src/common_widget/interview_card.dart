// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';

class InterViewCard extends StatefulWidget {
  final Interview interview;

  const InterViewCard({Key? key, required this.interview}) : super(key: key);

  @override
  _InterViewCardState createState() => _InterViewCardState();
}

class _InterViewCardState extends State<InterViewCard>
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

  // void viewYard() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => YardDetail(
  //         yard: widget.interview,
  //       ),
  //     ),
  //   );
  // }

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
          //    onTap: viewYard,
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
              BorderRadius.circular(25.0), // Adjust the radius as needed
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Text(
                '${widget.interview.interviewCode}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.refresh, color: tBottomNavigation),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${widget.interview.startTime}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.add_task, color: tBottomNavigation),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${widget.interview.endTime}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
