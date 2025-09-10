import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../api/dio_client.dart';
import 'config.dart';

final G = GetIt.instance;

class DIContainer {
  const DIContainer(this.config);
  final Config config;

  void register() {
    G.registerSingleton<Talker>(config.talker);
    G.registerSingleton<YoutubeDioClient>(config.apiClient);
    G.registerSingleton<SharedPreferences>(config.preferences);
  }
}