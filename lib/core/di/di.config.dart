// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/movie_repository/movie_remote_service.dart' as _i4;
import '../../data/movie_repository/movie_repository.dart' as _i5;
import '../../features/movie_detail/bloc/movie_detail_bloc.dart' as _i6;
import '../../features/now_playing_movies/bloc/now_playing_movies_bloc.dart'
    as _i7;
import 'services_module.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serviceModule = _$ServiceModule();
  gh.factory<_i3.Dio>(() => serviceModule.httpClient,
      instanceName: 'http_service');
  gh.singleton<_i4.MovieRemoteService>(serviceModule
      .getMovieRemoteService(get<_i3.Dio>(instanceName: 'http_service')));
  gh.singleton<_i5.IMovieRepository>(
      _i5.ImplMovieRepository(get<_i4.MovieRemoteService>()));
  gh.factory<_i6.MovieDetailBloc>(
      () => _i6.MovieDetailBloc(get<_i5.IMovieRepository>()));
  gh.factory<_i7.NowPlayingMoviesBloc>(
      () => _i7.NowPlayingMoviesBloc(get<_i5.IMovieRepository>()));
  return get;
}

class _$ServiceModule extends _i8.ServiceModule {}
