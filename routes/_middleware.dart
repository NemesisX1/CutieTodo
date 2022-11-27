import 'dart:developer';

import 'package:dart_deta_frog_todo_server/controllers/auth.controller.dart';
import 'package:dart_deta_frog_todo_server/controllers/todo.controller.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(
        requestLogger(),
      )
      .use(
        provider<TodoController>(
          (context) => TodoController(),
        ),
      )
      .use(
        provider<JwtAuthStrategy>(
          (context) => JwtAuthStrategy(
            jwtSecret: env['JWT_SECRET'],
            expiresIn: const Duration(
              minutes: 15,
            ),
          ),
        ),
      )
      .use(
        provider<AuthController>(
          (context) => AuthController(),
        ),
      );
}
