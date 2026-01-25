import 'package:flutter/material.dart';
import '../../../../../utils/extensions/platform.dart';
import '../../widgets/widgets.dart';
import 'game_setup_content.dart';

class GameSetupScreen extends StatelessWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return const _MobileGameSetupScreen();
    }

    return const _WebGameSetupScreen();
  }
}

class _WebGameSetupScreen extends StatelessWidget {
  const _WebGameSetupScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: WebCard(
              margin: EdgeInsets.all(16),
              child: GameSetupContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileGameSetupScreen extends StatelessWidget {
  const _MobileGameSetupScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: GameSetupContent(),
        ),
      ),
    );
  }
}