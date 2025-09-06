import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Config {
  Config({
    required this.preferences,
    required this.talker,
  });

  final SharedPreferences preferences;
  final Talker talker;
}