import 'package:json_annotation/json_annotation.dart';

part 'series_dto.g.dart';

// --- DTO SERIES ---
@JsonSerializable()
class SeriesDto {
  final int id;
  @JsonKey(name: 'name')
  final String title;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'first_air_date')
  final String releaseDate;
  @JsonKey(name: 'number_of_seasons')
  final int numberOfSeasons;
  @JsonKey(name: 'number_of_episodes')
  final int numberOfEpisodes;
  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRunTime;

  SeriesDto({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    this.episodeRunTime,
  });

  factory SeriesDto.fromJson(Map<String, dynamic> json) =>
      _$SeriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesDtoToJson(this);
}