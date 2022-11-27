import 'package:dart_frog/dart_frog.dart';

///
abstract class Strategy {
  ///
  const Strategy();

  /// Throw
  Future<Response?> verifyAuth(Map<String, String> headers);

  ///
  Future<bool> validate(String username, String password);
}
