import 'package:cutie_todo_app/core/models/base_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class User extends HiveObject implements BaseModel {
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  @HiveField(0)
  @JsonKey(name: 'key')
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  Map<String, dynamic> toSubmitJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
