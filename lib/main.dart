import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app/app.dart';

Future<void> main() async {
  await DIContainer.init();

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(ProviderScope(
      observers: [
        TalkerRiverpodObserver(talker: G<Talker>()),
      ],
      child: const GuessSongApp(),
    ));
  }, (error, stack) => G<Talker>().handle(error, stack, 'Something went wrong..'));
}