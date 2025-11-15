import 'package:json_annotation/json_annotation.dart';

part 'movie_dto.g.dart';

// --- DTO MOVIES ---
@JsonSerializable()
class MovieDto {
  final int id;
  final String title;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'vote_average')
  final num? voteAverage;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'runtime')
  final int? runtime;

  MovieDto({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
    this.runtime,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);
}
