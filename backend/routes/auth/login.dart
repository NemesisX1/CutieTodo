import 'dart:io';

import 'package:cutie_todo_backend/controllers/auth.controller.dart';
import 'package:cutie_todo_backend/models/user.model.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final authController = context.read<AuthController>();

  if (request.method == HttpMethod.post) {
    final body = await request.json() as Map<String, dynamic>;

    if (body.keys.length != 2 &&
        !(body.keys.contains('password') && body.keys.contains('username'))) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body: 'Your body should provide a username and a password fields',
      );
    }

    final user = User.fromJson(body);

    return authController.signIn(user);
  }

  return Response(
    statusCode: HttpStatus.methodNotAllowed,
    body: 'This method is not availaible for this route',
  );
}
