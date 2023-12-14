class WorkLog {
  int? workLogId;
  int? paySlipId;
  String? workDateMMM;
  String? timeIn;
  String? timeOut;
  int? hourWorkInDay;
  bool? isPaidLeave;

  WorkLog(
      {this.workLogId,
      this.paySlipId,
      this.workDateMMM,
      this.timeIn,
      this.timeOut,
      this.hourWorkInDay,
      this.isPaidLeave});

  factory WorkLog.fromJson(Map<String, dynamic> jsonInput) {
    return WorkLog(
      workLogId: jsonInput['workLogId'] as int,
      paySlipId: jsonInput['paySlipId'] as int,
      workDateMMM: jsonInput['workDateMMM'],
      timeIn: jsonInput['timeIn'],
      timeOut: jsonInput['timeOut'],
      hourWorkInDay: jsonInput['hourWorkInDay'],
      isPaidLeave: jsonInput['isPaidLeave'],
    );
  }
}
