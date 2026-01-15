import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../router/router.dart';
import '../../../../../ui/theme/theme.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../widgets/widgets.dart';
import 'mobile_game_setup_screen.dart';
import 'widgets/widgets.dart';

class GameSetupScreen extends ConsumerWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (context.isMobile) {
      return const MobileGameSetupScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: WebCard(
              margin: const EdgeInsets.all(16),
              child: Column(
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
                  const SizedBox(height: 8),
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
                    value: '',
                    onChanged: (name) {  },
                  ),
                  const SizedBox(height: 16),
                  BaseDropdown<String>(
                    label: 'Game Mode',
                    value: 'GameMode.mixed',
                    items: const [
                      DropdownMenuItem(value: 'GameMode.mixed', child: Text('Mixed Songs')),
                      DropdownMenuItem(value: 'GameMode.album', child: Text('Album Mode')),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  BaseTextField(
                    label: 'Search Artist',
                    hint: 'e.g. Coldplay, Starset...',
                    value: '',
                    onChanged: (name) {  },
                  ),
                  if (true)...[
                    const SizedBox(height: 16),
                    BaseTextField(
                      label: 'Album Name',
                      hint: 'e.g. Parachutes, Silos...',
                      value: '',
                      onChanged: (name) {  },
                    ),
                  ],
                  const SizedBox(height: 20),
                  BaseOutlinedButton(
                    icon: Icons.search,
                    label: 'Find Songs',
                    onTap: () {},
                  ),
                  if (true)...[
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Found 0 songs by Starset',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).successfulTextColor,
                        )
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  BaseDropdown<String>(
                    label: 'Difficulty',
                    value: 'easy',
                    items: const [
                      DropdownMenuItem(value: 'easy', child: Text('Easy (30s clip, +10 pts)')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium (15s clip, +20 pts)')),
                      DropdownMenuItem(value: 'hard', child: Text('Hard (10s clip, +30 pts)')),
                    ],
                    onChanged: (value) {},
                  ),
                  if (true)...[
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'Error',
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
                    onTap: () {
                      context.go(AppRoute.game);
                    },
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text('Version:'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getVersion() async {
    // final info = await PackageInfo.fromPlatform();
  }
  void _findSongs(String artist) {
    // TODO: Реализовать поиск альбомов по артисту
  }

  void _startGame(BuildContext context) {
    // TODO: Передача данных в игру
  }
}
