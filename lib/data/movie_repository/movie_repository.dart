import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/features/now_playing_movies/models/movies_model.dart';

import '../../features/movie_detail/models/movie_detail_model.dart';

abstract class IMovieRepository {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

@Singleton(as: IMovieRepository)
class ImplMovieRepository implements IMovieRepository {
  final MovieRemoteService _movieRemoteService;

  ImplMovieRepository(this._movieRemoteService);

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final rsMovies = await _movieRemoteService.getNowPlayingMovies(1);
      return rsMovies.data;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      final rsMovie = await _movieRemoteService.getMovieDetail(movieId);
      return rsMovie;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }

}