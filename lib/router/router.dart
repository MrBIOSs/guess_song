import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/di.dart';
import '../features/game_flow/view/game/view/game_screen.dart';
import '../features/game_flow/view/game_setup/view/game_setup_screen.dart';
import '../features/game_flow/view/game_summary/view/game_summary_screen.dart';
import '../features/not_found/not_found_screen.dart';

abstract class AppRoute {
  static const root = '/';

  static const gameSetup = '/game-setup';
  static const game = '/game';
  static const gameSummary = '/summary';
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
  ],
);