import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailModel {
  @JsonKey(name: 'adult') bool adult;
  @JsonKey(name: 'backdrop_path') String? backdropPath;
  @JsonKey(name: 'belongs_to_collection') Object? belongsToCollection;
  @JsonKey(name: 'budget') int budget;
  @JsonKey(name: 'genres') List<Genres> genres;
  @JsonKey(name: 'homepage') String? homepage;
  @JsonKey(name: 'id') int id;
  @JsonKey(name: 'imdb_id') String? imdbId;
  @JsonKey(name: 'original_language') String originalLanguage;
  @JsonKey(name: 'original_title') String originalTitle;
  @JsonKey(name: 'overview') String? overview;
  @JsonKey(name: 'popularity') double popularity;
  @JsonKey(name: 'poster_path') String? posterPath;
  @JsonKey(name: 'production_companies') List<ProductionCompanies> productionCompanies;
  @JsonKey(name: 'production_countries') List<ProductionCountries> productionCountries;
  @JsonKey(name: 'release_date') DateTime releaseDate;
  @JsonKey(name: 'revenue') int revenue;
  @JsonKey(name: 'runtime') int? runtime;
  @JsonKey(name: 'spoken_languages') List<SpokenLanguages> spokenLanguages;
  @JsonKey(name: 'status') String status;
  @JsonKey(name: 'tagline') String? tagline;
  @JsonKey(name: 'title') String title;
  @JsonKey(name: 'video') bool video;
  @JsonKey(name: 'vote_average') double voteAverage;
  @JsonKey(name: 'vote_count') int voteCount;

  MovieDetailModel({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullBackDropImageUrl => 'https://image.tmdb.org/t/p/w200$backdropPath';

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);

}

@JsonSerializable()
class Genres {
  @JsonKey(name: 'id') int id;
  @JsonKey(name: 'name') String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);

}

@JsonSerializable()
class ProductionCompanies {
  @JsonKey(name: 'id') int id;
  @JsonKey(name: 'logo_path') String? logoPath;
  @JsonKey(name: 'name') String name;
  @JsonKey(name: 'origin_country') String originCountry;

  ProductionCompanies({
    required this.id, this.logoPath, required this.name, required this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);

}

@JsonSerializable()
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1') String iso31661;
  @JsonKey(name: 'name') String name;

  ProductionCountries({required this.iso31661, required this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);

}

@JsonSerializable()
class SpokenLanguages {
  @JsonKey(name: 'iso_639_1') String iso6391;
  @JsonKey(name: 'name') String name;

  SpokenLanguages({required this.iso6391, required this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);

}
