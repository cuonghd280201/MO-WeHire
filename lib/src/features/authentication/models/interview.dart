class Interview {
  int? interviewId;
  String? interviewCode;
  String? title;
  String? description;
  String? dateOfInterview;
  String? startTime;
  String? endTime;
  int? numOfInterviewee;
  String? meetingUrl;
  String? outlookUrl;
  String? statusString;
  String? postedTime;
  String? rejectionReason;
  String? dateOfInterviewMMM;

  Interview({
    this.interviewId,
    this.interviewCode,
    this.title,
    this.description,
    this.dateOfInterview,
    this.statusString,
    this.startTime,
    this.endTime,
    this.numOfInterviewee,
    this.meetingUrl,
    this.outlookUrl,
    this.postedTime,
    this.rejectionReason,
    this.dateOfInterviewMMM,
  });

  factory Interview.fromJson(Map<String, dynamic> jsonInput) {
    return Interview(
      interviewId: jsonInput['interviewId'] as int?,
      interviewCode: jsonInput['interviewCode'],
      title: jsonInput['title'],
      description: jsonInput['description'],
      dateOfInterview: jsonInput['dateOfInterview'],
      statusString: jsonInput['statusString'],
      numOfInterviewee: jsonInput['numOfInterviewee'],
      outlookUrl: jsonInput['outlookUrl'],
      startTime: jsonInput['startTime'],
      endTime: jsonInput['endTime'],
      meetingUrl: jsonInput['meetingUrl'],
      postedTime: jsonInput['postedTime'],
      rejectionReason: jsonInput['rejectionReason'],
      dateOfInterviewMMM: jsonInput['dateOfInterviewMMM'],
    );
  }
}
