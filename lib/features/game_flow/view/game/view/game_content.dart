import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/extensions/platform.dart';
import '../../../../../ui/theme/theme.dart';
import '../../../../../router/router.dart';
import '../../../logic/game_provider.dart';
import '../../widgets/widgets.dart';
import '../logic/audio_player_provider.dart';
import 'widgets/progress_header.dart';

class GameContent extends ConsumerStatefulWidget {
  const GameContent({super.key});

  @override
  ConsumerState<GameContent> createState() => _GameContentState();
}

class _GameContentState extends ConsumerState<GameContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAudioForCurrentQuestion();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final state = ref.read(gameProvider);
    if (state.questions.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(AppRoute.gameSetup);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(
        gameProvider.select((s) => s.currentQuestionIndex), (prev, next) {
      if (mounted == false) return;

      final state = ref.read(gameProvider);
      if (next < state.questions.length) {
        _loadAudioForCurrentQuestion();
      } else {
        ref.read(audioPlayerProvider.notifier).stop();
      }
    });

    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final audioState = ref.watch(audioPlayerProvider);
    final audioNotifier = ref.read(audioPlayerProvider.notifier);

    if (gameState.questions.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentQuestion = gameState.questions[gameState.currentQuestionIndex];
    final isCorrect = gameState.hasAnswered && gameState.selectedAnswer == currentQuestion.song.title;
    final isWrong = gameState.hasAnswered && isCorrect == false;
    final hasQuestion = gameState.currentQuestionIndex < gameState.questions.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (context.isMobile)...[
          ProgressHeader(
            currentIndex: gameState.currentQuestionIndex,
            total: gameState.questions.length,
            score: gameState.score,
          ),
          const SizedBox(height: 24),
        ],
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).accentBorderColor, width: 4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              currentQuestion.song.coverUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null
                  ),
                );
              },
              errorBuilder: (context, __, ___) => Icon(
                Icons.image,
                size: 80,
                color: Theme.of(context).bodyTextColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'What song is this?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          currentQuestion.song.artistName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).bodyTextColor,
          ),
        ),
        const SizedBox(height: 16),
        BaseOutlinedButton(
          icon: audioState.isPlaying ? Icons.stop : CupertinoIcons.play,
          label: audioState.isPlaying ? 'Stop Audio' : 'Play Audio',
          onTap: gameState.hasAnswered ? null : () {
            if (audioState.isPlaying) {
              audioNotifier.stop();
            } else {
              audioNotifier.play();
            }
          },
        ),
        if (audioState.isPlaying)...[
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.volume_up,
                size: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: audioState.progress,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 36),
        Column(
          spacing: 12,
          children: List.generate(currentQuestion.options.length, (index) {
            final option = currentQuestion.options[index];
            final isSelected = gameState.selectedAnswer == option;

            return SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: gameState.hasAnswered
                    ? null
                    : () => gameNotifier.selectAnswer(option),
                style: OutlinedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7)
                      : Theme.of(context).fillColor,
                  side: BorderSide(
                    color: Theme.of(context).borderColor,
                  ),
                ),
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }),
        ),
        if (gameState.hasAnswered)...[
          const SizedBox(height: 36),
          Text(
            isCorrect ? 'Correct!' : 'Wrong!',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isCorrect
                  ? Theme.of(context).successfulTextColor
                  : Theme.of(context).colorScheme.error,
            ),
          ),
          if (isWrong)...[
            const SizedBox(height: 8),
            Text(
              'The correct answer was: ${currentQuestion.song.title}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).bodyTextColor,
              ),
            ),
          ],
          const SizedBox(height: 16),
          GradientButton(
            label: hasQuestion ? 'Next Question' : 'View Results',
            onTap:() {
              gameNotifier.nextQuestion();

              if (hasQuestion == false) {
                context.go('${AppRoute.game}/${AppRoute.gameSummary}');
              }
            },
          ),
        ],
      ],
    );
  }

  void _loadAudioForCurrentQuestion() {
    if (mounted == false) return;

    final gameState = ref.read(gameProvider);
    if (gameState.questions.isEmpty) return;
    if (gameState.currentQuestionIndex >= gameState.questions.length) return;

    final currentQuestion = gameState.questions[gameState.currentQuestionIndex];

    ref.read(audioPlayerProvider.notifier).loadAudio(
      audioUrl: currentQuestion.song.audioUrl,
      difficulty: gameState.difficulty,
    );
  }
}