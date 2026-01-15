import 'package:flutter/material.dart';
import '../../../../ui/theme/theme.dart';

class WebCard extends StatelessWidget {
  const WebCard({
    super.key,
    this.width = 450,
    this.margin,
    required this.child,
  });

  final double? width;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: const EdgeInsets.all(28),
      constraints: const BoxConstraints(maxWidth: 650),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
