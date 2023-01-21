import 'package:cutie_todo_app/core/services/api/api_service.dart';
import 'package:cutie_todo_app/core/services/localstorage/localstorage_service.dart';
import 'package:cutie_todo_app/core/services/logs/logs_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Here you register all your services
  locator
    ..registerLazySingleton(ApiService.new)
    ..registerLazySingleton(LoggerService.new)
    ..registerLazySingleton(LocalStorageService.new);

  // locator.registerFactory(() => NotificationViewModel());
}
