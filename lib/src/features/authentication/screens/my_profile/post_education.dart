// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/list_education_page.dart';

class PostEducationPage extends StatefulWidget {
  const PostEducationPage({super.key});

  static const String routeName = "/postEducation";

  @override
  State<PostEducationPage> createState() => _PostEducationPageState();
}

class _PostEducationPageState extends State<PostEducationPage> {
  var hiringController = DeveloperController(RequestRepository());

  TextEditingController majorController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String genderSelected = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ListEducationPage(),
              ),
            );
          },
        ),
        title: const Text('Education'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'Please in your information',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              obscureText: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              controller: majorController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(
                    color: headerDashboard,
                    fontSize: 15.0,
                  ),
                  prefixIcon: Icon(
                    Icons.badge_rounded,
                    color: tBottomNavigation,
                  ),
                  focusColor: Colors.white,
                  hintText: "Enter Major Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.only(top: 15)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              obscureText: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              controller: schoolController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(
                    color: headerDashboard,
                    fontSize: 15.0,
                  ),
                  prefixIcon: Icon(
                    Icons.home_filled,
                    color: tBottomNavigation,
                  ),
                  focusColor: Colors.white,
                  hintText: "Enter School Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.only(top: 15)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              obscureText: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              controller: descriptionController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(
                    color: headerDashboard,
                    fontSize: 15.0,
                  ),
                  prefixIcon: Icon(
                    Icons.broadcast_on_home,
                    color: tBottomNavigation,
                  ),
                  focusColor: Colors.white,
                  hintText: "Enter your description",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.only(top: 15)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              controller: startController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(
                    color: headerDashboard,
                    fontSize: 15.0,
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: tBottomNavigation,
                  ),
                  focusColor: Colors.white,
                  hintText: "Enter you start ",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.only(top: 15)),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(FocusNode());
                date = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)))!;
                String dateFormatter = date.toIso8601String();
                DateTime dt = DateTime.parse(dateFormatter);
                var formatter = DateFormat('yyyy-MM-dd');
                startController.text = formatter.format(dt);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              controller: endController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(
                    color: headerDashboard,
                    fontSize: 15.0,
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: tBottomNavigation,
                  ),
                  focusColor: Colors.white,
                  hintText: "Enter you end ",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.only(top: 15)),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(FocusNode());
                date = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)))!;
                String dateFormatter = date.toIso8601String();
                DateTime dt = DateTime.parse(dateFormatter);
                var formatter = DateFormat('yyyy-MM-dd');
                endController.text = formatter.format(dt);
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 60,
            child: MaterialButton(
              onPressed: () async {
                String majorName = majorController.text;
                String schoolName = schoolController.text;
                String startDate = startController.text;
                String endDate = endController.text;
                String description = descriptionController.text;

                try {
                  final bool success = await hiringController.postEducation(
                    majorName,
                    schoolName,
                    startDate,
                    endDate,
                    description,
                  );

                  if (success) {
                    MotionToast.success(
                      description:
                          const Text("Has successfully created education"),
                    ).show(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListEducationPage()),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Failed to post education.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                      textColor: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16.0,
                    );
                  }
                } catch (e) {
                  MotionToast.warning(
                    description: const Text("You cannot create education"),
                  ).show(context);
                }
              },
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(
                  color: tBottomNavigation,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(maxHeight: 40, maxWidth: 100),
                alignment: Alignment.center,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
