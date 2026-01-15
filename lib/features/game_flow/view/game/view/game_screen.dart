import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../router/router.dart';
import '../../../../../utils/extensions/extensions.dart';
import '../../widgets/widgets.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
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
                          'Question 1 of 10',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).labelTextColor,
                          ),
                        ),
                        Text(
                          'Score: 0',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).titleTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const LinearProgressIndicator(value: 1 / 10),
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
                                'https://static-cse.canva.com/blob/847132/paulskorupskas7KLaxLbSXAunsplash2.jpg',
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
                            'STARSET',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).bodyTextColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BaseOutlinedButton(
                            icon: CupertinoIcons.play,
                            label: 'Play Audio Clip',
                            onTap: () {},
                          ),
                          if (true)...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.volume_up,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: LinearProgressIndicator(
                                    value: 1 / 100,
                                    minHeight: 6,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 36),
                          Column(
                            spacing: 12,
                            children: List.generate(4, (index) {
                              return SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: index == 3
                                        ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7)
                                        : Theme.of(context).fillColor,
                                    side: BorderSide(
                                      color: Theme.of(context).borderColor,
                                    ),
                                  ),
                                  child: Text(
                                    '$index',
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
                          if (true)...[
                            const SizedBox(height: 36),
                            Text(
                              'Correct!',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).successfulTextColor,
                              ),
                            ),
                            if (true)...[
                              const SizedBox(height: 8),
                              Text(
                                'The correct answer was: 1',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).bodyTextColor,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            GradientButton(
                              label: 'Next Question',
                              onTap: () {
                                context.go(AppRoute.gameSummary);
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
}