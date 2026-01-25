import 'package:flutter/material.dart';
import '../../../../ui/theme/theme.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppTheme.accentColor,
                AppTheme.primaryColor,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
