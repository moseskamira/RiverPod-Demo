// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    gender: json['gender'] as String?,
    dob: json['dob'] as String?,
    userId: json['userId'] as String?);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dob': instance.dob,
      'userId': instance.userId,
    };
