import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/data/movie_repository/movie_remote_service.dart';
import 'package:movies_app/data/movie_repository/movie_repository.dart';
import 'package:movies_app/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movies_app/features/movie_detail/models/movie_detail_model.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([MovieRemoteService, IMovieRepository, MovieDetailModel])
void main() {

  late final IMovieRepository _repository;
  late int mockMovieId;

  setUpAll(() {
    _repository = MockIMovieRepository();
    mockMovieId = 1;
  });

  group('Test events and states', () {

    blocTest('When receive event GetMovieDetailEvent and repository succeed fetch data, '
      'then emit succeed state',
      build: () => MovieDetailBloc(_repository),
      setUp: () {
        when(_repository.getMovieDetail(mockMovieId)).thenAnswer(
          (_) => Future.value(MockMovieDetailModel()));
      },
      act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetailEvent(mockMovieId)),
      expect: () => <TypeMatcher<MovieDetailState>>[
        isA<LoadingMovieDetailState>(),
        isA<SucceedLoadMovieDetailState>()
      ]
    );

    blocTest('When receive event GetMovieDetailEvent and repository failed fetch data, '
      'then emit failed state',
      build: () => MovieDetailBloc(_repository),
      setUp: () {
        when(_repository.getMovieDetail(mockMovieId)).thenAnswer(
          (_) => throw Exception('ERROR'));
      },
      act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetailEvent(mockMovieId)),
      expect: () => <TypeMatcher<MovieDetailState>>[
        isA<LoadingMovieDetailState>(),
        isA<FailedLoadMovieDetailState>()
      ]
    );
  });

}