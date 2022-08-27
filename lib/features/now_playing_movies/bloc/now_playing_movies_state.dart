part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesState extends Equatable {
  bool get isInitState => this is NowPlayingInitialState;
  bool get isSucceedState => this is NowPlayingLoadSucceedState;
  bool get isFailedState => this is NowPlayingLoadFailedState;
  bool get isLoadingState => this is NowPlayingLoadingState;
  bool get isLoadingMoreState => this is NowPlayingLoadingMoreState;
  List<MovieModel> get fetchedMovies => isSucceedState ? (this as NowPlayingLoadSucceedState).movies : [];
  String get fetchedError => isFailedState ? (this as NowPlayingLoadFailedState).error : '';
}

class NowPlayingInitialState extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadingState extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadingMoreState extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadSucceedState extends NowPlayingMoviesState {

  final List<MovieModel> movies;

  NowPlayingLoadSucceedState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class NowPlayingLoadFailedState extends NowPlayingMoviesState {
  final String error;

  NowPlayingLoadFailedState(this.error);
  @override
  List<Object?> get props => [error];
}
