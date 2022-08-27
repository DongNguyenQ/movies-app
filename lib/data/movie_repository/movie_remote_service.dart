import 'package:dio/dio.dart';
import 'package:movies_app/core/network/base_pagination_response.dart';
import 'package:movies_app/features/now_playing_movies/models/movies_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/movie_detail/models/movie_detail_model.dart';

part 'movie_remote_service.g.dart';

@RestApi()
abstract class MovieRemoteService {
  factory MovieRemoteService(Dio dio, {String baseUrl}) = _MovieRemoteService;

  @GET('/now_playing')
  Future<BasePaginationResponse<List<MovieModel>>> getNowPlayingMovies(@Query('page') int page);

  @GET('/{movie_id}')
  Future<MovieDetailModel> getMovieDetail(
    @Path('movie_id') int movieId);
}
