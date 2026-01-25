import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'app/app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await DIContainer.init();

    if (kIsWeb) {
      usePathUrlStrategy();
    }

    runApp(ProviderScope(
      observers: [
        TalkerRiverpodObserver(talker: G<Talker>()),
      ],
      child: const GuessSongApp(),
    ));
  }, (error, stack) => G<Talker>().handle(error, stack, 'Something went wrong..'));
}