import 'package:nextupp/data/remote/series_dto.dart';
import 'package:nextupp/domain/models/series.dart';

const String _tmdbPosterBaseUrl = 'https://image.tmdb.org/t/p/w500';

// Añade la función 'toDomain' a la clase SeriesDto
extension SeriesMapper on SeriesDto {
  Series toDomain() {
    final int avgRuntime = (episodeRunTime != null && episodeRunTime!.isNotEmpty)
        ? episodeRunTime!.first
        : 45;

    final int episodes = numberOfEpisodes ?? 0;
    final int seasons = numberOfSeasons ?? 0;

    final int totalDuration = episodes * avgRuntime;

    return Series(
      id: id,
      title: title,
      overview: overview ?? '',
      posterUrl: posterPath != null ? '$_tmdbPosterBaseUrl$posterPath' : '',
      voteAverage: (voteAverage ?? 0).toDouble(),
      releaseDate: releaseDate ?? '',
      totalDurationInMinutes: totalDuration,
      numberOfSeasons: seasons,
      numberOfEpisodes: episodes,
    );
  }
}