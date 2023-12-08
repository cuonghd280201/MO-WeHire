class ProfessionalExperience {
  int? professionalExperienceId;
  int? developerId;
  String? jobName;
  String? companyName;
  String? startDate;
  String? endDate;
  String? description;

  ProfessionalExperience(
      {this.professionalExperienceId,
      this.developerId,
      this.jobName,
      this.companyName,
      this.startDate,
      this.endDate,
      this.description});
  factory ProfessionalExperience.fromJson(Map<String, dynamic> jsonInput) {
    return ProfessionalExperience(
      professionalExperienceId: jsonInput['professionalExperienceId'] as int,
      developerId: jsonInput['developerId'] as int,
      jobName: jsonInput['jobName'],
      companyName: jsonInput['companyName'],
      startDate: jsonInput['startDate'],
      endDate: jsonInput['endDate'],
      description: jsonInput['description'],
    );
  }
}
