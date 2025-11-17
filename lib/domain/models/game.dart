import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';

class Game extends MediaItem {
  final List<String> platforms;

  const Game({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.voteAverage,
    required super.releaseDate,
    required int playtimeInHours, // La API (RAWG) da 'playtime' en horas
    required this.platforms,
  }) : super(totalDurationInMinutes: playtimeInHours * 60, mediaType: MediaType.game);

  // Se añaden las plataformas a las 'props' del padre.
  @override
  List<Object?> get props => [...super.props, platforms];
}