// class User {
//   final int userId;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String phoneNumber;
//   final String dateOfBirth;
//   final String userImage;
//   final String statusString;
//   final String roleString;
//   final String developerId;

//   User({
//     required this.userId,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneNumber,
//     required this.dateOfBirth,
//     required this.userImage,
//     required this.statusString,
//     required this.roleString,
//     required this.developerId,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['userId'] as int,
//       email: json['email'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       phoneNumber: json['phoneNumber'],
//       dateOfBirth: json['dateOfBirth'],
//       userImage: json['userImage'],
//       statusString: json['statusString'],
//       roleString: json['roleString'],
//       developerId: json['developerId'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'email': email,
//       'firstName': firstName,
//       'lastName': lastName,
//       'phoneNumber': phoneNumber,
//       'dateOfBirth': dateOfBirth,
//       'userImage': userImage,
//       'statusString': statusString,
//       'roleString': roleString,
//       'developerId': developerId,
//     };
//   }
// }
import 'package:json_annotation/json_annotation.dart';
import 'package:we_hire/src/features/authentication/models/level.dart';
import 'package:we_hire/src/features/authentication/models/skill.dart';
import 'package:we_hire/src/features/authentication/models/type.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? dateOfBirth;
  String? summary;
  String? userImage;
  String? statusString;
  String? roleString;
  String? genderName;
  String? devStatusString;
  String? userStatusString;
  String? employementTypeName;
  String? levelRequireStrings;
  int? yearOfExperience;
  int? averageSalary;
  int? developerId;
  Level? level;
  List<Skills>? skills;
  List<Types>? types;

  User(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.dateOfBirth,
      this.summary,
      this.userImage,
      this.roleString,
      this.developerId,
      this.averageSalary,
      this.devStatusString,
      this.employementTypeName,
      this.genderName,
      this.levelRequireStrings,
      this.level,
      this.skills,
      this.types,
      this.password,
      this.userStatusString,
      this.yearOfExperience});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
