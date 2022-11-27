import 'package:dart_deta_frog_todo_server/models/base.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.model.g.dart';

///
@JsonSerializable()
class Todo extends BaseModel {
  ///
  Todo({
    this.title,
    this.description,
  }) : super();

  ///
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  ///
  final String? title;

  ///
  final String? description;

  @override
  Todo fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }
}
