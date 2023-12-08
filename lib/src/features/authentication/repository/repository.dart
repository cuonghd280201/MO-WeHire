import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';

abstract class Repository {
  Future<void> SignIn(String email, String password);
  Future<List<HiringNew>> getHiring();
  Future<List<HiringNew>> searchHiring(String? searchKeyString);

  Future<List<Project>> getProject(String? devStatusInProject);
  Future<List<Project>> searchProject(
      int? devId, String? devStatusInProject, String? searchKeyString);

  Future<HiringNew> getHiringById(int? requestId);
  Future<bool> sendupdateHiringData(int? requestId);
  Future<bool> rejectHiringData(int? requestId);
  Future<List<Interview>> getInterview(int? devId);
  Future<List<Interview>> searchInterview(int? devId, String? title);

  Future<User> getUser();
  Future<User> getUserById();
  Future<User> getDeveloperById();
  Future<Education> getEducationById();
  Future<Project> getProjectById(int? projectId);
  Future<bool> editEducation(
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description);

  Future<bool> editProfessionalExperience(
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description);
  Future<ProfessionalExperience> getProfessionalExperienceById();
  Future<bool> EditUser(String genderId, String fisrstName, String lastName,
      String phoneNumber, String dateOfBirth, String summary, String filePath);
  Future<List<Education>> getEducation();
  Future<List<ProfessionalExperience>> getProfessionalExperience();
  Future<bool> postEducation(String majorName, String schoolName,
      String startDate, String endDate, String description);
  Future<bool> postProfessionalExperience(String jobName, String companyName,
      String startDate, String endDate, String description);
  Future<List<NotificationDev>> getNotification();
  Future<bool> updatePassword(
      String currentPassword, String newPassword, String confirmPassword);
  Future<Interview> getInterViewById(int? interviewId);
  Future<int> getCountNotification();

  Future<bool> approvedInterview(int? interviewId);
  Future<bool> rejectInterview(int? interviewId, String? rejectionReason);

  Future<bool> revokeToken();
  Future<bool> deleteUserDevice();
  Future<bool> deleteEducation(int? educationId);
  Future<bool> deleteProfesstionalExperience(int? professionalId);

  Future<NotificationDev> getNotificationText(String deviceToken, String title,
      String content, String notificationType, int routeId);
}
