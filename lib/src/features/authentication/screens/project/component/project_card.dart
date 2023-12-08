// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/screens/project/component/project_detail.dart';

class ProjectCard extends StatefulWidget {
  final Project? project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
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
    showModalBottomSheet(
      context: context,
      builder: (context) => ProjectPageDetail(
        widget.project!.projectId,
        key: Key('${widget.project?.projectId}'),
      ),
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
              BorderRadius.circular(10.0), // Adjust the radius as needed
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
                        '${widget.project?.projectCode}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: greenshede0,
                        border: Border.all(
                            color: grayshade), // Add a border around duration
                        borderRadius: BorderRadius.circular(
                            8.0), // Add border radius if desired
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.project?.startDate}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 249, 246, 246),
                          ),
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
                      "Project Name :",
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
                      '${widget.project?.projectName}',
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      "Company Name :",
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
                      '${widget.project?.companyName}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Text(
                      "Posted Time :",
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
                      '${widget.project?.postedTime}',
                      style: Theme.of(context).textTheme.bodyLarge,
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
