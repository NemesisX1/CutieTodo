import 'package:cutie_todo_app/core/models/base_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class Token extends HiveObject implements BaseModel {
  Token({
    required this.token,
    required this.expiresIn,
    required this.createdAt,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    final tokenInstance = _$TokenFromJson(json)
      ..createdAt = DateTime.now().millisecondsSinceEpoch;
    return tokenInstance;
  }

  @HiveField(0)
  final String token;
  @HiveField(1)
  int createdAt;
  @HiveField(2)
  final int expiresIn;

  bool get hasExpired {
    final expireTime = createdAt + expiresIn * 1000;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    return !(expireTime > currentTime);
  }

  bool get isEmpty {
    if (token == '') {
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TokenToJson(this);
  }
}
