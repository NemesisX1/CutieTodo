import 'package:cutie_todo_backend/models/user.model.dart';
import 'package:cutie_todo_backend/strategies/base.strategy.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:tuple/tuple.dart';

///
class BasicAuthStrategy extends Strategy {
  ///
  const BasicAuthStrategy();

  @override
  Future<Response?> verifyAuth(Map<String, String> headers) {
    // TODO: implement verifyAuth
    throw UnimplementedError();
  }

  @override
  Future<bool> validate(String username, String password) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
