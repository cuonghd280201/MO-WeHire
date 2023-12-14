import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class PaySlipController {
  final Repository _repository;

  PaySlipController(this._repository);
  Future<List<PaySlip>> fetchPaySlipList(int? projectId) async {
    return _repository.getPaySlipByProjectId(projectId);
  }
}
