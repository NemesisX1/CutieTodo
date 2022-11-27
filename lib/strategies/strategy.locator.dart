import 'package:dart_deta_frog_todo_server/controllers/auth.controller.dart';
import 'package:dart_deta_frog_todo_server/controllers/todo.controller.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/strategies/basic_auth.strategy.dart';
import 'package:dart_deta_frog_todo_server/strategies/jwt_auth.strategy.dart';

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
