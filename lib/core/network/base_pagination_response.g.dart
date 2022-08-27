// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePaginationResponse<T> _$BasePaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasePaginationResponse<T>(
      page: json['page'] as int,
      data: fromJsonT(json['results']),
      dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
      totalPages: json['total_pages'] as int,
      totalData: json['total_results'] as int,
    );

Map<String, dynamic> _$BasePaginationResponseToJson<T>(
  BasePaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'results': toJsonT(instance.data),
      'dates': instance.dates.toJson(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalData,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
      maximum: DateTime.parse(json['maximum'] as String),
      minimum: DateTime.parse(json['minimum'] as String),
    );

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
      'maximum': instance.maximum.toIso8601String(),
      'minimum': instance.minimum.toIso8601String(),
    };
