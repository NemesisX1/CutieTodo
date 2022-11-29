import 'dart:developer';
import 'dart:io';

import 'package:cutie_todo_backend/controllers/todo.controller.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final todoController = context.read<TodoController>();
  final jwtStrategy = context.read<JwtAuthStrategy>();

  final authResponse = await jwtStrategy.verifyAuth(request.headers);

  if (authResponse == null) {
    final jwtUser = jwtStrategy.decode(
      request.headers[HttpHeaders.authorizationHeader]!.split(' ').last,
    );

    switch (request.method) {
      case HttpMethod.get:
        return todoController.getByUserId(jwtUser.key!);

      case HttpMethod.put:
        final todo =
            Todo.fromJson(await request.json() as Map<String, dynamic>);
        return todoController.update(id, todo);

      case HttpMethod.delete:
        return todoController.delete(id);
    }
    return Response(
      statusCode: HttpStatus.notAcceptable,
      body: 'This method is not availaible for this route',
    );
  } else {
    return authResponse;
  }
}
