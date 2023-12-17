import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/worklog.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class WorkLogController {
  final Repository _repository;

  WorkLogController(this._repository);
  Future<List<WorkLog>> fetchWorkLogList(
      BuildContext context, int? paySlipId) async {
    return _repository.getWorkLogByPaySlipId(context, paySlipId);
  }
}
