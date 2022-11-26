import 'dart:developer';

import 'package:dart_deta_frog_todo_server/controllers/todo.controller.dart';
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
      );
}
