import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
import 'package:dart_deta_frog_todo_server/services/deta.service.dart';
import 'package:test/test.dart';

void main() {
  group('DetaSevice', () {
    final deta = DetaService();

    test('can be instancied', () {
      expect(DetaService(), isNotNull);
    });

    test('can save data', () async {
      final todo = await deta.save(
        name: DetaName.todos,
        data: Todo(
          title: 'This is a test',
          description: 'This is a description',
        ),
      );
      expect(todo, isNotNull);
    });
  });
}
