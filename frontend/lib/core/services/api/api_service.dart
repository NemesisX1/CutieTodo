import 'package:cutie_todo_app/core/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService extends BaseService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  );

  Dio get dio => _dio;
}
