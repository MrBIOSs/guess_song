import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/config.dart';

class YoutubeDioClient {
  YoutubeDioClient(Talker talker)
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.googleapis.com/youtube/v3',
      queryParameters: {
        'key': Config.youtubeApiKey,
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ) {
    _dio.interceptors.add(TalkerDioLogger(talker: talker));
  }
  final Dio _dio;

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error API: ${e.response?.statusCode} – ${e.response?.statusMessage}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }
}