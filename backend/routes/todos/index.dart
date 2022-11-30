import 'dart:io';

import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final todoController = context.read<TodoController>();
  final jwtStrategy = context.read<JwtAuthStrategy>();

  final authResponse = await jwtStrategy.verifyAuth(request.headers);

  if (authResponse == null) {
    final jwtUser = jwtStrategy.decode(
      request.headers[HttpHeaders.authorizationHeader]!.split(' ').last,
    );

    final body = await request.json() as Map<String, dynamic>;

    switch (request.method) {
      case HttpMethod.get:
        return todoController.getByUserId(jwtUser.key!);

      case HttpMethod.post:
        if (!(body.containsKey('title') &&
            body.containsKey('description') &&
            body.containsKey('startAt'))) {
          return Response(
            statusCode: HttpStatus.badRequest,
            body:
                'Your body should provide at least a userId, a title and startAt (timestamp) field',
          );
        }
        if (body.containsKey('key') ||
            body.containsKey('userKey') ||
            body.containsKey('createdAt') ||
            body.containsKey('updatedAt')) {
          return Response(
            statusCode: HttpStatus.badRequest,
            body:
                'Only the title, description, startAt, endAt and isDone fields are allowed',
          );
        }

        final todo = Todo.fromJson(body);
        todo.userKey = jwtUser.key;

        return todoController.create(todo);
    }
    return Response(
      statusCode: HttpStatus.methodNotAllowed,
      body: 'This method is not availaible for this route',
    );
  } else {
    return authResponse;
  }
}
