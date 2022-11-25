import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/helpers/env.dart';
import 'package:dart_deta_frog_todo_server/models/base.model.dart';
import 'package:dart_deta_frog_todo_server/models/model.locator.dart';
import 'package:deta/deta.dart';
import 'package:dio/dio.dart';
import 'package:dio_client_deta_api/dio_client_deta_api.dart';

import 'package:uuid/uuid.dart';

///
class DetaService {
  ///
  DetaService() {
    modelLocator();
  }

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

    await base.put(data.toJson());
    return data;
  }

  ///
  Future<T> getByKey<T extends Model>({
    required DetaName name,
    required String key,
  }) async {
    final base = _deta.base(name.name);
    final result = await base.get(key);
    final modelInstance = locator<T>();

    return modelInstance.fromJson(result) as T;
  }

  ///
  Future<List<T>> get<T extends Model>({
    required DetaName name,
  }) async {
    final base = _deta.base(name.name);
    final result = await base.fetch();
    final datas = <T>[];
    final modelInstance = locator<T>();

    for (final element in result['items'] as List) {
      datas.add(modelInstance.fromJson(element as Map<String, dynamic>) as T);
    }

    return datas;
  }
}
