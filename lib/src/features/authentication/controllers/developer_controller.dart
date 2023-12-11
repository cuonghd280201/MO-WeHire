import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class DeveloperController {
  final Repository _repository;

  DeveloperController(this._repository);
  Future<User> fetchUserList() async {
    return _repository.getUser();
  }

  Future<List<Education>> fetchEducationList() async {
    return _repository.getEducation();
  }

  Future<List<ProfessionalExperience>> fetchProfessionalExperience() async {
    return _repository.getProfessionalExperience();
  }

  Future<bool> postEducation(String majorName, String schoolName,
      String startDate, String endDate, String description) async {
    return _repository.postEducation(
        majorName, schoolName, startDate, endDate, description);
  }

  Future<bool> postProfessionalExperience(String jobName, String companyName,
      String startDate, String endDate, String description) async {
    return _repository.postProfessionalExperience(
        jobName, companyName, startDate, endDate, description);
  }

  Future<List<NotificationDev>> fetchNotification() async {
    return _repository.getNotification();
  }

  Future<bool> editDeveloper(
      String genderId,
      String fisrstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String summary,
      String filePath) async {
    return _repository.EditUser(genderId, fisrstName, lastName, phoneNumber,
        dateOfBirth, summary, filePath);
  }

  Future<bool> editEducation(
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description) async {
    return _repository.editEducation(
        educationId, majorName, schoolName, startDate, endDate, description);
  }

  Future<bool> editProfessionalExperience(
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description) async {
    return _repository.editProfessionalExperience(professionalExperienceId,
        jobName, companyName, startDate, endDate, description);
  }

  Future<User> fetchUserById() async {
    return _repository.getUserById();
  }

  Future<Education> fetchEduationById() async {
    return _repository.getEducationById();
  }

  Future<ProfessionalExperience> fetchProfessionalExperienceById() async {
    return _repository.getProfessionalExperienceById();
  }

  Future<User> fetchDeveloperById() async {
    return _repository.getDeveloperById();
  }

  Future<Interview> fetchInterviewById(int? interviewId) async {
    return _repository.getInterViewById(interviewId);
  }

  Future<int> countNotification() async {
    return _repository.getCountNotification();
  }

  Future<bool> updatePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    return _repository.updatePassword(
        currentPassword, newPassword, confirmPassword);
  }

  Future<void> SignIn(String email, String password) async {
    return _repository.SignIn(email, password);
  }

  Future<bool> revokeToken() async {
    return _repository.revokeToken();
  }

  Future<bool> deleteEducation(int? educationId) async {
    return _repository.deleteEducation(educationId);
  }

  Future<bool> deleteProfesstionalExperience(int? professionalId) async {
    return _repository.deleteProfesstionalExperience(professionalId);
  }

  Future<bool> readNotification(int? notificationId) async {
    return _repository.readNotification(notificationId);
  }

  Future<bool> unNewNotification() async {
    return _repository.unNewNotification();
  }
}
