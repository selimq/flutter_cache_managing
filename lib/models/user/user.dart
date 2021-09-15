import 'package:flutter_app/models/baseModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends IBaseModel<User> {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? dateOfBirth;
  User({this.id, this.firstName, this.lastName, this.dateOfBirth, this.email});

  Map<String, dynamic> toJson() => _$UserToJson(this);
  User fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}
