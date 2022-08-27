import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';

import '../models/movie_detail_model.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final IMovieRepository _repository;
  MovieDetailBloc(this._repository) : super(InitialMovieDetailState()) {
    on<MovieDetailEvent>((MovieDetailEvent event, Emitter<MovieDetailState> emit) async {
      if (event is GetMovieDetailEvent) {
        await _getMovieDetail(emit, event.movieId);
      }
    });
  }

  Future<void> _getMovieDetail(Emitter<MovieDetailState> emitter, int movieId) async {
    try {
      emitter(LoadingMovieDetailState());
      final MovieDetailModel movie = await _repository.getMovieDetail(movieId);
      emitter(SucceedLoadMovieDetailState(movie));
    } catch (e) {
      emitter(FailedLoadMovieDetailState(e.toString()));
    }
  }

}