import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/education.dart';
import 'package:we_hire/src/features/authentication/models/interview.dart';
import 'package:we_hire/src/features/authentication/models/notification.dart';
import 'package:we_hire/src/features/authentication/models/professtional_experience.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class DeveloperController {
  final Repository _repository;

  DeveloperController(this._repository);
  Future<User?> fetchUserList(BuildContext context) async {
    return _repository.getUser(context);
  }

  Future<List<Education>> fetchEducationList(BuildContext context) async {
    return _repository.getEducation(context);
  }

  Future<List<ProfessionalExperience>> fetchProfessionalExperience(
      BuildContext context) async {
    return _repository.getProfessionalExperience(context);
  }

  Future<bool> postEducation(
      BuildContext context,
      String majorName,
      String schoolName,
      String startDate,
      String endDate,
      String description) async {
    return _repository.postEducation(
        context, majorName, schoolName, startDate, endDate, description);
  }

  Future<bool> postProfessionalExperience(
      BuildContext context,
      String jobName,
      String companyName,
      String startDate,
      String endDate,
      String description) async {
    return _repository.postProfessionalExperience(
        context, jobName, companyName, startDate, endDate, description);
  }

  Future<List<NotificationDev>> fetchNotification(BuildContext context) async {
    return _repository.getNotification(context);
  }

  Future<bool> editDeveloper(
      BuildContext context,
      String genderId,
      String fisrstName,
      String lastName,
      String phoneNumber,
      String dateOfBirth,
      String summary,
      String filePath) async {
    return _repository.EditUser(context, genderId, fisrstName, lastName,
        phoneNumber, dateOfBirth, summary, filePath);
  }

  Future<bool> editEducation(
      BuildContext context,
      int? educationId,
      String? majorName,
      String? schoolName,
      String? startDate,
      String? endDate,
      String? description) async {
    return _repository.editEducation(context, educationId, majorName,
        schoolName, startDate, endDate, description);
  }

  Future<bool> editProfessionalExperience(
      BuildContext context,
      int? professionalExperienceId,
      String? jobName,
      String? companyName,
      String? startDate,
      String? endDate,
      String? description) async {
    return _repository.editProfessionalExperience(
        context,
        professionalExperienceId,
        jobName,
        companyName,
        startDate,
        endDate,
        description);
  }

  Future<User> fetchUserById(BuildContext context) async {
    return _repository.getUserById(context);
  }

  Future<Education> fetchEduationById(BuildContext context) async {
    return _repository.getEducationById(context);
  }

  Future<ProfessionalExperience> fetchProfessionalExperienceById(
      BuildContext context) async {
    return _repository.getProfessionalExperienceById(context);
  }

  Future<User> fetchDeveloperById(BuildContext context) async {
    return _repository.getDeveloperById(context);
  }

  Future<Interview> fetchInterviewById(
      BuildContext context, int? interviewId) async {
    return _repository.getInterViewById(context, interviewId);
  }

  Future<int> countNotification(BuildContext context) async {
    return _repository.getCountNotification(context);
  }

  Future<bool> updatePassword(BuildContext context, String currentPassword,
      String newPassword, String confirmPassword) async {
    return _repository.updatePassword(
        context, currentPassword, newPassword, confirmPassword);
  }

  Future<void> SignIn(String email, String password) async {
    return _repository.SignIn(email, password);
  }

  Future<bool> revokeToken(BuildContext context) async {
    return _repository.revokeToken(context);
  }

  Future<bool> deleteEducation(BuildContext context, int? educationId) async {
    return _repository.deleteEducation(context, educationId);
  }

  Future<bool> deleteProfesstionalExperience(
      BuildContext context, int? professionalId) async {
    return _repository.deleteProfesstionalExperience(context, professionalId);
  }

  Future<bool> readNotification(
      BuildContext context, int? notificationId) async {
    return _repository.readNotification(context, notificationId);
  }

  Future<bool> unNewNotification(BuildContext context) async {
    return _repository.unNewNotification(context);
  }

  Future<bool> checkAndRefreshToken(BuildContext context) async {
    return _repository.checkAndRefreshToken(context);
  }
}
