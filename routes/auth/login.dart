import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;
  if (request.method == HttpMethod.post) {}
  return Response(
    statusCode: HttpStatus.methodNotAllowed,
    body: 'This method is not availaible for this route',
  );
}
