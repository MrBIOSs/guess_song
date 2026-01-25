import 'package:flutter/material.dart';

extension PlatformContext on BuildContext {
  bool get isMobile {
    final platform = Theme.of(this).platform;
    return platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS;
  }
}