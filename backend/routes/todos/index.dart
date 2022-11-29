import 'dart:io';

import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final todoController = context.read<TodoController>();

  switch (request.method) {
    case HttpMethod.get:
      return todoController.get();

    case HttpMethod.post:
      final todo = Todo.fromJson(await request.json() as Map<String, dynamic>);
      return todoController.create(todo);
  }
  return Response(
    statusCode: HttpStatus.methodNotAllowed,
    body: 'This method is not availaible for this route',
  );
}
