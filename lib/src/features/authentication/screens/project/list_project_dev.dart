// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/project_controller.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/project/component/project_card.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';

class ListProjectDev extends StatefulWidget {
  const ListProjectDev({super.key});

  @override
  _ListProjectDevState createState() => _ListProjectDevState();
  static const String routeName = "/project";
}

class _ListProjectDevState extends State<ListProjectDev> {
  var projectController = ProjectController(RequestRepository());
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
    _searchProjects();
  }

  void _searchProjects() {
    projectController.searchProject(null, '1', searchQuery);
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 50,
                    child: TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        labelText: 'Search',
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
                          borderRadius: BorderRadius.circular(8),
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
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListProjectDev()));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: tBottomNavigation,
              ),
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<Project>>(
      future: searchQuery.isEmpty
          ? projectController
              .fetchProjectList('1') // Fetch all projects when no search query
          : projectController.searchProject(
              null, '1', searchQuery), // Use searched projects
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

        List<Project> projectsToDisplay =
            searchQuery.isEmpty ? snapshot.data ?? [] : snapshot.data ?? [];

        return Column(
          children: [
            SizedBox(
              height: 600,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: projectsToDisplay.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProjectCard(project: projectsToDisplay[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
