import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../repositories/audio_player/audio_player.dart';
import '../repositories/local_storage/local_storage.dart';
import '../repositories/music_api/api/api.dart';
import '../repositories/music_api/music_api.dart';
import '../repositories/theme/theme.dart';

final G = GetIt.instance;

abstract class DIContainer {
  static Future<void> init() async {
    final talker = TalkerFlutter.init();
    talker.debug('Initializing the application...');

    final sharedPreferences = await SharedPreferences.getInstance();
    final iTunesApiClient = ITunesApiDioClient(talker);
    final themeRepository = ThemeRepository(preferences: sharedPreferences);
    final localStorageRepository = LocalStorageRepository(
      preferences: sharedPreferences,
      talker: talker,
    );

    G.registerSingleton<Talker>(talker);
    G.registerSingleton<SharedPreferences>(sharedPreferences);
    G.registerLazySingleton<IMusicApi>(() => iTunesApiClient);
    G.registerSingleton<IThemeRepository>(themeRepository);
    G.registerSingleton<IMusicRepository>(
        ITunesRepository(apiClient: G<IMusicApi >(), talker: talker));
    G.registerSingleton<ILocalStorage>(localStorageRepository);
    G.registerFactory<IAudioPlayer>(() => AudioPlayerRepository(talker));
  }
}