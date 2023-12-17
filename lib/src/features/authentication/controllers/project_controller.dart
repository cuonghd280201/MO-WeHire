import 'package:flutter/material.dart';
import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class ProjectController {
  final Repository _repository;

  ProjectController(this._repository);
  Future<List<Project>> fetchProjectList(
      BuildContext context, List<int> devStatusInProject) async {
    return _repository.getProject(context, devStatusInProject);
  }

  Future<List<Project>> searchProject(BuildContext context, int? devId,
      List<int> devStatusInProject, String? searchKeyString) async {
    return _repository.searchProject(
        context, devId, devStatusInProject, searchKeyString);
  }

  Future<Project> fetchProjectById(BuildContext context, int? projectId) async {
    return _repository.getProjectById(context, projectId);
  }
}
