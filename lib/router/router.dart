import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/di.dart';
import '../features/game_flow/game/game.dart';
import '../features/game_flow/game_setup/game_setup.dart';
import '../features/game_flow/game_summary/game_summary.dart';
import '../features/not_found/not_found_screen.dart';
import '../features/settings/settings.dart';

abstract class AppRoute {
  AppRoute._();
  static const root = '/';

  static const gameSetup = '/game-setup';
  static const game = '/game';
  static const gameSummary = '/summary';

  static const settings = '/settings';
}

final router = GoRouter(
  observers: [
    TalkerRouteObserver(G<Talker>()),
  ],
  errorBuilder: (_, __) => const NotFoundScreen(),
  routes: [
    GoRoute(
      path: AppRoute.root,
      redirect: (_, __) => AppRoute.gameSetup,
    ),
    GoRoute(
      path: AppRoute.gameSetup,
      builder: (_, __) => const GameSetupScreen(),
    ),
    GoRoute(
      path: AppRoute.game,
      builder: (_, __) => const GameScreen(),
      routes: [
        GoRoute(
          path: AppRoute.gameSummary,
          builder: (_, __) => const GameSummaryScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.settings,
      builder: (_, __) => const SettingsScreen(),
    ),
  ],
);