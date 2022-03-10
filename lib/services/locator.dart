import 'package:get_it/get_it.dart';
import 'package:pinsmap/services/analytics.dart';
import 'package:pinsmap/services/dynamic_links.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => AnalyticsService());
  // locator.registerLazySingleton(() => DynamicLinkService());
}