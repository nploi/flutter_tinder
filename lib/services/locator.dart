import 'package:flutter_tinder/data/database_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'navigation.dart';
import 'storage_device.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  time_ago.setLocaleMessages('vi', time_ago.ViMessages());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<StorageDeviceService>(
      () => StorageDeviceService());
  locator.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
  await locator<StorageDeviceService>().boot();
  await locator<DatabaseProvider>().boot();
}
