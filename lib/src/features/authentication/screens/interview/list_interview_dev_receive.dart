import 'package:flutter/material.dart';
import 'package:we_hire/src/common_widget/interview_page.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/interview_controller.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class ListInterviewDevReceive extends StatefulWidget {
  const ListInterviewDevReceive({Key? key}) : super(key: key);

  @override
  _ListInterviewDevReceiveState createState() =>
      _ListInterviewDevReceiveState();
  static const String routeName = "/status/interview";
}

class _ListInterviewDevReceiveState extends State<ListInterviewDevReceive>
    with SingleTickerProviderStateMixin {
  var hiringController = InterviewController(RequestRepository());
  String searchQuery = '';

  final List<String> categories = [
    'Waiting',
    'Approved',
    'Rejected',
    'Completed'
  ];

  late TabController _tabController;
  List<String> displayCategories = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _refreshData();
  }

  Future<void> _refreshData() async {
    await hiringController.fetchInterviewList(null);
    setState(() {
      displayCategories = List.from(categories);
    });
  }

  Future<void> _searchInterviews() async {
    List<Interview> searchedInterviews =
        await hiringController.searchInterviewList(
      null,
      searchQuery,
    );

    setState(() {
      displayCategories = searchedInterviews
          .map((interview) => interview.statusString ?? '')
          .toSet()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        title: const Text('Interview'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainHomePage.routeName);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: categories.map((category) => Tab(text: category)).toList(),
          indicatorColor: Colors.white,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                          });
                          _searchInterviews();
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: const TextStyle(
                            color:
                                tBottomNavigation, // Set the label text color
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: tBottomNavigation,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: categories.map((category) {
                  return buildStaticYardList(category);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStaticYardList(String category) {
    return FutureBuilder<List<Interview>>(
      future: hiringController.fetchInterviewList(null),
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

        List<Interview> filteredInterviews = snapshot.data?.where((interview) {
              return interview.statusString == category;
            }).toList() ??
            [];

        return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: filteredInterviews.length,
            itemBuilder: (BuildContext context, int index) {
              Interview interview = filteredInterviews[index];
              bool matchesSearch =
                  interview.title!.toLowerCase().contains(searchQuery);
              if (matchesSearch || searchQuery.isEmpty) {
                return InterviewPageCard(
                  interview: interview,
                );
              } else {
                return Container();
              }
            });
      },
    );
  }
}
