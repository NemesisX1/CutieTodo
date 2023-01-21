import 'package:cutie_todo_app/core/models/token_model.dart';
import 'package:cutie_todo_app/core/models/user_model.dart';
import 'package:cutie_todo_app/core/services/api/api_service.dart';
import 'package:cutie_todo_app/core/services/api/endpoints.dart';
import 'package:tuple/tuple.dart';

extension Auth on ApiService {
  Future<Tuple2<User, Token>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await dio.post<Map<String, dynamic>>(
        ApiEndpoint.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      final user = User.fromJson(result.data!);
      final token = Token.fromJson(result.data!)
        ..createdAt = DateTime.now().millisecondsSinceEpoch;

      return Tuple2(user, token);
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

  Future<User> register({
    required String username,
    required String password,
  }) async {
    try {
      final result = await dio.post<Map<String, dynamic>>(
        ApiEndpoint.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      final user = User.fromJson(result.data!);

      return user;
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }
}
