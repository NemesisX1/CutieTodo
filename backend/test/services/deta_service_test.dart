import 'dart:developer';

import 'package:cutie_todo_backend/helpers/enums.dart';
import 'package:cutie_todo_backend/models/model.locator.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:cutie_todo_backend/services/deta.service.dart';
import 'package:test/test.dart';

void main() {
  setUp(modelLocator);
  group('DetaSevice', () {
    final deta = DetaService();
    const testTodoKey = '08efdb61-9ede-4432-a644-af42ace3af42';

    test('can be instancied', () {
      expect(DetaService(), isNotNull);
    });

    test('can save data', () async {
      final todo = await deta.save<Todo>(
        name: DetaName.todos,
        data: Todo(
          title: 'This is a test',
          description: 'This is a description',
          tags: [
            'Design',
            'Check',
          ],
        ),
      );

      expect(todo, isNotNull);
      expect(testTodoKey, isNotNull);
      expect(testTodoKey, isNotEmpty);
    });

    test('can get data by key', () async {
      expect(testTodoKey, isNotEmpty);

      final todo = await deta.getByKey<Todo>(
        name: DetaName.todos,
        key: testTodoKey,
      );
      expect(todo, isNotNull);
    });

    test('can update data by key', () async {
      expect(testTodoKey, isNotEmpty);

      final todo = await deta.update<Todo>(
        name: DetaName.todos,
        key: testTodoKey,
        data: Todo(
          title: 'Ceci est un test updated',
          description: 'Ceci est une description updated',
        ),
      );
      expect(todo, isNotNull);
    });

    test('can get all the data', () async {
      final todos = await deta.get<Todo>(
        name: DetaName.todos,
      );
      expect(todos, isNotNull);
      expect(todos, isNotEmpty);
    });
  });
}
