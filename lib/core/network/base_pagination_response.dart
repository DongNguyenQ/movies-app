import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_pagination_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true, explicitToJson: true,
)
class BasePaginationResponse<T> extends Equatable {
  @JsonKey(name: 'page') final int page;
  @JsonKey(name: 'results') final T data;
  @JsonKey(name: 'dates') final Dates dates;
  @JsonKey(name: 'total_pages') final int totalPages;
  @JsonKey(name: 'total_results') final int totalData;

  const BasePaginationResponse({
    required this.page,
    required this.data,
    required this.dates,
    required this.totalPages,
    required this.totalData
  });

  @override
  List<Object?> get props => [
    page, data, totalPages, totalData
  ];

  factory BasePaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return _$BasePaginationResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) {
    return _$BasePaginationResponseToJson<T>(this, toJsonT);
  }
}

@JsonSerializable()
class Dates {
  @JsonKey(name: 'maximum') DateTime maximum;
  @JsonKey(name: 'minimum') DateTime minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);

}