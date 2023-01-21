import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cutie_todo_app/core/models/token_model.dart';
import 'package:cutie_todo_app/core/models/user_model.dart';
import 'package:cutie_todo_app/core/services/localstorage/localstorage_service.dart';
import 'package:cutie_todo_app/firebase_options.dart';
import 'package:cutie_todo_app/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> initAppServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive
    ..registerAdapter(UserAdapter())
    ..registerAdapter(TokenAdapter());
  await Hive.openBox<User>(HiveClassName.users);
  await Hive.openBox<Token>(HiveClassName.tokens);

  await dotenv.load();

  setupLocator();
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await initAppServices();

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
