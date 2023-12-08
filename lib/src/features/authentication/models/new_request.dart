class HiringNew {
  int? requestId;
  String? requestCode;
  String? jobTitle;
  String? jobDescription;
  String? duration;
  String? statusString;
  String? companyName;
  String? companyImage;
  double? salaryPerDev;
  String? typeRequireName;
  String? levelRequireName;
  String? employmentTypeName;
  List<String>? skillRequireStrings;

  HiringNew({
    this.requestId,
    this.jobTitle,
    this.jobDescription,
    this.duration,
    this.statusString,
    this.companyName,
    this.companyImage,
    this.typeRequireName,
    this.levelRequireName,
    this.skillRequireStrings,
    this.employmentTypeName,
    this.salaryPerDev,
    this.requestCode,
  });

  factory HiringNew.fromJson(Map<String, dynamic> jsonInput) {
    return HiringNew(
      requestId: jsonInput['requestId'] as int,
      jobTitle: jsonInput['jobTitle'],
      jobDescription: jsonInput['jobDescription'],
      duration: jsonInput['duration'],
      statusString: jsonInput['statusString'],
      requestCode: jsonInput['requestCode'],
      salaryPerDev: jsonInput['salaryPerDev'] as double,
      companyName: jsonInput['companyName'],
      companyImage: jsonInput['companyImage'],
      typeRequireName: jsonInput['typeRequireName'],
      levelRequireName: jsonInput['levelRequireName'],
      employmentTypeName: jsonInput['employmentTypeName'],
      skillRequireStrings: List<String>.from(jsonInput['skillRequireStrings']),
    );
  }
}

//   HiringNew.fromJson(Map<String, dynamic> json) {
//     requestId = json['requestId'];
//     jobTitle = json['jobTitle'];
//     numberOfDev = json['numberOfDev'];
//     targetedDev = json['targetedDev'];
//     salaryPerDev = json['salaryPerDev'];
//     duration = json['duration'];
//     statusString = json['statusString'];
//     companyName = json['companyName'];
//     companyImage = json['companyImage'];
//     typeRequireName = json['typeRequireName'];
//     levelRequireName = json['levelRequireName'];
//     skillRequireStrings = json['skillRequireStrings'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['requestId'] = this.requestId;
//     data['jobTitle'] = this.jobTitle;
//     data['numberOfDev'] = this.numberOfDev;
//     data['targetedDev'] = this.targetedDev;
//     data['salaryPerDev'] = this.salaryPerDev;
//     data['duration'] = this.duration;
//     data['statusString'] = this.statusString;
//     data['companyName'] = this.companyName;
//     data['companyImage'] = this.companyImage;
//     data['typeRequireName'] = this.typeRequireName;
//     data['levelRequireName'] = this.levelRequireName;
//     data['skillRequireStrings'] = this.skillRequireStrings;
//     return data;
//   }
// }
