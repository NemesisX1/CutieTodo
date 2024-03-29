import 'package:cutie_todo_backend/controllers/auth.controller.dart';
import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';

/// locator to complete dependiencies injection
/// in the whole app
void controllerLocator() {
  try {
    locator
      ..registerLazySingleton(
        TodoController.new,
      )
      ..registerLazySingleton(
        AuthController.new,
      );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
