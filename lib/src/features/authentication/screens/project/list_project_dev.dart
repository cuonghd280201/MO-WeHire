// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/project_controller.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/project/component/project_card.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class ListProjectDev extends StatefulWidget {
  final int? devStatusInProject;

  const ListProjectDev({super.key, this.devStatusInProject});

  @override
  _ListProjectDevState createState() => _ListProjectDevState();
  static const String routeName = "/project";
}

class _ListProjectDevState extends State<ListProjectDev> {
  var projectController = ProjectController(RequestRepository());
  String searchQuery = '';
  List<int> projectListFilter = [8, 9, 10, 11];

  TextEditingController searchController = TextEditingController();
  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
    _searchProjects();
  }

  void _searchProjects() {
    projectController.searchProject(context, null, [8, 9, 10, 11], searchQuery);
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      searchController.clear();
    });
    _searchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        title: const Text('Project'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainHomePage.routeName);
          },
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: greenshede1.withOpacity(0.1),
                  )),
            ],
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Search project...',
                        labelStyle: const TextStyle(
                          color: tBottomNavigation, // Set the label text color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: tBottomNavigation,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildStaticYardList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<Project>>(
      future: searchQuery.isEmpty
          ? projectController.fetchProjectList(context,
              [8, 9, 10, 11]) // Fetch all projects when no search query
          : projectController.searchProject(context, null, [8, 9, 10, 11],
              searchQuery), // Use searched projects
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        }

        List<Project>? filteredList = snapshot.data
            ?.where((project) =>
                project.projectName!.toLowerCase().contains(searchQuery) ||
                project.projectCode!.toLowerCase().contains(searchQuery))
            .toList();

        return Column(
          children: [
            SizedBox(
              height: 600,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= 0 && index < filteredList!.length) {
                    return ProjectCard(project: filteredList[index]);
                  } else {
                    // Handle the case where the index is out of bounds
                    return Center(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/splash_images/interview.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
