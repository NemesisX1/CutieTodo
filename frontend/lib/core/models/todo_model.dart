import 'package:cutie_todo_app/core/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Todo extends BaseModel {
  ///
  Todo({
    this.id,
    this.title,
    this.description,
    this.tags,
    this.isDone,
    this.startAt,
    this.endAt,
    this.userKey,
    this.createdAt,
    this.updatedAt,
  });

  ///
  factory Todo.fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  @JsonKey(name: 'key')
  String? id;

  String? title;

  String? description;

  List<String>? tags;

  bool? isDone;

  DateTime? startAt;

  DateTime? endAt;

  String? userKey;

  DateTime? createdAt;

  DateTime? updatedAt;

  bool get taskIsDone => isDone!;

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
