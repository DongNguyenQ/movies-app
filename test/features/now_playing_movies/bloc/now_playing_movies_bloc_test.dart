
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';
import 'package:movies_app/features/now_playing_movies/bloc/now_playing_movies_bloc.dart';
import 'package:movies_app/features/now_playing_movies/models/movies_model.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([MovieRemoteService, IMovieRepository, MovieModel])
void main() {
  late final IMovieRepository _repository;

  setUpAll(() {
    _repository = MockIMovieRepository();
  });

  group('Test events and states', () {
    blocTest('When receive event GetNowPlayingMoviesEvent and repository succeed fetch data, '
      'then emit succeed state',
      build: () => NowPlayingMoviesBloc(_repository),
      setUp: () {
        when(_repository.getNowPlayingMovies()).thenAnswer(
          (_) => Future.value([MockMovieModel()]));
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(GetNowPlayingMoviesEvent()),
      expect: () => <TypeMatcher<NowPlayingMoviesState>>[
        isA<NowPlayingLoadingState>(),
        isA<NowPlayingLoadSucceedState>()
      ]
    );

    blocTest('When receive event GetNowPlayingMoviesEvent and repository failed fetch data, '
      'then emit failed state',
      build: () => NowPlayingMoviesBloc(_repository),
      setUp: () {
        when(_repository.getNowPlayingMovies()).thenAnswer(
          (_) => throw Exception('ERROR'));
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(GetNowPlayingMoviesEvent()),
      expect: () => <TypeMatcher<NowPlayingMoviesState>>[
        isA<NowPlayingLoadingState>(),
        isA<NowPlayingLoadFailedState>()
      ]
    );
  });
}