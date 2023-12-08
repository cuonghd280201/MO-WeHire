class NotificationDev {
  int? notificationId;
  int? senderId;
  String? notificationTypeName;
  int? routeId;
  String? createdTime;
  String? companyName;
  String? content;
  bool? isRead;
  bool? isNew;

  NotificationDev(
      {this.notificationId,
      this.senderId,
      this.notificationTypeName,
      this.routeId,
      this.companyName,
      this.content,
      this.createdTime,
      this.isNew,
      this.isRead});
  factory NotificationDev.fromJson(Map<String, dynamic> jsonInput) {
    return NotificationDev(
      notificationId: jsonInput['notificationId'] as int?,
      senderId: jsonInput['senderId'] as int?,
      notificationTypeName: jsonInput['notificationTypeName'] as String?,
      routeId: jsonInput['routeId'] as int?,
      companyName: jsonInput['companyName'] as String?,
      content: jsonInput['content'] as String?,
      createdTime: jsonInput['createdTime'],
      isNew: jsonInput['isNew'] as bool?,
      isRead: jsonInput['isRead'] as bool?,
    );
  }
}
