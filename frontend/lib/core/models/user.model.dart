import 'package:cutie_todo_app/core/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends BaseModel {
  User({
    required this.key,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toSubmitJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  final String key;
  final String username;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
