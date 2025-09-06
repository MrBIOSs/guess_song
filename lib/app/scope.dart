import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'config.dart';
import 'guess_song_app.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override this provider in ProviderScope');
});

class Scope extends StatelessWidget {
  const Scope ({super.key, required this.config});
  final Config config;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [
        TalkerRiverpodObserver(
          talker: config.talker,
        ),
      ],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(config.preferences),
      ],
      child: GuessSongApp(),
    );
  }
}
