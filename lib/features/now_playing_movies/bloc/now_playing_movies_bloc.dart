import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';
import 'package:movies_app/features/now_playing_movies/models/movies_model.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

@injectable
class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final IMovieRepository _iMovieRepository;
  NowPlayingMoviesBloc(this._iMovieRepository) : super(NowPlayingInitialState()) {
    on<GetNowPlayingMoviesEvent>((_, Emitter<NowPlayingMoviesState> emitter) async {
      await _getNowPlayingMovies(emitter);
    });
  }

  Future<void> _getNowPlayingMovies(Emitter<NowPlayingMoviesState> emit) async {
    emit(NowPlayingLoadingState());
    try {
      final List<MovieModel> movies = await _iMovieRepository.getNowPlayingMovies();
      emit(NowPlayingLoadSucceedState(movies));
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace);
      emit(NowPlayingLoadFailedState(e.toString()));
    }
  }

}