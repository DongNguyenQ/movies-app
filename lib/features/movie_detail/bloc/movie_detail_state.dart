part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {

  bool get isInitialState => this is InitialMovieDetailState;
  bool get isLoadingState => this is LoadingMovieDetailState;
  bool get isSucceedState => this is SucceedLoadMovieDetailState;
  bool get isFailedState => this is FailedLoadMovieDetailState;
  String? get fetchedError => isFailedState ? (this as FailedLoadMovieDetailState).error : null;
  MovieDetailModel? get fetchedMovie => isSucceedState ? (this as SucceedLoadMovieDetailState).movie : null;

  @override
  List<Object?> get props => [];
}

class InitialMovieDetailState extends MovieDetailState {}

class LoadingMovieDetailState extends MovieDetailState {}

class SucceedLoadMovieDetailState extends MovieDetailState {

  final MovieDetailModel movie;

  SucceedLoadMovieDetailState(this.movie);

  @override
  List<Object?> get props => [movie];
}

class FailedLoadMovieDetailState extends MovieDetailState {
  final String error;

  FailedLoadMovieDetailState(this.error);

  @override
  List<Object?> get props => [error];
}
