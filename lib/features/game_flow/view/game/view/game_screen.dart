import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/extensions/platform.dart';
import '../../../logic/game_provider.dart';
import '../../widgets/widgets.dart';
import 'game_content.dart';
import 'widgets/progress_header.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const PopScope(
        canPop: false,
        child: _MobileGameScreen(),
      );
    }

    return const PopScope(
      canPop: false,
      child: _WebGameScreen(),
    );
  }
}

class _WebGameScreen extends ConsumerWidget {
  const _WebGameScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProgressHeader(
                    currentIndex: gameState.currentQuestionIndex,
                    total: gameState.questions.length,
                    score: gameState.score,
                  ),
                  const SizedBox(height: 24),
                  const WebCard(child: GameContent()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileGameScreen extends StatelessWidget {
  const _MobileGameScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: GameContent(),
        ),
      ),
    );
  }
}