import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
import 'package:get_it/get_it.dart';

///
GetIt locator = GetIt.instance;

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
