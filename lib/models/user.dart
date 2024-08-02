import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? firstName;
  final String lastName;
  final String gender;
  final String dob;

  User({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
