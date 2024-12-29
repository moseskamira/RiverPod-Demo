import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? firstName;
  String? lastName;
  String? gender;
  String? dob;

  User({
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
