import 'package:dart_frog/dart_frog.dart';

///
abstract class Strategy {
  ///
  const Strategy();

  /// Handle if the current user is a valide one
  Future<bool> validate(String username, String password);

  /// Handle response when requests headers are not correct.
  /// It return [Response] according to what happens
  Future<Response?> verifyAuth(Map<String, String> headers);
}
