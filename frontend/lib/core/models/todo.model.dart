import 'package:cutie_todo_app/core/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Todo extends BaseModel {
  ///
  Todo({
    required this.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.isDone,
    required this.startAt,
    required this.endAt,
    required this.userKey,
    required this.createdAt,
    required this.updatedAt,
  });

  ///
  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  final String key;
  final String title;
  final String description;
  final List<String>? tags;
  final bool isDone;
  final DateTime? startAt;
  final DateTime? endAt;
  final String userKey;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get taskIsDone => isDone;

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
