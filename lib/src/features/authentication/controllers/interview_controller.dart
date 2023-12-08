import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class InterviewController {
  final Repository _repository;

  InterviewController(this._repository);
  Future<List<Interview>> fetchInterviewList(int? devId) async {
    return _repository.getInterview(devId);
  }

  Future<List<Interview>> searchInterviewList(int? devId, String? title) async {
    return _repository.searchInterview(devId, title);
  }

  Future<bool> approvedInterview(int? interviewId) async {
    return _repository.approvedInterview(interviewId);
  }

  Future<bool> rejectInterview(
      int? interviewId, String? rejectionReason) async {
    return _repository.rejectInterview(interviewId, rejectionReason);
  }
}
