import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/features/authentication/controllers/pay_slip_controller.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';
import 'package:we_hire/src/features/authentication/screens/pay_slip/component_pay_slip/pay_slip_card.dart';

class ListPaySlipDev extends StatefulWidget {
  @override
  _ListPaySlipDevState createState() => _ListPaySlipDevState();
  static const String routeName = "/status/interviewing";
}

class _ListPaySlipDevState extends State<ListPaySlipDev> {
  var paySlipControler = PaySlipController(RequestRepository());

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
    return FutureBuilder<List<PaySlip>>(
        future: paySlipControler.fetchPaySlipList(context, 1),
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
                    return PayCard(paySlip: snapshot.data?[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
