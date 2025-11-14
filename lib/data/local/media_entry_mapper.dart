import 'package:nextupp/data/local/app_database.dart';
import 'package:nextupp/domain/models/game.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/models/movie.dart';
import 'package:nextupp/domain/models/series.dart';
import 'dart:convert';

// --- De BBDD -> Dominio ---

extension MediaEntryMapper on MediaItemEntry {
  // Convierte un objeto de la BBDD a un objeto limpio del Dominio
  MediaItem toDomain() {
    switch (mediaType) {
      case MediaType.movie:
        return Movie(
          id: id,
          title: title,
          overview: overview,
          posterUrl: posterUrl,
          voteAverage: voteAverage,
          releaseDate: releaseDate,
          runtime: totalDurationInMinutes,
        );
      case MediaType.series:
        return Series(
          id: id,
          title: title,
          overview: overview,
          posterUrl: posterUrl,
          voteAverage: voteAverage,
          releaseDate: releaseDate,
          totalDurationInMinutes: totalDurationInMinutes,
          numberOfSeasons: numberOfSeasons ?? 0,
          numberOfEpisodes: numberOfEpisodes ?? 0,
        );
      case MediaType.game:
        final platformList = (platforms != null && platforms!.isNotEmpty)
            ? List<String>.from(jsonDecode(platforms!))
            : <String>[];

        return Game(
          id: id,
          title: title,
          overview: overview,
          posterUrl: posterUrl,
          voteAverage: voteAverage,
          releaseDate: releaseDate,
          playtimeInHours: (totalDurationInMinutes / 60).round(),
          platforms: platformList,
        );
    }
  }
}

// --- Dominio -> BBDD ---

extension MediaItemMapper on MediaItem {
  // Convierte un objeto del Dominio a un objeto listo para la BBDD
  MediaItemEntry toEntry(MediaStatus status) {
    int? seasons;
    int? episodes;
    String? platformJson;

    if (this is Series) {
      seasons = (this as Series).numberOfSeasons;
      episodes = (this as Series).numberOfEpisodes;
    } else if (this is Game) {
      platformJson = jsonEncode((this as Game).platforms);
    }

    return MediaItemEntry(
      id: id,
      mediaType: mediaType,
      status: status,
      title: title,
      overview: overview,
      posterUrl: posterUrl,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      totalDurationInMinutes: totalDurationInMinutes,
      numberOfSeasons: seasons,
      numberOfEpisodes: episodes,
      platforms: platformJson,
    );
  }
}