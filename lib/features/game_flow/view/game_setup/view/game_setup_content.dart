import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../router/router.dart';
import '../../../../../ui/theme/theme.dart';
import '../../../logic/game_provider.dart';
import '../../../models/game_config.dart';
import '../../widgets/widgets.dart';
import 'widgets/widgets.dart';

class GameSetupContent  extends ConsumerStatefulWidget {
  const GameSetupContent ({super.key});

  @override
  ConsumerState<GameSetupContent > createState() => _GameSetupContentState();
}

class _GameSetupContentState extends ConsumerState<GameSetupContent > {
  String _version = '';

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    ref.listen(gameProvider, (previous, next) {
      if (next.questions.isNotEmpty && previous?.questions.isEmpty == true) {
        context.go(AppRoute.game);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.accentColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.music_note, size: 48, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          'Guess Song',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Theme.of(context).titleTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Test your music knowledge!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).bodyTextColor,
          ),
        ),
        const SizedBox(height: 38),
        BaseTextField(
          label: 'Username',
          hint: 'Enter your name',
          onChanged: gameNotifier.setUsername,
          enabled: gameState.isLoading == false,
        ),
        const SizedBox(height: 16),
        BaseDropdown<GameMode>(
          label: 'Game Mode',
          value: gameState.gameMode,
          items: const [
            DropdownMenuItem(value: GameMode.mixed, child: Text('Mixed Songs')),
            DropdownMenuItem(value: GameMode.album, child: Text('Album Mode')),
          ],
          onChanged: (value) {
            if (value == null) return;
            gameNotifier.setGameMode(value);
          },
          enabled: gameState.isLoading == false,
        ),
        const SizedBox(height: 16),
        BaseTextField(
          label: 'Search Artist',
          hint: 'e.g. Coldplay, Starset...',
          onChanged: gameNotifier.setArtistName,
          enabled: gameState.isLoading == false,
        ),
        if (gameState.gameMode == GameMode.album)...[
          const SizedBox(height: 16),
          BaseTextField(
            label: 'Album Name',
            hint: 'e.g. Parachutes, Silos...',
            onChanged: gameNotifier.setAlbumName,
            enabled: gameState.isLoading == false,
          ),
        ],
        const SizedBox(height: 20),
        BaseOutlinedButton(
          icon: Icons.search,
          label: gameState.isLoading ? 'Searching...' : 'Find Songs',
          onTap: gameState.isLoading ? null :  () => gameNotifier.searchSongs(),
        ),
        if (gameState.foundSongs.isNotEmpty)...[
          const SizedBox(height: 8),
          Center(
            child: Text(
                'Found ${gameState.foundSongs.length} songs by ${gameState.foundSongs[0].artistName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).successfulTextColor,
                )
            ),
          ),
        ],
        const SizedBox(height: 16),
        BaseDropdown<Difficulty>(
          label: 'Difficulty',
          value: gameState.difficulty,
          items: const [
            DropdownMenuItem(
              value: Difficulty.easy,
              child: Text('Easy (30s clip, +10 pts)'),
            ),
            DropdownMenuItem(
              value: Difficulty.medium,
              child: Text('Medium (15s clip, +20 pts)'),
            ),
            DropdownMenuItem(
              value: Difficulty.hard,
              child: Text('Hard (10s clip, +30 pts)'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;
            gameNotifier.setDifficulty(value);
          },
          enabled: gameState.isLoading == false,
        ),
        if (gameState.error != null)...[
          const SizedBox(height: 12),
          Center(
            child: Text(
              gameState.error!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.errorColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        const SizedBox(height: 24),
        GradientButton(
          label: 'Start Game',
          onTap: gameState.isLoading ? null : gameNotifier.startGame,
        ),
        const SizedBox(height: 12),
        Center(child: Text('Version: $_version')),
      ],
    );
  }

  Future<void> _getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (mounted == false) return;
    setState(() => _version = packageInfo.version);
  }
}
