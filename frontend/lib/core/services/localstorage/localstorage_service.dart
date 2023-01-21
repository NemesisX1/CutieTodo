import 'dart:developer';

import 'package:cutie_todo_app/core/services/base_service.dart';
import 'package:hive/hive.dart';

class HiveClassName {
  static const String users = 'users';
  static const String tokens = 'tokens';
}

class LocalStorageService extends BaseService {
  Future<void> save<T extends HiveObject>(
    T data,
    String className, {
    int index = 0,
  }) async {
    try {
      await Hive.openBox<T>(className);
    } catch (e) {}
    try {
      final box = Hive.box<T>(className);
      if (box.isNotEmpty) {
        await box.putAt(index, data);
      } else {
        await box.add(data);
      }
    } catch (e) {
      log('Hive.save $e');
      rethrow;
    }
  }

  Future<void> add<T extends HiveObject>(
    T data,
    String className, {
    String? id,
  }) async {
    try {
      await Hive.openBox<T>(className);
    } catch (e) {}

    try {
      final box = Hive.box<T>(className);
      if (id == null) {
        await box.add(data);
      } else {
        log('localId: $id');
        await box.put(id, data);
      }
    } catch (e) {
      log('Hive.add $e');
      rethrow;
    }
  }

  Future<T?> readData<T extends HiveObject>(
    String className, {
    int index = 0,
  }) async {
    try {
      await Hive.openBox<T>(className);
    } catch (e) {}

    try {
      final box = Hive.box<T>(className);

      final data = box.getAt(index);
      return data;
    } catch (e) {
      log('Hive.readData $e');
    }
  }

  Future<List<T>?> readDatas<T extends HiveObject>(
    String className, {
    int index = 0,
  }) async {
    try {
      await Hive.openBox<T>(className);
    } catch (e) {}

    try {
      final box = Hive.box<T>(className);

      List<T>? data = box.values.toList();
      return data;
    } catch (e) {
      log('Hive.readDatas $e');
      rethrow;
    }
  }

  Future<void> deleteBoxes<T>(String className) async {
    try {
      Box<T> box = Hive.box(className);
      await box.deleteFromDisk().then((value) async {
        await box.close();
      });
    } catch (e) {
      log('Hive.deleteBoxes $e');
      rethrow;
    }
  }
}
