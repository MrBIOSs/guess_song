import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../api/itunes_dio_client.dart';

final G = GetIt.instance;

abstract class DIContainer {
  static Future<void> init() async {
    final talker = TalkerFlutter.init();
    talker.debug('Initializing the application...');

    final sharedPreferences = await SharedPreferences.getInstance();
    final iTunesApiClient = ITunesApiDioClient(talker);

    G.registerSingleton<Talker>(talker);
    G.registerSingleton<SharedPreferences>(sharedPreferences);
    G.registerSingleton<ITunesApiDioClient>(iTunesApiClient);
  }
}