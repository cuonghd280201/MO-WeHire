class PaySlip {
  int? paySlipId;
  String? workForMonth;
  double? totalActualWorkedHours;
  double? totalOvertimeHours;
  String? totalEarnings;
  String? statusString;

  PaySlip({
    this.paySlipId,
    this.workForMonth,
    this.totalActualWorkedHours,
    this.totalOvertimeHours,
    this.totalEarnings,
    this.statusString,
  });

  factory PaySlip.fromJson(Map<String, dynamic> jsonInput) {
    return PaySlip(
      paySlipId: jsonInput['paySlipId'] as int?,
      workForMonth: jsonInput['workForMonth'],
      totalActualWorkedHours: jsonInput['totalActualWorkedHours'] as double?,
      totalOvertimeHours: jsonInput['totalOvertimeHours'] as double?,
      totalEarnings: jsonInput['totalEarnings'] as String?,
      statusString: jsonInput['statusString'] as String?,
    );
  }
}
