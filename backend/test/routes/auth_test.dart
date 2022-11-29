import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/auth/login.dart' as loginRoute;
import '../../routes/auth/register.dart' as registerRoute;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test('responds with a 200 and "Welcome to Dart Frog!".', () async {
      final context = _MockRequestContext();
      final response = await registerRoute.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(equals(
            "<body>Welcome to Dart Frog of my todo app built on the top of <a href='https://deta.sh'>Deta</a> and Frog!</body>")),
      );
    });
  });
}
