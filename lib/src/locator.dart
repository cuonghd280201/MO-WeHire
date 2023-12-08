import 'package:get_it/get_it.dart';
import 'package:we_hire/src/service/dev_service.dart';
import 'package:we_hire/src/service/service.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerFactory(() => Service());
}
