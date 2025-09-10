import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider).isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: SwitchListTile(
                title: const Text("Dark theme"),
                value: isDark,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).setThemeBrightness(value);
                },
              ),
            ),
            Text('Version: $_version')
          ],
        ),
      ),
    );
  }

  Future<void> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }
}
