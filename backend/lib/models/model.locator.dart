import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:cutie_todo_backend/models/user.model.dart';

///

///
void modelLocator() {
  try {
    locator
      ..registerLazySingleton(
        Todo.new,
      )
      ..registerLazySingleton(
        User.new,
      );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
