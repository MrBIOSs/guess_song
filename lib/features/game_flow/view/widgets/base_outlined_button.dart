import 'package:flutter/material.dart';
import '../../../../ui/theme/theme.dart';

class BaseOutlinedButton extends StatelessWidget {
  const BaseOutlinedButton({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onTap == null;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: isDisabled
                ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                : theme.colorScheme.onSurface
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.onSurface,
          backgroundColor: theme.fillColor,
          side: BorderSide(color: theme.borderColor),
          disabledForegroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          disabledBackgroundColor: theme.fillColor.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
