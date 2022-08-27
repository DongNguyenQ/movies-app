import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/app.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/core/di/di_named.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';

import '../../features/now_playing_movies/bloc/now_playing_movies_bloc.dart';

@module
@preResolve
abstract class ServiceModule {

  @Named(DINamed.httpService)
  Dio get httpClient => MovieApp().httpClient.dio;

  @singleton
  MovieRemoteService getMovieRemoteService(
    @Named(DINamed.httpService) Dio dio,
  ) => MovieRemoteService(dio, baseUrl: 'https://api.themoviedb.org/3/movie');
}