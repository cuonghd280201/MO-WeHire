import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/common_widget/loading.dart';
import 'package:we_hire/src/common_widget/request_card.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/request_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import '../../models/new_request.dart';

class ListViewPageDevReject extends StatefulWidget {
  @override
  _ListViewPageDevRejectState createState() => _ListViewPageDevRejectState();
  static const String routeName = "/status/devRejected";
}

class _ListViewPageDevRejectState extends State<ListViewPageDevReject> {
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
        title: Text('Requests are rejected'),
        centerTitle: true,
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
              icon: Icon(Icons.logout)),
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ListViewPageDevReject()));
          //   },
          //   icon: Icon(Icons.refresh),
          // ),
        ],
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
                    color: Color.fromARGB(255, 63, 151, 98).withOpacity(0.1),
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
          Positioned(
            bottom: 10, // Điều chỉnh vị trí dọc của nút
            right: 10, // Điều chỉnh vị trí ngang của nút
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListViewPageDevReject()));
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), // Để làm cho nút tròn
                primary: primarygreen, // Màu nền của nút
              ),
              child: Icon(Icons.refresh),
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
