import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/helpers/env.dart';
import 'package:dart_deta_frog_todo_server/models/base.model.dart';
import 'package:deta/deta.dart';
import 'package:dio/dio.dart';
import 'package:dio_client_deta_api/dio_client_deta_api.dart';

import 'package:uuid/uuid.dart';

///
class DetaService {
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

    T? data;

    return data!.fromJson(result) as T;
  }

  ///
  // Future<Map<String, dynamic>> get<T extends Model>({
  //   required DetaName name,
  // }) async {
  //   final base = _deta.base(name.name);
  //   final result = await base.fetch();
  //   // final data = <T>[];

  //   // T? data;

  //   return result;
  // }

  Future<List<T>> get<T extends Model>({
    required DetaName name,
  }) async {
    final base = _deta.base(name.name);
    final result = await base.fetch();
    final items = result['items'] as List;
    final datas = <T>[];

    for (final element in items) {
      T? data;

      print(T.runtimeType);

      //     datas.add(data!.fromJson(element as Map<String, dynamic>) as T);
    }

    return datas;
  }
}
