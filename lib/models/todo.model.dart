import 'base.model.dart';

///
///
class Todo extends Model {
  ///
  Todo({
    this.title,
    this.description,
  }) : super();

  ///
  final String? title;

  ///
  final String? description;

  @override
  Todo fromJson(Map<String, dynamic> json) {
    final todo = Todo(
      title: json['title'] as String?,
      description: json['description'] as String?,
    )
      ..key = json['key'] as String?
      ..createdAt = DateTime.tryParse(json['createdAt'] as String)
      ..updatedAt = DateTime.tryParse(json['updatedAt'] as String);

    return todo;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
