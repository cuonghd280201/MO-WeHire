import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_hire/src/common_widget/request_page.dart';
import 'package:we_hire/src/constants/colors.dart';

import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/models/worklog.dart';
import 'package:we_hire/src/features/authentication/screens/work_log/list_work_log.dart';

class PayCard extends StatefulWidget {
  final PaySlip? paySlip;

  const PayCard({Key? key, required this.paySlip}) : super(key: key);

  @override
  _PayCardState createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> with SingleTickerProviderStateMixin {
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListWorkLogDev(
          paySlipId: widget.paySlip!.paySlipId,
          key: Key('${widget.paySlip?.paySlipId}'),
        ),
      ),
    );
  }

  Widget onImageLoading(context, Widget child, ImageChunkEvent? progress) {
    if (progress == null) return child;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
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
        margin: const EdgeInsets.only(right: 10, left: 10),
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
                        '${widget.paySlip?.workForMonth}',
                        style: TextStyle(
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
                        color: widget.paySlip?.statusString == 'Paid'
                            ? Colors.green
                            : Colors.blueAccent,
                        border: Border.all(
                            color:
                                Colors.white), // Add a border around duration
                        borderRadius: BorderRadius.circular(
                            8.0), // Add border radius if desired
                      ),
                      padding: const EdgeInsets.all(2.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.paySlip?.statusString}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 249, 246, 246),
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
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Total Earning :",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      '${widget.paySlip?.totalEarnings}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Total Overtime Hours:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      '${widget.paySlip?.totalOvertimeHours}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Total Actual Worked Hours :",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: tBottomNavigation,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      '${widget.paySlip?.totalActualWorkedHours}',
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
