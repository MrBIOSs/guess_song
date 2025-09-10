import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Icon(Icons.error, size: 100, color: theme.colorScheme.error),
            Text(
              '404 - Page not found',
              style: theme.textTheme.displayMedium,
            ),
            ElevatedButton(
              onPressed: () => context.go(AppRoute.root),
              child: const Text('Return to home'),
            ),
          ],
        ),
      ),
    );
  }
}
