import 'package:dart_deta_frog_todo_server/strategies/base.strategy.dart';
import 'package:dart_deta_frog_todo_server/strategies/basic_auth.strategy.dart';

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
  Future<bool> authorize(Map<String, dynamic> headers) async {
    // TODO: implement authorize

    throw UnimplementedError();
  }
}
