import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/features/authentication/controllers/work_log_controller.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/models/worklog.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/work_log/component_work_log/word_log_card.dart';

class ListWorkLogDev extends StatefulWidget {
  final int? paySlipId;

  const ListWorkLogDev({super.key, this.paySlipId});

  @override
  _ListWorkLogDevState createState() => _ListWorkLogDevState();
  static const String routeName = "/status/interviewing";
}

class _ListWorkLogDevState extends State<ListWorkLogDev> {
  var workLogController = WorkLogController(RequestRepository());

  WorkLog? workLog;
  @override
  Widget build(BuildContext context) {
    return buildViewPage();
  }

  Widget buildViewPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 129, 84),
        title: const Text('Work Log'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              // const Text('List View Status'),
              const SizedBox(
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
    return FutureBuilder<List<WorkLog>>(
        future: workLogController.fetchWorkLogList(context, widget.paySlipId),
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
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context)
                    .size
                    .height, // Lấy chiều cao của màn hình
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return WorkLogCard(workLog: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
