import 'package:json_annotation/json_annotation.dart';
import 'package:nextupp/data/remote/media_item_dto.dart';

part 'game_dto.g.dart';

// --- DTO GAME ---
@JsonSerializable()
class GameDto implements MediaItemDto {
  final int id;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'description_raw')
  final String? overview;
  @JsonKey(name: 'background_image')
  final String? posterPath;
  @JsonKey(name: 'rating') // Puntuación sobre 5
  final double voteAverage;
  final String? released;
  final int playtime;
  final List<PlatformDto> platforms;

  GameDto({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    required this.voteAverage,
    this.released,
    required this.playtime,
    required this.platforms,
  });

  factory GameDto.fromJson(Map<String, dynamic> json) =>
      _$GameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameDtoToJson(this);
}

// --- DTO GAME PLATFORMS ---
@JsonSerializable()
class PlatformDto {
  final PlatformDetailsDto platform;

  PlatformDto({required this.platform});

  factory PlatformDto.fromJson(Map<String, dynamic> json) =>
      _$PlatformDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformDtoToJson(this);
}

@JsonSerializable()
class PlatformDetailsDto {
  final String name;

  PlatformDetailsDto({required this.name});

  factory PlatformDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PlatformDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformDetailsDtoToJson(this);
}
