import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/router.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../../logic/game_provider.dart';
import '../../widgets/widgets.dart';
import '../logic/audio_player_provider.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAudioForCurrentQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final audioState = ref.watch(audioPlayerProvider);
    final audioNotifier = ref.read(audioPlayerProvider.notifier);

    final currentQuestion = gameState.questions[gameState.currentQuestionIndex];
    final isCorrect = gameState.hasAnswered && gameState.selectedAnswer == currentQuestion.song.title;
    final isWrong = gameState.hasAnswered && isCorrect == false;
    final hasQuestion = gameState.currentQuestionIndex < gameState.questions.length - 1;

    ref.listen(gameProvider.select((s) => s.currentQuestionIndex), (prev, next) {
      if (next < gameState.questions.length) {
        _loadAudioForCurrentQuestion();
      } else {
        audioNotifier.stop();
      }
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: const [ThemeToggleButton()],
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 650),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${gameState.currentQuestionIndex + 1} of ${gameState.questions.length}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).labelTextColor,
                          ),
                        ),
                        Text(
                          'Score: ${gameState.score}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).titleTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: (gameState.currentQuestionIndex + 1) / gameState.questions.length,
                    ),
                    const SizedBox(height: 24),
                    WebCard(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                height: 40,
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
                                      color: index == 3 ? Colors.white : null
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
                              onTap: () {
                                if (hasQuestion) {
                                  gameNotifier.nextQuestion();
                                } else {
                                  context.go('${AppRoute.game}${AppRoute.gameSummary}');
                                }
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadAudioForCurrentQuestion() {
    final gameState = ref.read(gameProvider);
    final currentQuestion = gameState.questions[gameState.currentQuestionIndex];

    ref.read(audioPlayerProvider.notifier).loadAudio(
      audioUrl: currentQuestion.song.audioUrl,
      difficulty: gameState.difficulty,
    );
  }
}