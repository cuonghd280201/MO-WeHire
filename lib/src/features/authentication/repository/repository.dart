import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/payslip.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/models/worklog.dart';

abstract class Repository {
  Future<void> SignIn(String email, String password);
  Future<List<HiringNew>> getHiring(BuildContext context);
  Future<List<HiringNew>> searchHiring(
      BuildContext context, String? searchKeyString);

  Future<List<Project>> getProject(
      BuildContext context, List<int> devStatusInProject);
  Future<List<Project>> searchProject(BuildContext context, int? devId,
      List<int> devStatusInProject, String? searchKeyString);

  Future<HiringNew> getHiringById(BuildContext context, int? requestId);
  Future<bool> sendupdateHiringData(BuildContext context, int? requestId);
  Future<bool> rejectHiringData(BuildContext context, int? requestId);
  Future<List<Interview>> getInterview(BuildContext context, int? devId);
  Future<List<Interview>> searchInterview(
      BuildContext context, int? devId, String? title);

  Future<User?> getUser(BuildContext context);
  Future<User> getUserById(BuildContext context);
  Future<User> getDeveloperById(BuildContext context);
  Future<Education> getEducationById(BuildContext context);
  Future<Project> getProjectById(BuildContext context, int? projectId);
  Future<List<PaySlip>> getPaySlipByProjectId(
      BuildContext context, int? projectId);
  Future<List<WorkLog>> getWorkLogByPaySlipId(
      BuildContext context, int? paySlipId);
  Future<bool> editEducation(
      BuildContext context,
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description);

  Future<bool> editProfessionalExperience(
      BuildContext context,
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description);
  Future<ProfessionalExperience> getProfessionalExperienceById(
      BuildContext context);
  Future<bool> EditUser(
      BuildContext context,
      String genderId,
      String fisrstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String summary,
      String filePath);
  Future<List<Education>> getEducation(BuildContext context);
  Future<List<ProfessionalExperience>> getProfessionalExperience(
    BuildContext context,
  );
  Future<bool> postEducation(BuildContext context, String majorName,
      String schoolName, String startDate, String endDate, String description);
  Future<bool> postProfessionalExperience(BuildContext context, String jobName,
      String companyName, String startDate, String endDate, String description);
  Future<List<NotificationDev>> getNotification(BuildContext context);
  Future<bool> updatePassword(BuildContext context, String currentPassword,
      String newPassword, String confirmPassword);
  Future<Interview> getInterViewById(BuildContext context, int? interviewId);
  Future<int> getCountNotification(BuildContext context);

  Future<bool> approvedInterview(BuildContext context, int? interviewId);
  Future<bool> rejectInterview(
      BuildContext context, int? interviewId, String? rejectionReason);

  Future<bool> revokeToken(BuildContext context);
  Future<bool> deleteUserDevice(BuildContext context);
  Future<bool> deleteEducation(BuildContext context, int? educationId);
  Future<bool> deleteProfesstionalExperience(
      BuildContext context, int? professionalId);

  Future<NotificationDev> getNotificationText(
      BuildContext context,
      String deviceToken,
      String title,
      String content,
      String notificationType,
      int routeId);

  Future<bool> readNotification(BuildContext context, int? notificationId);
  Future<bool> unNewNotification(BuildContext context);

  Future<bool> refreshToken();

  Future<bool> checkAndRefreshToken(BuildContext context);

  Future<bool> getUserDevice();
}
