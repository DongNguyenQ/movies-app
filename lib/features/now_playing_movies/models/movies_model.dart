
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieModel {
  @JsonKey(name: 'poster_path') final String? posterPath;
  @JsonKey(name: 'adult') final bool adult;
  @JsonKey(name: 'overview') final String overview;
  @JsonKey(name: 'release_date') final DateTime releaseDate;
  @JsonKey(name: 'genre_ids') final List<int> genreIds;
  @JsonKey(name: 'id') final int id;
  @JsonKey(name: 'original_title') final String originalTitle;
  @JsonKey(name: 'original_language') final String originalLanguage;
  @JsonKey(name: 'title') final String title;
  @JsonKey(name: 'backdrop_path') final String? backdropPath;
  @JsonKey(name: 'popularity') final double popularity;
  @JsonKey(name: 'vote_count') final int voteCount;
  @JsonKey(name: 'video') final bool video;
  @JsonKey(name: 'vote_average') final double voteAverage;

  MovieModel({
    this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

}

