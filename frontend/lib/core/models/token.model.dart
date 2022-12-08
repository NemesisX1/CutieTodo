import 'package:cutie_todo_app/core/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Token implements BaseModel {
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

  final String token;
  int createdAt;
  final int expiresIn;

  bool get hasExpired {
    final expireTime = createdAt + expiresIn * 1000;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    return !(expireTime > currentTime);
  }

  bool get isEmpty {
    if (token! == '') {
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TokenToJson(this);
  }
}
