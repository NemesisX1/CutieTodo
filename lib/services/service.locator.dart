import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/services/deta.service.dart';

///

///
void serviceLocator() {
  try {
    locator.registerLazySingleton(
      DetaService.new,
    );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
