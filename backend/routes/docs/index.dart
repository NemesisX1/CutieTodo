import 'dart:io';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final path = 'specs/swagger.yaml';

  return Response(
    headers: {
      HttpHeaders.contentTypeHeader:
          ContentType('text', 'html', charset: 'utf-8').toString(),
    },
    body: '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta
    name="description"
    content="SwaggerUI"
  />
  <title>Docs</title>
  <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui.css" />
</head>
<body>
<div id="swagger-ui"></div>
<script src="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui-bundle.js" crossorigin></script>

<script>
  window.onload = () => {
    window.ui = SwaggerUIBundle({
      dom_id: '#swagger-ui',
      
      url: "${env['SERVER_BASE_URL']}/swagger.yaml",
      syntaxHighlight: {
        activate: true,
        
      },
    });
  };
</script>
</body>
</html>
''',
  );
}
// docExpansion: '${docExpansion.name}',
//       deepLinking: $deepLink,