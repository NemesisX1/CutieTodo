// ignore_for_file: avoid_catching_errors

import 'dart:io';
import 'package:bcrypt/bcrypt.dart';
import 'package:cutie_todo_backend/helpers/enums.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/models/user.model.dart';
import 'package:cutie_todo_backend/services/deta.service.dart';
import 'package:cutie_todo_backend/strategies/base.strategy.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:deta/deta.dart';

///
class JwtAuthStrategy extends Strategy {
  ///
  JwtAuthStrategy({
    required this.jwtSecret,
    required this.expiresIn,
  }) : super();

  final _detaService = locator<DetaService>();

  ///
  final Duration expiresIn;

  ///
  final String? jwtSecret;

  /// a simple function to dcode jwt token
  User decode(String bearerToken) {
    final jwt = JWT.verify(bearerToken, SecretKey(jwtSecret!));

    return User.fromJson(jwt.payload as Map<String, dynamic>);
  }

  /// Function to create jwt token from a user instance
  String sign(User user) {
    final jwt = JWT({
      'key': user.key,
      'username': user.username,
    });
    return jwt.sign(
      SecretKey(jwtSecret!),
      expiresIn: expiresIn,
    );
  }

  @override
  Future<bool> validate(String username, String password) async {
    try {
      final users = await _detaService.get<User>(
        name: DetaName.users,
        query: [
          DetaQuery('username').equalTo(username),
        ],
      );

      if (users.isEmpty) {
        return false;
      }

      if (!BCrypt.checkpw(password, users.first.password!)) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Response?> verifyAuth(Map<String, String> headers) async {
    if (jwtSecret == null) {
      logger.w('[JwtAuthStrategy] Your jwtSecret were not defined !');
      return null;
    }

    String? bearerToken;

    for (final element in headers.keys) {
      if (element.toLowerCase() == HttpHeaders.authorizationHeader) {
        bearerToken = headers[element]!.split(' ').last;
      }
    }

    if (bearerToken == null) {
      return Response(
        statusCode: HttpStatus.badRequest,
        body:
            'Bad Request. You need to provide a bearer token to access this ressources !',
      );
    }

    try {
      JWT.verify(bearerToken, SecretKey(jwtSecret!));
    } on JWTExpiredError {
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Token expired !',
      );
    } catch (e) {
      logger.w('[JwtAuthStrategy]: And error occured: ${e.toString()}');
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Bad formatted token !',
      );
    }

    return null;
  }
}
