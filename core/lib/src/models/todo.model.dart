import 'package:deta_frog_todo_core/src/models/abstract.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.model.g.dart';

///
@JsonSerializable()
class Todo extends AbstractModel {
  ///
  Todo({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
  });

  ///
  final String? id;

  ///
  final String title;

  ///
  final String description;

  ///
  late DateTime? updatedAt = DateTime.now();

  ///
  DateTime? createdAt;

  @override
  Map<String, dynamic> toJson() {
    return _$TodoToJson(this);
  }

  @override
  Todo fromJson(Map<String, dynamic> json) {
    return _$TodoFromJson(json);
  }
}
