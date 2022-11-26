import 'package:dart_deta_frog_todo_server/controllers/todo.controller.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';

///
void controllerLocator() {
  try {
    locator.registerLazySingleton(
      TodoController.new,
    );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
