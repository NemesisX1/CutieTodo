import 'package:cutie_todo_backend/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

///

@JsonSerializable()
class User extends BaseModel {
  ///
  User({
    this.username,
    this.password,
  }) : super();

  ///
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  ///
  final String? username;

  ///
  String? password;

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
