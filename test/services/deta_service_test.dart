import 'dart:developer';

import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
import 'package:dart_deta_frog_todo_server/services/deta.service.dart';
import 'package:test/test.dart';

void main() {
  group('DetaSevice', () {
    final deta = DetaService();
    String? _testTodoKey;

    test('can be instancied', () {
      expect(DetaService(), isNotNull);
    });

    test('can save data', () async {
      final todo = await deta.save<Todo>(
        name: DetaName.todos,
        data: Todo(
          title: 'This is a test',
          description: 'This is a description',
        ),
      );
      _testTodoKey = todo.key;
      expect(todo, isNotNull);
      expect(_testTodoKey, isNotNull);
      expect(_testTodoKey, isNotEmpty);
    });

    if (_testTodoKey != null) {
      test('can get data by key', () async {
        expect(_testTodoKey, isNotEmpty);

        final todo = await deta.getByKey<Todo>(
          name: DetaName.todos,
          key: _testTodoKey!,
        );
        expect(todo, isNotNull);
      });
    }

    test('can get all the data', () async {
      final todos = await deta.get<Todo>(
        name: DetaName.todos,
      );
      expect(todos, isNotNull);
      expect(todos, isNotEmpty);
    });
  });
}
