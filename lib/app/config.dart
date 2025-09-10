import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../api/dio_client.dart';

class Config {
  Config({
    required this.preferences,
    required this.talker,
    required this.apiClient,
  });

  final SharedPreferences preferences;
  final Talker talker;
  final YoutubeDioClient apiClient;

  static String get youtubeApiKey {
    final key = dotenv.env['YOUTUBE_API_KEY'];

    if (key == null || key.isEmpty) {
      throw Exception('YOUTUBE_API_KEY not found in .env');
    }
    return key;
  }
}