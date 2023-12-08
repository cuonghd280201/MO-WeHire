class Interview {
  int? interviewId;
  String? interviewCode;
  String? title;
  String? description;
  String? dateOfInterview;
  String? startTime;
  String? endTime;
  int? numOfInterviewee;
  String? meetingLink;
  String? outlookLink;
  String? statusString;
  String? postedTime;
  String? rejectionReason;

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
    this.meetingLink,
    this.outlookLink,
    this.postedTime,
    this.rejectionReason,
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
      outlookLink: jsonInput['outlookLink'],
      startTime: jsonInput['startTime'],
      endTime: jsonInput['endTime'],
      meetingLink: jsonInput['meetingLink'],
      postedTime: jsonInput['postedTime'],
      rejectionReason: jsonInput['rejectionReason'],
    );
  }
}
