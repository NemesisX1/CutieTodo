import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/services/deta.service.dart';

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
