import 'dart:convert';

import 'package:we_hire/src/constants/values.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';

import '../features/authentication/models/interview.dart';

class Service {
  Future<HiringNew?> getYard(int devId, int status) async {
    final response = await http
        .get(Uri.parse('$apiServer/HiringRequest/ByDev/$devId?status=$status'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return HiringNew.fromJson(responseBody['data']);
    }
    return null;
  }

  Future<List<HiringNew>> getHiringRequests(int? devId, String? status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    devId = prefs.getInt('devId');
    final uri =
        Uri.parse('$apiServer/HiringRequest/ByDev?devId=$devId&status=$status');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},

      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => HiringNew.fromJson(data))
          .toList()
          .cast<HiringNew>();
    }

    return [];
  }

  Future<List<Interview>> getInterView(int? requestId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final uri = Uri.parse('$apiServer/Interview/1');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
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

  Future<User?> getUser(int userId) async {
    final response = await http.get(Uri.parse('$apiServer/User/2'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody['data']);
    }
    return null;
  }

  Future<bool> acceptRequest(int? requestId, int? devId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    devId = prefs.getInt('devId');

    final uri = Uri.parse('$apiServer/SelectingDev/ApprovalByDev');
    final response = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "requestId": requestId,
          "developerId": devId,
          "isApproved": true
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<bool> cancelRequest(int? requestId, int? devId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    devId = prefs.getInt('devId');

    final uri = Uri.parse('$apiServer/SelectingDev/ApprovalByDev');
    final response = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "requestId": requestId,
          "developerId": devId,
          "isApproved": false
        }));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
