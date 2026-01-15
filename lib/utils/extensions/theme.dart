import 'package:flutter/material.dart';
import '../../ui/theme/theme.dart';

extension ColorsTheme on ThemeData  {
  Color get titleTextColor => brightness == Brightness.dark
      ? AppTheme.accentColor.shade400
      : AppTheme.primaryColor;

  Color get bodyTextColor => brightness == Brightness.dark
      ? Colors.grey
      : Colors.grey.shade700;

  Color get labelTextColor => brightness == Brightness.dark
      ? Colors.grey.shade400
      : Colors.grey.shade700;

  Color get disabledTextColor => brightness == Brightness.dark
      ? AppTheme.darkDisabledTextColor
      : AppTheme.lightDisabledTextColor;

  Color get successfulTextColor => brightness == Brightness.dark
      ? Colors.greenAccent.shade400
      : Colors.green.shade600;

  Color get fillColor => brightness == Brightness.dark
      ? AppTheme.darkFillColor
      : AppTheme.lightFillColor;

  Color get borderColor => brightness == Brightness.dark
      ? Colors.grey.shade800
      : AppTheme.lightBorderColor;

  Color get accentBorderColor => brightness == Brightness.dark
      ? AppTheme.primaryColor.shade800
      : AppTheme.accentColor;
}