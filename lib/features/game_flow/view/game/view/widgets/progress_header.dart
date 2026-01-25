import 'package:flutter/material.dart';
import '../../../../../../ui/theme/theme.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.score
  });

  final int currentIndex;
  final int total;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${currentIndex + 1} of $total',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).labelTextColor,
              ),
            ),
            Text(
              'Score: $score',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).titleTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: total > 0 ? (currentIndex + 1) / total : 0.0,
        ),
      ],
    );
  }
}
