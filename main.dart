import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'lib/controllers/controller.locator.dart';
import 'lib/models/model.locator.dart';
import 'lib/services/service.locator.dart';
import 'lib/strategies/strategy.locator.dart';

void setupLocator() {
  modelLocator();
  controllerLocator();
  serviceLocator();
  strategyLocator();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  // 1. Execute any custom code prior to starting the server...

  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.
  setupLocator();
  return serve(handler, ip, port);
}
