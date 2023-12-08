import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class RequestController {
  final Repository _repository;

  RequestController(this._repository);
  Future<List<HiringNew>> fetchHiringList() async {
    return _repository.getHiring();
  }

  Future<List<HiringNew>> searchHiringList(String? searchKeyString) async {
    return _repository.searchHiring(searchKeyString);
  }

  Future<bool> updateHiringData(int? requestId) async {
    return _repository.sendupdateHiringData(requestId);
  }

  Future<bool> rejectHiring(int? requestId) async {
    return _repository.rejectHiringData(requestId);
  }

  Future<HiringNew> fetchHiringById(int? requestId) async {
    return _repository.getHiringById(requestId);
  }
}
