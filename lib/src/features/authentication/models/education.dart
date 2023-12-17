class Education {
  int? educationId;
  int? developerId;
  String? majorName;
  String? schoolName;
  String? startDate;
  String? endDate;
  String? description;
  String? developerFullName;
  String? developerCode;
  String? startDateMMM;
  String? endDateMMM;

  Education({
    this.educationId,
    this.developerId,
    this.majorName,
    this.schoolName,
    this.startDate,
    this.endDate,
    this.description,
    this.developerCode,
    this.developerFullName,
    this.startDateMMM,
    this.endDateMMM,
  });

  factory Education.fromJson(Map<String, dynamic> jsonInput) {
    return Education(
      educationId: jsonInput['educationId'] as int?,
      developerId: jsonInput['developerId'] as int?,
      majorName: jsonInput['majorName'] as String?,
      schoolName: jsonInput['schoolName'] as String?,
      startDate: jsonInput['startDate'] as String?,
      endDate: jsonInput['endDate'] as String?,
      description: jsonInput['description'] as String?,
      developerCode: jsonInput['developerCode'] as String?,
      developerFullName: jsonInput['developerFullName'] as String?,
      startDateMMM: jsonInput['startDateMMM'] as String?,
      endDateMMM: jsonInput['endDateMMM'] as String?,
    );
  }
}
