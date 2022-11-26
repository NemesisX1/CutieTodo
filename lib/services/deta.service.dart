import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/models/base.model.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
import 'package:deta/deta.dart';
import 'package:deta/src/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_client_deta_api/dio_client_deta_api.dart';
import 'package:uuid/uuid.dart';

///
class DetaService {
  ///

  final _deta = Deta(
    projectKey: env['DETA_KEY']!,
    client: DioClientDetaApi(dio: Dio()),
  );

  ///
  Future<T> save<T extends Model>({
    required DetaName name,
    required T data,
  }) async {
    final base = _deta.base(name.name);
    data
      ..key = const Uuid().v4()
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    try {
      await base.put(data.toJson());
      return data;
    } catch (e) {
      logger.w('[DetaService]: Error on save(): $e');
      rethrow;
    }
  }

  ///
  Future<T> getByKey<T extends Model>({
    required DetaName name,
    required String key,
  }) async {
    final base = _deta.base(name.name);

    final modelInstance = locator<T>();

    try {
      final result = await base.get(key);
      return modelInstance.fromJson(result) as T;
    } catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  ///
  Future<bool> delete<T extends Model>({
    required DetaName name,
    required String key,
  }) async {
    final base = _deta.base(name.name);

    try {
      final result = await base.delete(key);
      return result;
    } catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  ///
  Future<T> update<T extends Model>({
    required DetaName name,
    required String key,
    required T data,
  }) async {
    final base = _deta.base(name.name);

    final modelInstance = locator<T>();

    try {
      final result = await base.update(key: key, item: data.toJson());

      return modelInstance.fromJson(
        result as Map<String, dynamic>,
      ) as T;
    } catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  ///
  Future<List<T>> get<T extends Model>({
    required DetaName name,
  }) async {
    final base = _deta.base(name.name);

    final datas = <T>[];
    final modelInstance = locator<T>();

    try {
      await base.fetch().then((value) {
        for (final element in value['items'] as List) {
          final data =
              modelInstance.fromJson(element as Map<String, dynamic>) as T;

          datas.add(data);
        }
      });
    } catch (e) {
      logger.w('[DetaService]: Error on get(): $e');
      rethrow;
    }

    return datas;
  }
}
