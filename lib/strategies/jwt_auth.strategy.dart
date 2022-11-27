// ignore_for_file: avoid_catching_errors

import 'dart:io';

import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/strategies/base.strategy.dart';
import 'package:dart_deta_frog_todo_server/strategies/basic_auth.strategy.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

///
class JwtAuthStrategy extends Strategy {
  ///
  const JwtAuthStrategy({
    required this.jwtSecret,
    required this.expiresIn,
  });

  ///
  final Duration expiresIn;

  ///
  final String jwtSecret;

  @override
  Future<dynamic> validate(Map<String, String> headers) async {
    String? bearerToken;

    for (final element in headers.keys) {
      if (element.toLowerCase() == HttpHeaders.authorizationHeader) {
        bearerToken = headers[element]!.split(' ').last;
      }
    }

    if (bearerToken == null) {
      return null;
    }

    try {
      // Verify a token
      final jwt = JWT.verify(bearerToken, SecretKey(jwtSecret));

      logger
          .i('[JwtAuthStrategy] validate(): The jwt decoded is ${jwt.payload}');
      return jwt.payload;
    } on JWTExpiredError catch (e) {
      logger.v('[JwtAuthStrategy] validate(): Token expired  ${e.message}');
      rethrow;
    } on JWTError catch (e) {
      logger.v('[JwtAuthStrategy] validate(): Token expired  ${e.message}');
      rethrow;
    }
  }
}
