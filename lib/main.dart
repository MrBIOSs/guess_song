import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app/app.dart';
import 'utils/platform/url_strategy_mobile.dart'
    if (dart.library.html) 'utils/platform/url_strategy_web.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await DIContainer.init();
    configureUrlStrategy();

    runApp(ProviderScope(
      observers: [
        TalkerRiverpodObserver(talker: G<Talker>()),
      ],
      child: const GuessSongApp(),
    ));
  }, (error, stack) => G<Talker>().handle(error, stack, 'Something went wrong..'));
}