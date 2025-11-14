import 'package:json_annotation/json_annotation.dart';

part 'search_result_dto.g.dart';

// --- DTO GENÉRICO ---
@JsonSerializable(genericArgumentFactories: true)
class SearchResultDto<T> {
  final List<T> results;

  SearchResultDto({required this.results});

  factory SearchResultDto.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$SearchResultDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$SearchResultDtoToJson(this, toJsonT);
}