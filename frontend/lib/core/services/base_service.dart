import 'package:cutie_todo_app/core/services/logs/logs_service.dart';
import 'package:cutie_todo_app/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract class BaseService {
  Logger get logger {
    final log = locator<LoggerService>()..className = runtimeType.toString();

    return log.logger;
  }
}
