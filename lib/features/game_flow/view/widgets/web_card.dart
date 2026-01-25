import 'package:flutter/material.dart';
import '../../../../ui/theme/theme.dart';

class WebCard extends StatelessWidget {
  const WebCard({
    super.key,
    this.maxWidth = 450,
    this.margin,
    required this.child,
  });

  final double maxWidth ;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(28),
      constraints: BoxConstraints(maxWidth: maxWidth),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
