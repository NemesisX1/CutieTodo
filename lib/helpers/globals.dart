import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

///
DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

///
GetIt locator = GetIt.instance;

///
final logger = Logger();
