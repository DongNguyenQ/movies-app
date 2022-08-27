import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/config/environment_config.dart';
import 'package:movies_app/core/network/http_client.dart';

import 'core/di/di.dart';

class MovieApp {
  static final MovieApp _singleton = MovieApp._internal();
  late final HttpClient _httpClient;
  late final AppEnvironment _environment;

  factory MovieApp() => _singleton;

  MovieApp._internal();

  initialize() async {
    try {
      _environment = AppEnvironment.initialize();
      _httpClient = HttpClient.initialize(_environment.apiKey);
      await initializeServiceLocator();
    } catch (e) {
      log(e.toString());
    }
  }

  HttpClient get httpClient => _httpClient;

}