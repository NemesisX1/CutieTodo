import 'dart:io';

import 'package:dart_deta_frog_todo_server/controllers/todo.controller.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
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
    statusCode: HttpStatus.notAcceptable,
    body: 'This method is not availaible for this route',
  );
}
