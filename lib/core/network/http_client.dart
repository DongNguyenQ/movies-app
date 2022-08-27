import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/core/network/constants.dart';

class HttpClient {
  late Dio _dio;

  HttpClient.initialize(String apiKey) {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: NetworkConst.connectTimeout,
      receiveTimeout: NetworkConst.receiveTimeout,
      sendTimeout: NetworkConst.sendTimeout,
      queryParameters: {
        'api_key': apiKey,
        'language': 'en-US',
      },
      baseUrl: 'https://api.themoviedb.org/3/movie'
    );

    _dio = Dio(dioOptions);
    _dio.interceptors.addAll([
      if (!kReleaseMode) LogInterceptor()
    ]);
  }

  Dio get dio => _dio;
}