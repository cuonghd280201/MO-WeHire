import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class InterviewController {
  final Repository _repository;

  InterviewController(this._repository);
  Future<List<Interview>> fetchInterviewList(
      BuildContext context, int? devId) async {
    return _repository.getInterview(context, devId);
  }

  Future<List<Interview>> searchInterviewList(
      BuildContext context, int? devId, String? title) async {
    return _repository.searchInterview(context, devId, title);
  }

  Future<bool> approvedInterview(BuildContext context, int? interviewId) async {
    return _repository.approvedInterview(context, interviewId);
  }

  Future<bool> rejectInterview(
      BuildContext context, int? interviewId, String? rejectionReason) async {
    return _repository.rejectInterview(context, interviewId, rejectionReason);
  }
}
