import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider).isDark;

    return Switch.adaptive(
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.light_mode, color: Colors.white);
        }
        return const Icon(Icons.dark_mode_outlined, color: Colors.white);
      }),
      value: isDark,
      onChanged: (value) {
        ref.read(themeProvider.notifier).setThemeBrightness(value);
      },
    );
  }
}