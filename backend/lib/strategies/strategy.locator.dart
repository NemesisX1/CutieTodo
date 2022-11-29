import 'package:cutie_todo_backend/controllers/auth.controller.dart';
import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/strategies/basic_auth.strategy.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';

///
void strategyLocator() {
  try {
    locator
      ..registerLazySingleton(
        BasicAuthStrategy.new,
      )
      ..registerLazySingleton(
        () => JwtAuthStrategy(
          jwtSecret: env['JWT_SECRET'],
          expiresIn: const Duration(
            minutes: 15,
          ),
        ),
      );
  } catch (e) {
    /// just to avoid re insert insite the locator
  }
}
