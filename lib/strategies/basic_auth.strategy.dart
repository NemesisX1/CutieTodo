import 'package:dart_deta_frog_todo_server/strategies/base.strategy.dart';

///
class BasicAuthStrategy extends Strategy {
  ///
  const BasicAuthStrategy();

  @override
  Future<bool> authorize(Map<String, dynamic> headers) async {
    throw UnimplementedError();
  }
}
