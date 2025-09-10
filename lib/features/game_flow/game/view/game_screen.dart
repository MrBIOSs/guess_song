import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/game_provider.dart';
import 'widgets/audio_player.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
          title: Text(gameState.artistTitle)
      ),
      body: Column(
        children: [
          Text('test')
          // HiddenYoutubePlayer(
          //   videoId: "dQw4w9WgXcQ",
          //   startAt: 30,
          //   endAt: 40,
          // ),
        ],
      ),
    );
  }
}