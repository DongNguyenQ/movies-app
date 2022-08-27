part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent {

}

class GetNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}
class LoadMoreNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}
