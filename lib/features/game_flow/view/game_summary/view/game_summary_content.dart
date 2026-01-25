import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../ui/theme/theme.dart';
import '../../../../../router/router.dart';
import '../../../../../utils/game_utils.dart';
import '../../../logic/game_provider.dart';
import '../../widgets/widgets.dart';

class GameSummaryContent extends ConsumerWidget {
  const GameSummaryContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade200, Colors.orange.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.emoji_events_outlined, size: 58, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          'Game Over!',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Great job, ${gameState.username}!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).bodyTextColor,
          ),
        ),
        const SizedBox(height: 26),
        Text(
          '${gameState.score}',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).titleTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Rank: ${getPlayerRank(gameState.score).label}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).bodyTextColor,
          ),
        ),
        const SizedBox(height: 32),
        GradientButton(
          label: 'Play Again',
          onTap: () {
            gameNotifier.restart();
            context.go(AppRoute.root);
          },
        ),
        if (gameState.leaderboard.isNotEmpty)...[
          const SizedBox(height: 42),
          Text(
            'Top 5 Scores',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 16),
          Column(
            spacing: 8,
            children: List.generate(gameState.leaderboard.length, (index) {
              final user = gameState.leaderboard[index];
              final isCurrentUser = user.username == gameState.username;

              return Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: _getMedalColor(index),
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: index <= 2 ? Colors.white : null,
                      ),
                    ),
                  ),
                  title: Text(
                      user.username,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isCurrentUser ? AppTheme.accentColor : null,
                      )
                  ),
                  subtitle: Text(
                      getPlayerRank(gameState.score).label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).disabledColor,
                      )
                  ),
                  trailing: Text('${user.score}', style: Theme.of(context).textTheme.titleSmall),
                ),
              );
            }),
          )
        ]
      ],
    );
  }

  Color _getMedalColor(int index) {
    if (index == 0) return Colors.yellow.shade700;
    if (index == 1) return Colors.grey;
    if (index == 2) return Colors.orange.shade600;
    return Colors.transparent;
  }
}