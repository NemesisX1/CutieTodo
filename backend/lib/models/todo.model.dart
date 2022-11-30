import 'package:cutie_todo_backend/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.model.g.dart';

///
@JsonSerializable()
class Todo extends BaseModel {
  ///
  Todo({
    this.title,
    this.description,
    this.isDone = false,
    this.userKey,
    this.tags,
    this.startAt,
    this.endAt,
  }) : super();

  ///
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  ///
  final bool isDone;

  ///
  final String? title;

  ///
  final String? description;

  ///
  String? userKey;

  ///
  final List<String>? tags;

  ///
  final DateTime? startAt;

  ///
  final DateTime? endAt;

  @override
  Todo fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
