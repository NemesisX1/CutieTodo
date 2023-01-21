import 'package:cutie_todo_app/core/models/todo_model.dart';
import 'package:cutie_todo_app/core/services/api/api_service.dart';
import 'package:cutie_todo_app/core/services/api/endpoints.dart';

extension Todos on ApiService {
  Future<List<Todo>> getTodos() async {
    final todos = <Todo>[];

    try {
      final result = await dio.get<List<Map<String, dynamic>>>(
        ApiEndpoint.todos,
      );

      for (final element in result.data!) {
        todos.add(Todo.fromJson(element));
      }
    } catch (e) {
      logger.d(e);
      rethrow;
    }

    return todos;
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final result = await dio.post<Map<String, dynamic>>(
        ApiEndpoint.todos,
        data: {
          'title': todo.title,
          'description': todo.description,
          'tags': todo.tags,
          'startAt': DateTime.now().toIso8601String(),
          'endAt': DateTime.now().toIso8601String(),
        },
      );

      return Todo.fromJson(result.data!);
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  Future<Todo> updateTodo({
    required Todo todo,
    required String key,
  }) async {
    final data = <String, dynamic>{};

    todo.toJson().forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    try {
      final result = await dio.put<Map<String, dynamic>>(
        '${ApiEndpoint.todos}/$key',
        data: data,
      );

      return Todo.fromJson(result.data!);
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String key) async {
    try {
      await dio.delete<Map<String, dynamic>>(
        '${ApiEndpoint.todos}/$key',
      );
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }
}
