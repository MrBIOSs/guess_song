import 'package:flutter/material.dart';
import '../../../../../utils/extensions/platform.dart';
import '../../widgets/widgets.dart';
import 'game_summary_content.dart';

class GameSummaryScreen extends StatelessWidget {
  const GameSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const PopScope(
        canPop: false,
        child: _MobileGameSummaryScreen(),
      );
    }

    return const PopScope(
      canPop: false,
      child: _WebGameSummaryScreen(),
    );
  }
}

class _WebGameSummaryScreen extends StatelessWidget {
  const _WebGameSummaryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: WebCard(
              child: GameSummaryContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileGameSummaryScreen extends StatelessWidget {
  const _MobileGameSummaryScreen();

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
          child: GameSummaryContent(),
        ),
      ),
    );
  }
}