import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';

///

///
void modelLocator() {
  try {
    locator.registerLazySingleton(
      Todo.new,
    );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
