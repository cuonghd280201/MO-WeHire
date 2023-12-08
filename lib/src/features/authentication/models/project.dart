class Project {
  int? projectId;
  String? companyImage;
  String? companyName;
  String? projectTypeName;
  String? devStatusInProject;
  String? projectCode;
  String? projectName;
  int? numberOfDev;
  String? startDate;
  String? endDate;
  String? postedTime;
  String? statusString;
  String? description;

  Project(
      {this.projectId,
      this.statusString,
      this.companyName,
      this.projectTypeName,
      this.devStatusInProject,
      this.companyImage,
      this.projectCode,
      this.projectName,
      this.startDate,
      this.endDate,
      this.postedTime,
      this.numberOfDev,
      this.description});

  factory Project.fromJson(Map<String, dynamic> jsonInput) {
    return Project(
      projectId: jsonInput['projectId'] as int,
      projectCode: jsonInput['projectCode'],
      projectName: jsonInput['projectName'],
      projectTypeName: jsonInput['projectTypeName'],
      devStatusInProject: jsonInput['devStatusInProject'],
      description: jsonInput['description'],
      statusString: jsonInput['statusString'],
      startDate: jsonInput['startDate'],
      endDate: jsonInput['endDate'],
      companyName: jsonInput['companyName'],
      companyImage: jsonInput['companyImage'],
      postedTime: jsonInput['postedTime'],
      numberOfDev: jsonInput['numberOfDev'] as int,
    );
  }
}
