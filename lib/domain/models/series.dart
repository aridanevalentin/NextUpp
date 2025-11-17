import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';

class Series extends MediaItem {
  final int numberOfSeasons;
  final int numberOfEpisodes;

  const Series ({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.voteAverage,
    required super.releaseDate,
    required super.totalDurationInMinutes, // Esta se calculará (num_episodios * avg_runtime)
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
  }) : super(mediaType: MediaType.series);

  // Se añaden las propiedades específicas de Series a las 'props' del padre.
  @override
  List<Object?> get props => [...super.props, numberOfSeasons, numberOfEpisodes];
}