import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_song/ui/theme/theme.dart';
import 'package:guess_song/utils/extensions/extensions.dart';

import '../../../../../router/router.dart';
import '../../widgets/widgets.dart';

class GameSummaryScreen extends ConsumerWidget {
  const GameSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: const [ThemeToggleButton()],
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: WebCard(
              child: Column(
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
                    'Great job, Name!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).bodyTextColor,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    '20',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).titleTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rank: Pro',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).bodyTextColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  GradientButton(
                    label: 'Play Again',
                    onTap: () {
                      context.go(AppRoute.root);
                    },
                  ),
                  if (true)...[
                    const SizedBox(height: 42),
                    Text(
                      'Top 5 Scores',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      spacing: 8,
                      children: List.generate(5, (index) {
                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 16,
                              backgroundColor: index == 0
                                  ? Colors.yellow.shade700
                                  : index == 1
                                    ? Colors.grey
                                    : index == 2
                                      ? Colors.orange[600]
                                      : Colors.transparent,
                              child: Text(
                                '${index + 1}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: index <= 2 ? Colors.white : null,
                                ),
                              ),
                            ),
                            title: Text('Name', style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: index == 1 ? AppTheme.accentColor : null,
                            )),
                            subtitle: Text('Rank', style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).disabledTextColor,
                            )),
                            trailing: Text('20', style: Theme.of(context).textTheme.titleSmall),
                          ),
                        );
                      }),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
