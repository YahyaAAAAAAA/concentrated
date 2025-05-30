import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/di/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
