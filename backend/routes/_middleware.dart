import 'dart:developer';

import 'package:cutie_todo_backend/controllers/auth.controller.dart';
import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';
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
