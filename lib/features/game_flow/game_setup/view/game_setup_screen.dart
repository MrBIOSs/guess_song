import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../router/router.dart';
import '../../logic/game_provider.dart';

class GameSetupScreen extends ConsumerStatefulWidget {
  const GameSetupScreen({super.key});

  @override
  ConsumerState<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends ConsumerState<GameSetupScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(gameProvider).isLoading;
    ref.listen<GameState>(gameProvider, (_, next){
      if (next.error != null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            message: "Oops, something went wrong...",
          ),
        );
        ref.read(gameProvider.notifier).clearError();
      }

      final videos = next.videos;

      if (videos == null) return;
      if (videos.isNotEmpty) {
        context.go(AppRoute.game);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Song'),
        actions: [
          IconButton(
              onPressed: () => context.go(AppRoute.settings),
              icon: Icon(Icons.settings_outlined)
          )
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'This game allows you to find out how well you know the songs of your favorite artist.\n'
                'The game has 10 rounds, in each of which you need to guess what song is playing.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(hintText: 'Artist Search'),
                )
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator.adaptive()
                : ElevatedButton(
                onPressed: _startGame,
                child: Text('Start game')
            ),
          ],
        ),
      ),
    );
  }

  void _startGame() {
    if (_searchController.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: "Enter the name of the Artist",
        ),
      );
      return;
    }

    ref.read(gameProvider.notifier).searchSong(_searchController.text);
  }
}
