// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      summary: json['summary'] as String?,
      userImage: json['userImage'] as String?,
      userStatusString: json['userStatusString'] as String?,
      roleString: json['roleString'] as String?,
      developerId: json['developerId'] as int?,
      levelRequireStrings: json['levelRequireStrings'] as String?,
      averageSalary: json['averageSalary'] as int?,
      devStatusString: json['devStatusString'] as String?,
      employementTypeName: json['employementTypeName'] as String?,
      genderName: json['genderName'] as String?,
      yearOfExperience: json['yearOfExperience'] as int?,
      level: json['level'] != null ? Level.fromJson(json['level']) : null,
      skills: (json['skills'] != null)
          ? List<Skills>.from(json['skills'].map((x) => Skills.fromJson(x)))
          : null,
      types: (json['types'] != null)
          ? List<Types>.from(json['types'].map((x) => Types.fromJson(x)))
          : null,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'userImage': instance.userImage,
      'statusString': instance.statusString,
      'roleString': instance.roleString,
      'developerId': instance.developerId,
      'levelRequireStrings': instance.levelRequireStrings,
      'averageSalary': instance.averageSalary,
      'devStatusString': instance.devStatusString,
    };
