import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt locator = GetIt.instance;

@injectableInit
Future<void> initializeServiceLocator() async => $initGetIt(locator);