import 'package:we_hire/src/features/authentication/models/project.dart';
import 'package:we_hire/src/features/authentication/repository/repository.dart';

class ProjectController {
  final Repository _repository;

  ProjectController(this._repository);
  Future<List<Project>> fetchProjectList(String? devStatusInProject) async {
    return _repository.getProject(devStatusInProject);
  }

  Future<List<Project>> searchProject(
      int? devId, String? devStatusInProject, String? searchKeyString) async {
    return _repository.searchProject(
        devId, devStatusInProject, searchKeyString);
  }

  Future<Project> fetchProjectById(int? projectId) async {
    return _repository.getProjectById(projectId);
  }
}
