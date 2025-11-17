import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';

class Movie extends MediaItem {
  const Movie ({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.voteAverage,
    required super.releaseDate,
    required int runtime, // La API de TMDB da la duración en minutos
  }) : super (totalDurationInMinutes: runtime, mediaType: MediaType.movie,);
}