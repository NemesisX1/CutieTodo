import 'package:cutie_todo_backend/helpers/enums.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/models/base.model.dart';
import 'package:cutie_todo_backend/models/todo.model.dart';
import 'package:deta/deta.dart';
import 'package:deta/src/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_client_deta_api/dio_client_deta_api.dart';
import 'package:uuid/uuid.dart';

/// Base class to handle Deta cloud storage
class DetaService {
  final _deta = Deta(
    projectKey: env['DETA_KEY']!,
    client: DioClientDetaApi(dio: Dio()),
  );

  /// create a new [T] object in Deta
  Future<T> save<T extends BaseModel>({
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
    } on DetaException catch (e) {
      logger.w('[DetaService]: Error on save(): $e');
      rethrow;
    }
  }

  /// get a [T] object in Deta by key.
  /// It converts the raw data to a [T] instance
  Future<T> getByKey<T extends BaseModel>({
    required DetaName name,
    required String key,
  }) async {
    final base = _deta.base(name.name);

    final modelInstance = locator<T>();

    try {
      final result = await base.get(key);
      return modelInstance.fromJson(result) as T;
    } on DetaException catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  /// delete a new [T] object in Deta given the key
  Future<bool> delete<T extends BaseModel>({
    required DetaName name,
    required String key,
  }) async {
    final base = _deta.base(name.name);

    try {
      final result = await base.delete(key);
      return result;
    } on DetaException catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  /// update a new [T] object in Deta given the
  Future<T> update<T extends BaseModel>({
    required DetaName name,
    required String key,
    required T data,
  }) async {
    final base = _deta.base(name.name);

    final modelInstance = locator<T>();
    final oldData = await getByKey<T>(name: name, key: key);

    try {
      final dataForUpdate = oldData.updateFromJson(data.toJson());

      final result = await base.update(
        key: key,
        item: dataForUpdate.toJson(),
      );

      return modelInstance.fromJson(
        result as Map<String, dynamic>,
      ) as T;
    } on DetaException catch (e) {
      logger.w('[DetaService]: Error on update(): $e');
      rethrow;
    }
  }

  /// return a list of [T] object from Deta
  Future<List<T>> get<T extends BaseModel>({
    required DetaName name,
    List<DetaQuery>? query,
    int limit = 1000,
  }) async {
    final base = _deta.base(name.name);

    final datas = <T>[];
    final modelInstance = locator<T>();

    try {
      await base
          .fetch(
        query: query ?? [],
        limit: limit,
      )
          .then((value) {
        for (final element in value['items'] as List) {
          final data =
              modelInstance.fromJson(element as Map<String, dynamic>) as T;

          datas.add(data);
        }
      });
    } on DetaException catch (e) {
      logger.w('[DetaService]: Error on get(): $e');
      rethrow;
    }

    return datas;
  }
}
