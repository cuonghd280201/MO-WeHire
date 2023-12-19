import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/models/worklog.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/constants/values.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:http/http.dart' as http;
import 'package:we_hire/src/features/authentication/screens/login/test_login.dart';

class RequestRepository implements Repository {
  // @override
  // Future<List<HiringNew>> getHiring() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? accessToken = prefs.getString('accessToken');
  //   int? devId = prefs.getInt('devId');
  //   try {
  //     final String getAreasUrl = '$apiServer/HiringRequest/ByDev?devId=$devId';

  //     final http.Response response = await http.get(
  //       Uri.parse(getAreasUrl),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         "Authorization": "Bearer $accessToken"
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final List<dynamic> requestData = data['data'];
  //       return requestData
  //           .map((data) => HiringNew.fromJson(data))
  //           .toList()
  //           .cast<HiringNew>();
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }

  //   return [];
  // }

  Future<List<HiringNew>> getHiring(
    BuildContext context,
  ) async {
    // Check and refresh token
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? devId = prefs.getInt('devId');

    if (devId == null) {
      throw Exception('Missing developer ID');
    }

    try {
      final String getAreasUrl = '$apiServer/HiringRequest/ByDev?devId=$devId';

      final http.Response response = await http.get(
        Uri.parse(getAreasUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('accessToken')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> requestData = data['data'];
        return requestData
            .map((data) => HiringNew.fromJson(data))
            .toList()
            .cast<HiringNew>();
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getHiring: $e');
      throw Exception('Failed to get hiring requests');
    }

    return [];
  }

  @override
  Future<bool> sendupdateHiringData(
      BuildContext context, int? requestId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');

    final uri = Uri.parse("$apiServer/SelectingDev/ApprovalByDev");
    final Map<String, dynamic> requestData = {
      "requestId": requestId,
      "developerId": devId,
      "isApproved": true,
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> rejectHiringData(BuildContext context, int? requestId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');

    final uri = Uri.parse("$apiServer/SelectingDev/ApprovalByDev");
    final Map<String, dynamic> requestData = {
      "requestId": requestId,
      "developerId": devId,
      "isApproved": false,
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<Interview>> getInterview(BuildContext context, int? devId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Interview/Dev/$devId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => Interview.fromJson(data))
          .toList()
          .cast<Interview>();
    }

    return [];
  }

  void _navigateToLoginScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Notification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                  "Notice that the login session has expired. Please log in again"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const TestLoginScreen(),
                  ),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<User?> getUser(BuildContext context) async {
    try {
      final bool tokenIsValid = await checkAndRefreshToken(context);

      if (!tokenIsValid) {
        _navigateToLoginScreen(context);
        return null; // Return null or a default user, depending on your requirements
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      int? devId = prefs.getInt('devId');

      if (accessToken == null || devId == null) {
        _navigateToLoginScreen(context);
        return null; // Return null or a default user, depending on your requirements
      }

      final uri = Uri.parse("$apiServer/Developer/$devId");
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return User.fromJson(userData['data']);
      } else {
        _navigateToLoginScreen(context);
        return null; // Return null or a default user, depending on your requirements
      }
    } catch (e) {
      // Handle exceptions as needed
      print('Exception in getUser: $e');
      return null; // Return null or a default user, depending on your requirements
    }
  }

  @override
  Future<List<Education>> getEducation(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Education/$devId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => Education.fromJson(data))
          .toList()
          .cast<Education>();
    }

    return [];
  }

  @override
  Future<List<ProfessionalExperience>> getProfessionalExperience(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/ProfessionalExperience/$devId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => ProfessionalExperience.fromJson(data))
          .toList()
          .cast<ProfessionalExperience>();
    }

    return [];
  }

  @override
  Future<bool> postEducation(BuildContext context, String majorName,
      String schoolName, startDate, String endDate, String description) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final response = await http.post(
      Uri.parse('$apiServer/Education'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
      body: jsonEncode(<String, String>{
        "developerId": '$devId',
        "majorName": majorName,
        "schoolName": schoolName,
        "startDate": startDate,
        "endDate": endDate,
        "description": description
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to post Education in');
    }
  }

  @override
  Future<bool> postProfessionalExperience(
      BuildContext context,
      String jobName,
      String companyName,
      String startDate,
      String endDate,
      String description) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final response = await http.post(
      Uri.parse('$apiServer/ProfessionalExperience'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
      body: jsonEncode(<String, String>{
        "developerId": '$devId',
        "jobName": jobName,
        "companyName": companyName,
        "startDate": startDate,
        "endDate": endDate,
        "description": description
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<List<NotificationDev>> getNotification(BuildContext context) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final uri = Uri.parse("$apiServer/Notification/ByUser/$userId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => NotificationDev.fromJson(data))
          .toList()
          .cast<NotificationDev>();
    }
    return [];
  }

  // @override
  // Future<bool> EditUser(String fisrstName, String lastName, String phoneNumber,
  //     String dateOfBirth) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? accessToken = prefs.getString('accessToken');
  //   int? userId = prefs.getInt('userId');
  //   final response = await http.put(
  //     Uri.parse("$apiServer/User/$userId"),
  //     headers: {
  //       'accept': 'text/plain',
  //       'Content-Type': 'multipart/form-data',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'userId': '$userId',
  //       'firstName': fisrstName,
  //       'lastName': lastName,
  //       'phoneNumber': phoneNumber,
  //       'dateOfBirth': dateOfBirth,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to sign in');
  //   }
  // }
  @override
  Future<bool> EditUser(
      BuildContext context,
      String genderId,
      String firstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String summary,
      String filePath) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    int? devId = prefs.getInt('devId');

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$apiServer/Developer/$devId'),
    );

    // Set headers
    request.headers['accept'] = 'text/plain';

    // Add fields as multipart form data
    request.fields['developerId'] = '$devId';
    request.fields['genderId'] = genderId;
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['summary'] = summary;
    request.fields['dateOfBirth'] = dateOfBirth;

    // Attach access token if needed
    if (accessToken != null) {
      request.headers['Authorization'] =
          'Bearer ${prefs.getString('accessToken')}';
    }
    if (filePath.isNotEmpty) {
      var file = await http.MultipartFile.fromPath(
        'File',
        filePath,
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type as needed
      );
      request.files.add(file);
    }
    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user information');
    }
  }

  @override
  Future<User> getUserById(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final uri = Uri.parse("$apiServer/User/$userId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<bool> updatePassword(BuildContext context, String currentPassword,
      String newPassword, String confirmPassword) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final response = await http.put(
      Uri.parse('$apiServer/User/UpdatePassword/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
      body: jsonEncode(<String, String>{
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to change Password');
    }
  }

  @override
  Future<HiringNew> getHiringById(BuildContext context, int? requestId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/HiringRequest/$requestId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return HiringNew.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<Interview> getInterViewById(
      BuildContext context, int? interviewId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/Interview/$interviewId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return Interview.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<int> getCountNotification(BuildContext context) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Notification/Count/$userId");

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return requestData[
          'data']; // Assuming 'data' field contains the notification count
    } else {
      throw Exception('Failed to load notification count');
    }
  }

  // @override
  // Future<NotificationDev> getNotificationText(String deviceToken, String title,
  //     String content, String notificationType, int routeId) {
  //   // TODO: implement getNotificationText
  //   throw UnimplementedError();
  // }

  @override
  Future<void> SignIn(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$apiServer/Account/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var deviceToken = await FirebaseMessaging.instance.getToken();
      print(deviceToken);
      final body = await json.decode(response.body);
      final data = body['data'];
      prefs.setString('accessToken', data['accessToken']);
      prefs.setInt('devId', data['devId']);
      prefs.setInt('userId', data['userId']);
      prefs.setString('accessTokenExp', data['accessTokenExp']);
      prefs.setString('refreshTokenExp', data['refreshTokenExp']);
      prefs.setString('refreshToken', data['refreshToken']);
      prefs.setString('deviceToken', deviceToken!);
      devId = data['devId'].toString();
      postUserDevie(deviceToken!);
      await getUserDevice();
      JWT_TOKEN_VALUE = data['token'].toString();
      IS_CONFIRM_VALUE = data['isConfirm'].toString();
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> postUserDevie(String deviceToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final response = await http.post(
      Uri.parse('$apiServer/UserDevice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
      body: jsonEncode(<String, String>{
        "userId": '$userId',
        "deviceToken": deviceToken,
      }),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<bool> approvedInterview(BuildContext context, int? interviewId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    final uri = Uri.parse("$apiServer/Interview/ApprovalByDeveloper");
    final Map<String, dynamic> requestData = {
      "interviewId": interviewId,
      "isApproved": true,
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> rejectInterview(
      BuildContext context, int? interviewId, String? rejectionReason) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    final uri = Uri.parse("$apiServer/Interview/ApprovalByDeveloper");
    final Map<String, dynamic> requestData = {
      "interviewId": interviewId,
      "isApproved": false,
      "rejectionReason": rejectionReason
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<User> getDeveloperById(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    int? devId = prefs.getInt('devId');

    final uri = Uri.parse("$apiServer/Developer/$devId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<bool> revokeToken(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Account/Revoke?userId=$userId");
    final Map<String, String> headers = {
      if (accessToken != null)
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
    };

    final response = await http.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  @override
  Future<bool> deleteUserDevice(BuildContext context) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userDeviceId = prefs.getInt('userDeviceId');

    if (userDeviceId == null) {
      // Handle the case where userDeviceId is null (not found in SharedPreferences)
      print('User device ID not found in SharedPreferences.');
      return false;
    }

    final uri = Uri.parse("$apiServer/UserDevice/$userDeviceId");

    try {
      final response = await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString('accessToken')}'
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        // Handle the case where the user device does not exist
        print('Error: ${response.body}');
        return false;
      } else {
        // Handle other status codes if needed
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<Education> getEducationById(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Education/$devId");
    final response = await http.get(
      uri, // Convert Uri to String
      headers: {'Authorization': 'Bearer ${prefs.getString('accessToken')}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];

      if (dataList.isNotEmpty) {
        final Map<String, dynamic> userData = dataList[0];
        return Education.fromJson(userData);
      } else {
        throw Exception('No education data available');
      }
    } else {
      throw Exception('Failed to load education data');
    }
  }

  @override
  Future<ProfessionalExperience> getProfessionalExperienceById(
    BuildContext context,
  ) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/ProfessionalExperience/$devId");
    final response = await http.get(
      uri, // Convert Uri to String
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body)['data'];

      if (dataList.isNotEmpty) {
        final Map<String, dynamic> userData = dataList[0];
        return ProfessionalExperience.fromJson(userData);
      } else {
        throw Exception('No education data available');
      }
    } else {
      throw Exception('Failed to load education data');
    }
  }

  @override
  Future<bool> editEducation(
      BuildContext context,
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse('$apiServer/Education/$educationId');
    final Map<String, dynamic> requestData = {
      "educationId": '$educationId',
      "developerId": '$devId',
      "majorName": majorName,
      "schoolName": schoolName,
      "startDate": startDate,
      "endDate": endDate,
      "description": description
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> editProfessionalExperience(
      BuildContext context,
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse(
        '$apiServer/ProfessionalExperience/$professionalExperienceId');
    final Map<String, dynamic> requestData = {
      "educationId": '$professionalExperienceId',
      "developerId": '$devId',
      "majorName": jobName,
      "schoolName": companyName,
      "startDate": startDate,
      "endDate": endDate,
      "description": description
    };

    final response = await http.put(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteEducation(BuildContext context, int? educationId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    final uri = Uri.parse("$apiServer/Education/$educationId");
    final Map<String, dynamic> requestData = {
      "educationId": educationId,
    };
    final response = await http.delete(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteProfesstionalExperience(
      BuildContext context, int? professionalId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    final uri = Uri.parse("$apiServer/ProfessionalExperience/$professionalId");
    final Map<String, dynamic> requestData = {
      "professionalId": professionalId,
    };
    final response = await http.delete(
      uri,
      body: json.encode(requestData),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<List<Project>> getProject(
      BuildContext context, List<int> devStatusInProject) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');

    final uri = Uri.parse("$apiServer/Project/Developer/$devId")
        .replace(queryParameters: {
      'devStatusInProject':
          devStatusInProject.map((status) => status.toString()).toList()
    });

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => Project.fromJson(data))
          .toList()
          .cast<Project>();
    }

    return [];
  }

  // @override
  // Future<List<Project>> getProject(String? devStatusInProject) async {
  //   final bool tokenValid = await checkAndRefreshToken(context)

  //   if (!tokenValid) {
  //     // Token is not valid, handle accordingly (e.g., show login screen)
  //     return [];
  //   }

  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? accessToken = prefs.getString('accessToken');
  //   int? devId = prefs.getInt('devId');

  //   final uri = Uri.parse(
  //       "$apiServer/Project/Developer/$devId?devStatusInProject=$devStatusInProject");

  //   final response = await http.get(
  //     uri,
  //     headers: {"Authorization": "Bearer $accessToken"},
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List<dynamic> requestData = data['data'];
  //     return requestData
  //         .map((data) => Project.fromJson(data))
  //         .toList()
  //         .cast<Project>();
  //   } else if (response.statusCode == 401) {
  //     final bool tokenRefreshed = await checkAndRefreshToken(context)

  //     if (tokenRefreshed) {
  //       return getProject(devStatusInProject);
  //     } else {
  //       // Token refresh failed, handle accordingly (e.g., show login screen)
  //       return [];
  //     }
  //   }

  //   // Handle other response status codes if needed

  //   return [];
  // }

  // @override
  // Future<List<Project>> getProject(
  //     String? projectCode, String? projectName, String status) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? accessToken = prefs.getString('accessToken');
  //   int? devId = prefs.getInt('devId');
  //   final uri = Uri.parse("$apiServer/Project/Developer/$devId");
  //   final response = await http.get(
  //     uri,
  //     headers: {"Authorization": "Bearer $accessToken"},
  //   );
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List<dynamic> requestData = data['data'];
  //     return requestData
  //         .map((data) => Project.fromJson(data))
  //         .toList()
  //         .cast<Project>();
  //   }

  //   return [];
  // }

  @override
  Future<Project> getProjectById(BuildContext context, int? projectId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      throw Exception('Access token is not valid.');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/Project/$projectId");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return Project.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load project data');
    }
  }

  @override
  Future<List<Interview>> searchInterview(
      BuildContext context, int? devId, String? title) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Interview/Dev/$devId?Title=$title");
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => Interview.fromJson(data))
          .toList()
          .cast<Interview>();
    }

    return [];
  }

  @override
  Future<List<Project>> searchProject(BuildContext context, int? devId,
      List<int> devStatusInProject, String? searchKeyString) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse(
            "$apiServer/Project/Developer/$devId?searchKeyString=$searchKeyString")
        .replace(queryParameters: {
      'devStatusInProject':
          devStatusInProject.map((status) => status.toString()).toList()
    });
    ;
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${prefs.getString('accessToken')}',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => Project.fromJson(data))
          .toList()
          .cast<Project>();
    }

    return [];
  }

  @override
  Future<List<HiringNew>> searchHiring(
      BuildContext context, String? searchKeyString) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? devId = prefs.getInt('devId');
    final String? accessToken = prefs.getString('accessToken');
    try {
      final String getAreasUrl =
          '$apiServer/HiringRequest/ByDev?devId=$devId&searchKeyString=$searchKeyString';
      final http.Response response = await http.get(
        Uri.parse(getAreasUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('accessToken')}'
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> requestData = data['data'];
        return requestData
            .map((data) => HiringNew.fromJson(data))
            .toList()
            .cast<HiringNew>();
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  @override
  Future<bool> readNotification(
      BuildContext context, int? notificationId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse(
        "$apiServer/Notification/Read?notificationId=$notificationId&userId=$userId");
    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}'
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> unNewNotification(BuildContext context) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Notification/UnNew?userId=$userId");

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.getString('accessToken')}'
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> refreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final int? userId = prefs.getInt('userId');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? accessTokenExp = prefs.getString('accessTokenExp');
    final String? refreshTokenExp = prefs.getString('refreshTokenExp');
    final response = await http.post(
      Uri.parse('$apiServer/Account/Refresh'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode(<String, String>{
        "accessToken": accessToken ?? "",
        "refreshToken": refreshToken ?? "",
        "accessTokenExp": accessTokenExp ?? "",
        "refreshTokenExp": refreshTokenExp ?? "",
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      prefs.setString('accessToken', data['accessToken']);
      prefs.setString('refreshToken', data['refreshToken']);
      prefs.setString('accessTokenExp', data['accessTokenExp']);
      prefs.setString('refreshTokenExp', data['refreshTokenExp']);
      return true;
    } else {
      throw Exception('Failed to refresh tokens');
    }
  }

  @override
  Future<bool> checkAndRefreshToken(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      final String? accessTokenExp = prefs.getString('accessTokenExp');

      if (accessToken != null && accessTokenExp != null) {
        final DateTime accessTokenExpDate =
            DateTime.parse(accessTokenExp).add(const Duration(hours: 7));
        if (DateTime.now().isAfter(accessTokenExpDate)) {
          // Access token has expired, refresh it
          await refreshToken();

          // Refresh successful, update access token expiration time
          final String? updatedAccessTokenExp =
              prefs.getString('refreshTokenExp');

          if (updatedAccessTokenExp != null) {
            final DateTime updatedExpDate =
                DateTime.parse(updatedAccessTokenExp);
            if (DateTime.now().isBefore(updatedExpDate)) {
              // Update successful, return true
              return true;
            } else {
              // Refreshed token has already expired, perform logout
              await logout(context);
              return false;
            }
          } else {
            // Failed to get updated access token expiration time, perform logout
            await logout(context);
            return false;
          }
        }
      }

      // Access token is valid
      return true;
    } catch (e) {
      print('Failed to refresh token: $e');
      await logout(context);
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    // Perform logout actions, such as clearing stored tokens and user information
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('devId');
    prefs.remove('userId');
    prefs.remove('accessTokenExp');
    prefs.remove('expiration');
    prefs.remove('refreshToken');
    prefs.remove('deviceToken');
    // Additional logout actions, if any

    // Navigate to the TestLoginScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const TestLoginScreen(),
      ),
    );
  }

  @override
  Future<List<PaySlip>> getPaySlipByProjectId(
      BuildContext context, int? projectId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse(
        "$apiServer/PaySlip/ByDeveloper?projectId=$projectId&developerId=$devId");
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${prefs.getString('accessToken')}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => PaySlip.fromJson(data))
          .toList()
          .cast<PaySlip>();
    }

    return [];
  }

  @override
  Future<List<WorkLog>> getWorkLogByPaySlipId(
      BuildContext context, int? paySlipId) async {
    final bool tokenIsValid = await checkAndRefreshToken(context);

    if (!tokenIsValid) {
      // Token is not valid, handle accordingly (e.g., throw an exception, return an empty list)
      print('Access token is not valid. Unable to fetch hiring requests.');
      return [];
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/WorkLog/ByPaySlip/$paySlipId");
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${prefs.getString('accessToken')}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => WorkLog.fromJson(data))
          .toList()
          .cast<WorkLog>();
    }

    return [];
  }

  @override
  Future<NotificationDev> getNotificationText(
      BuildContext context,
      String deviceToken,
      String title,
      String content,
      String notificationType,
      int routeId) {
    // TODO: implement getNotificationText
    throw UnimplementedError();
  }

  @override
  Future<bool> getUserDevice() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      int? userId = prefs.getInt('userId');
      final uri = Uri.parse("$apiServer/UserDevice/User/$userId");
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // ignore: unused_local_variable
        final List<dynamic> requestData = data['data'];
        if (requestData.isNotEmpty) {
          // Assuming userDeviceId is an integer, adjust the type accordingly
          int userDeviceId = requestData[0]['userDeviceId'];

          // Save userDeviceId to local storage (SharedPreferences)
          prefs.setInt('userDeviceId', userDeviceId);
        }
        return true;
      } else {
        // Handle non-200 status codes
        print("Error: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }
}
