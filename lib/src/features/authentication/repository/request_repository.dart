import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/constants/values.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:http/http.dart' as http;

class RequestRepository implements Repository {
  @override
  Future<List<HiringNew>> getHiring() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    int? devId = prefs.getInt('devId');
    try {
      final String getAreasUrl = '$apiServer/HiringRequest/ByDev?devId=$devId';

      final http.Response response = await http.get(
        Uri.parse(getAreasUrl),
        headers: {
          'Content-Type': 'application/json',
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
  Future<bool> sendupdateHiringData(int? requestId) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> rejectHiringData(int? requestId) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<Interview>> getInterview(int? devId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Interview/Dev/$devId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Developer/$devId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<List<Education>> getEducation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Education/$devId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<List<ProfessionalExperience>> getProfessionalExperience() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/ProfessionalExperience/$devId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<bool> postEducation(String majorName, String schoolName, startDate,
      String endDate, String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final response = await http.post(
      Uri.parse('$apiServer/Education'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<bool> postProfessionalExperience(String jobName, String companyName,
      String startDate, String endDate, String description) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final response = await http.post(
      Uri.parse('$apiServer/ProfessionalExperience'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
  Future<List<NotificationDev>> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final uri = Uri.parse("$apiServer/Notification/ByUser/$userId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
      String genderId,
      String firstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String summary,
      String filePath) async {
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
      request.headers['Authorization'] = 'Bearer $accessToken';
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
  Future<User> getUserById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final uri = Uri.parse("$apiServer/User/$userId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<bool> updatePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final response = await http.put(
      Uri.parse('$apiServer/User/UpdatePassword/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
  Future<HiringNew> getHiringById(int? requestId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/HiringRequest/$requestId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return HiringNew.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<Interview> getInterViewById(int? interviewId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/Interview/$interviewId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return Interview.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<int> getCountNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Notification/Count/$userId");

    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return requestData[
          'data']; // Assuming 'data' field contains the notification count
    } else {
      throw Exception('Failed to load notification count');
    }
  }

  @override
  Future<NotificationDev> getNotificationText(String deviceToken, String title,
      String content, String notificationType, int routeId) {
    // TODO: implement getNotificationText
    throw UnimplementedError();
  }

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
      prefs.setString('expiration', data['expiration']);
      prefs.setString('refreshToken', data['refreshToken']);
      prefs.setString('deviceToken', deviceToken!);
      devId = data['devId'].toString();
      postUserDevie(deviceToken!);
      JWT_TOKEN_VALUE = data['token'].toString();
      IS_CONFIRM_VALUE = data['isConfirm'].toString();

      final accessTokenExp = DateTime.parse(data['accessTokenExp']);
      if (DateTime.now().isAfter(accessTokenExp)) {
        await refreshToken();
      }
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
  Future<bool> approvedInterview(int? interviewId) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> rejectInterview(
      int? interviewId, String? rejectionReason) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<User> getDeveloperById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    int? devId = prefs.getInt('devId');

    final uri = Uri.parse("$apiServer/Developer/$devId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Future<bool> revokeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Account/Revoke?userId=$userId");
    final Map<String, String> headers = {
      if (accessToken != null) "Authorization": "Bearer $accessToken",
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
  Future<bool> deleteUserDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final String? userDeviceId = prefs.getString('userDevice');

    final uri = Uri.parse("$apiServer/UserDevice/$userDeviceId");

    final response = await http.delete(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<Education> getEducationById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Education/$devId");
    final response = await http.get(
      uri, // Convert Uri to String
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<ProfessionalExperience> getProfessionalExperienceById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/ProfessionalExperience/$devId");
    final response = await http.get(
      uri, // Convert Uri to String
      headers: {"Authorization": "Bearer $accessToken"},
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
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> editProfessionalExperience(
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteEducation(int? educationId) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteProfesstionalExperience(int? professionalId) async {
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
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<List<Project>> getProject(String? devStatusInProject) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? devId = prefs.getInt('devId');
    final uri = Uri.parse(
        "$apiServer/Project/Developer/$devId?devStatusInProject=$devStatusInProject");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<Project> getProjectById(int? projectId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final uri = Uri.parse("$apiServer/Project/$projectId");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> requestData = json.decode(response.body);
      return Project.fromJson(requestData['data']);
    } else {
      throw Exception('Failed to load project data');
    }
  }

  @override
  Future<List<Interview>> searchInterview(int? devId, String? title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse("$apiServer/Interview/Dev/$devId?Title=$title");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<List<Project>> searchProject(
      int? devId, String? devStatusInProject, String? searchKeyString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    devId = prefs.getInt('devId');
    final uri = Uri.parse(
        "$apiServer/Project/Developer/$devId?searchKeyString=$searchKeyString&devStatusInProject=$devStatusInProject");
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
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
  Future<List<HiringNew>> searchHiring(String? searchKeyString) async {
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
  Future<bool> readNotification(int? notificationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse(
        "$apiServer/Notification/Read?notificationId=$notificationId&userId=$userId");
    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> unNewNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');

    final uri = Uri.parse("$apiServer/Notification/UnNew?userId=$userId");

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
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
    final response = await http.post(
      Uri.parse('$apiServer/Account/Refresh'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode(<String, String>{
        "accessToken": accessToken ?? "",
        "refreshToken": refreshToken ?? "",
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to refresh tokens');
    }
  }
}
