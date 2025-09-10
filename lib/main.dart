import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'api/dio_client.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  talker.debug('Talker started...');

  await dotenv.load(fileName: ".env");

  final sharedPreferences = await SharedPreferences.getInstance();
  final apiClient = YoutubeDioClient(talker);

  final config = Config(
      preferences: sharedPreferences,
      talker: talker,
      apiClient: apiClient
  );

  DIContainer(config).register();

  runApp(ProviderScope(
    observers: [
      TalkerRiverpodObserver(talker: talker),
    ],
    child: GuessSongApp(),
  ));

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack, 'Something went wrong..');
  };
}
