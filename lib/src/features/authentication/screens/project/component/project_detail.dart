import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/pay_slip_controller.dart';
import 'package:we_hire/src/features/authentication/controllers/project_controller.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/pay_slip/component_pay_slip/pay_slip_card.dart';
import 'package:we_hire/src/features/authentication/screens/project/list_project_dev.dart';

class ProjectPageDetail extends StatefulWidget {
  static const String routeName = "/projectDetail";

  final int? projectId;

  const ProjectPageDetail(this.projectId, {Key? key}) : super(key: key);

  @override
  _ProjectPageDetailState createState() => _ProjectPageDetailState();
}

class _ProjectPageDetailState extends State<ProjectPageDetail> {
  final ProjectController _projectController =
      ProjectController(RequestRepository());
  final paySlipControler = PaySlipController(RequestRepository());

  late PageController _pageController;
  int _currentPageIndex = 0;
  Project? projectNew;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize _pageController here
    fetchData();
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Dispose of _pageController when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final project =
          await _projectController.fetchProjectById(context, widget.projectId);
      if (mounted) {
        setState(() {
          projectNew = project;
        });
      }
    } catch (error) {
      // Handle error appropriately
      print("Error fetching project details: $error");
    }
  }

  bool _showFullDescription = false;
  final HtmlUnescape _htmlUnescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: tBottomNavigation,
          title: const Text('Project Page'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, ListProjectDev.routeName);
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description),
                    Text('Details'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money),
                    Text('PaySlip'),
                  ],
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            buildProjectDetailPage(),
            buildPaySlipListPage(),
          ],
        ),
      ),
    );
  }

  Widget buildProjectDetailPage() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                borderRadius: BorderRadius.circular(5),
                                color: tBottomNavigation,
                              ),
                              child: const Icon(
                                Icons.assignment,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${projectNew?.projectCode}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: projectNew?.statusString == 'In process'
                                ? Colors.green
                                : projectNew?.statusString == 'Closing process'
                                    ? Colors.grey
                                    : Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${projectNew?.statusString}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 249, 248, 248),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Project Name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.projectName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Project Type Name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.projectTypeName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Post Time",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.postedTime}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Company Name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.companyName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Start Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.startDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "End Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${projectNew?.endDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Job Description',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Html(
                        data: _showFullDescription
                            ? '${_htmlUnescape.convert(projectNew?.description ?? '')}'
                            : (projectNew?.description?.length ?? 0) <= 50
                                ? '${_htmlUnescape.convert(projectNew?.description ?? '')}'
                                : '${_htmlUnescape.convert(projectNew?.description?.substring(0, 50) ?? '')}...', // Show the first 50 characters
                        style: {
                          'body': Style(
                            fontSize: FontSize
                                .medium, // or FontSize.small, FontSize.large, etc.
                          ),
                        },
                      ),
                    ),
                    if (projectNew?.description != null &&
                        projectNew!.description!.isNotEmpty &&
                        projectNew!.description!.length > 50)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showFullDescription = !_showFullDescription;
                          });
                        },
                        child: Text(
                          _showFullDescription ? 'Read Less' : 'Read More',
                          style: const TextStyle(
                            color: tBottomNavigation,
                          ),
                        ),
                      ),
                  ],
                ),
                // ... (rest of the UI)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaySlipListPage() {
    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 5,
              ),
              buildStaticYardList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<PaySlip>>(
      future: paySlipControler.fetchPaySlipList(context, widget.projectId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 800,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return PayCard(paySlip: snapshot.data?[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
