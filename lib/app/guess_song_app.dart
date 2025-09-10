import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/theme_provider.dart';
import '../router/router.dart';
import '../ui/theme/theme.dart';

class GuessSongApp extends ConsumerWidget {
  const GuessSongApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider).themeMode;

    return MaterialApp.router(
      title: 'Guess Song',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}