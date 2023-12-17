import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class RequestController {
  final Repository _repository;

  RequestController(this._repository);
  Future<List<HiringNew>> fetchHiringList(BuildContext context) async {
    return _repository.getHiring(context);
  }

  Future<List<HiringNew>> searchHiringList(
      BuildContext context, String? searchKeyString) async {
    return _repository.searchHiring(context, searchKeyString);
  }

  Future<bool> updateHiringData(BuildContext context, int? requestId) async {
    return _repository.sendupdateHiringData(context, requestId);
  }

  Future<bool> rejectHiring(BuildContext context, int? requestId) async {
    return _repository.rejectHiringData(context, requestId);
  }

  Future<HiringNew> fetchHiringById(
      BuildContext context, int? requestId) async {
    return _repository.getHiringById(context, requestId);
  }
}
