import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/common_widget/request_card.dart';
import 'package:we_hire/src/features/authentication/controllers/request_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import '../../models/new_request.dart';

class ListViewPageDevInterview extends StatefulWidget {
  @override
  _ListViewPageDevInterviewState createState() =>
      _ListViewPageDevInterviewState();
  static const String routeName = "/status/interviewing";
}

class _ListViewPageDevInterviewState extends State<ListViewPageDevInterview> {
  List<HiringNew> postData = [];

  var hiringController = RequestController(RequestRepository());

  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 129, 84),
        title: Text('Request Interview By Developer'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TestLoginScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              // const Text('List View Status'),
              SizedBox(
                height: 10,
              ),
              buildStaticYardList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStaticYardList() {
    return FutureBuilder<List<HiringNew>>(
        future: hiringController.fetchHiringList(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 1000,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return RequestCard(hiringNew: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
