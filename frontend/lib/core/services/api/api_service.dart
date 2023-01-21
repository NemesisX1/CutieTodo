import 'package:cutie_todo_app/core/services/base_service.dart';
import 'package:dio/dio.dart';

class ApiService extends BaseService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://cutietodo-production.up.railway.app',
    ),
  );

  Dio get dio => _dio;
}
