// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, equal_keys_in_map

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:we_hire/firebase_api.dart';
import 'package:we_hire/src/common_widget/request_page.dart';
import 'package:we_hire/src/features/authentication/screens/interview/list_interview_dev_receive.dart';
import 'package:we_hire/src/features/authentication/screens/list_request_by_status/list_view_dev_accepted.dart';
import 'package:we_hire/src/features/authentication/screens/list_request_by_status/list_view_dev_interview.dart';
import 'package:we_hire/src/features/authentication/screens/list_request_by_status/list_view_dev_onboarding.dart';
import 'package:we_hire/src/features/authentication/screens/list_request_by_status/list_view_dev_reject.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_education_page.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_professtional_experience.dart';
import 'package:we_hire/src/common_widget/from_home_widget/form_category_widget.dart';
import 'package:we_hire/src/common_widget/request_card.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/request_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/dev_profile.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/setting_dev.dart';
import 'package:we_hire/src/features/authentication/screens/project/list_project_dev.dart';
import 'package:we_hire/src/features/authentication/screens/welcome/main_page.dart';
import 'package:we_hire/src/locator.dart';

import 'src/features/authentication/models/new_request.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  MyApp({super.key}) {
    _firebaseMessaging
        .requestPermission(); // Request permission for notifications

    // Handle when the notification is opened and the app is not running
    FirebaseApi().initNotification();

    // Handle when the notification is clicked and the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Handle the message when the app is opened from the background
    });

    // Handle when the notification is received while the app is in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      // Handle the message when the app is in the foreground
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HiringNew? hiringNew;
    return MaterialApp(
      themeMode: ThemeMode.system,
      home: MainHomePage(),
      navigatorKey: navigatorKey,
      //home: const TestLoginScreen(),
      routes: {
        CategoriesWidget.routeName: (context) => const CategoriesWidget(),
        MainHomePage.routeName: (context) => const MainHomePage(),
        ListViewPage.routeName: (context) => const ListViewPage(),
        UserProfileScreen.routeName: (context) => const UserProfileScreen(),
        ListViewPageDevAccepted.routeName: (context) =>
            ListViewPageDevAccepted(),
        ListViewPageDevOnBoarding.routeName: (context) =>
            ListViewPageDevOnBoarding(),
        ListViewPageDevReject.routeName: (context) => ListViewPageDevReject(),
        ListViewPageDevInterview.routeName: (context) =>
            ListViewPageDevInterview(),
        RequestPageDetail.routeName: (context) =>
            RequestPageDetail(hiringNew!.requestId),
        ListProfessionalPage.routeName: (context) =>
            const ListProfessionalPage(),
        ListEducationPage.routeName: (context) => const ListEducationPage(),
        SettingProfileDevPage.routeName: (context) =>
            const SettingProfileDevPage(),
        ListInterviewDevReceive.routeName: (context) =>
            const ListInterviewDevReceive(),
        ListProjectDev.routeName: (context) => const ListProjectDev()
      },
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  _ListViewPageState createState() => _ListViewPageState();
  static const String routeName = "/view";
}

class _ListViewPageState extends State<ListViewPage> {
  List<HiringNew> postData = [];
  var hiringController = RequestController(RequestRepository());
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();
  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
    _searchProjects();
  }

  void _searchProjects() {
    hiringController.searchHiringList(searchQuery);
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
        title: const Text('List Request'),
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
                    color:
                        const Color.fromARGB(255, 63, 151, 98).withOpacity(0.1),
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
                        hintText: 'Search hiring request...',
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
        ],
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<HiringNew>>(
        future: hiringController.fetchHiringList(),
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
          List<HiringNew>? filteredList = snapshot.data
              ?.where((hiringNew) =>
                  hiringNew.jobTitle!.toLowerCase().contains(searchQuery) ||
                  hiringNew.requestCode!.toLowerCase().contains(searchQuery))
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
                    // Check if the index is within the valid range
                    if (index >= 0 && index < filteredList!.length) {
                      return RequestCard(hiringNew: filteredList[index]);
                    } else {
                      // Handle the case where the index is out of bounds
                      return Center(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/splash_images/interview.png',
                            height: 300,
                            width: 300,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        });
  }
}
