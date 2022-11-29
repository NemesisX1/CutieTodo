import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    headers: {
      HttpHeaders.contentTypeHeader: ContentType.html.value,
    },
    body:
        "<body>Welcome to Dart Frog of my todo app built on the top of <a href='https://deta.sh'>Deta</a> and Frog!</body>",
  );
}
