// Archivo: lib/data/repositories/media_repository_impl.dart

// Imports de la capa de Dominio (los contratos y modelos)
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';

// Imports de la capa de Data (las herramientas)
import 'package:nextupp/data/local/app_database.dart';
import 'package:nextupp/data/local/media_entry_mapper.dart'; // Mapper de BBDD
import 'package:nextupp/data/remote/movie_mapper.dart'; // Mappers de API
import 'package:nextupp/data/remote/series_mapper.dart';
import 'package:nextupp/data/remote/game_mapper.dart';
import 'package:nextupp/data/remote/rawg_api_client.dart';
import 'package:nextupp/data/remote/tmdb_api_client.dart';
// Imports de DTOs para chequeo de tipos
import 'package:nextupp/data/remote/movie_dto.dart';
import 'package:nextupp/data/remote/series_dto.dart';

// Esta clase implementa el contrato de MediaRepository
class MediaRepositoryImpl implements MediaRepository {
  // Las "herramientas" que necesita
  final TmdbApiClient _tmdbApi;
  final RawgApiClient _rawgApi;
  final MediaDao _mediaDao;

  // Constructor para la Inyección de Dependencias
  MediaRepositoryImpl({
    required TmdbApiClient tmdbApi,
    required RawgApiClient rawgApi,
    required AppDatabase database,
  }) : _tmdbApi = tmdbApi,
       _rawgApi = rawgApi,
       _mediaDao = database.mediaDao; // Se obtiene el DAO desde la BBDD

  // --- IMPLEMENTACIÓN DE API ---

  @override
  Future<MediaItem> getMediaDetails(int id, MediaType type) async {
    switch (type) {
      case MediaType.movie:
        final movieDto = await _tmdbApi.getMovieDetails(id);
        return movieDto.toDomain(); // Se usa el mapper de API
      case MediaType.series:
        final seriesDto = await _tmdbApi.getSeriesDetails(id);
        return seriesDto.toDomain();
      case MediaType.game:
        final gameDto = await _rawgApi.getGameDetails(id);
        return gameDto.toDomain();
    }
  }

  @override
  Future<List<MediaItem>> searchMedia(String query, MediaType type) async {
    switch (type) {
      case MediaType.movie:
        final searchResult = await _tmdbApi.searchMovies(query);
        return searchResult.results.map((dto) => dto.toDomain()).toList();
      case MediaType.series:
        final searchResult = await _tmdbApi.searchSeries(query);
        return searchResult.results.map((dto) => dto.toDomain()).toList();
      case MediaType.game:
        final searchResult = await _rawgApi.searchGames(query);
        return searchResult.results.map((dto) => dto.toDomain()).toList();
    }
  }

  @override
  Future<List<MediaItem>> getTrendingMedia() async {
    try {
      final result = await _tmdbApi.getTrendingAllOfDay();
      final items = <MediaItem>[];
      for (final dto in result.results) {
        if (dto is MovieDto) {
          items.add(dto.toDomain());
        } else if (dto is SeriesDto) {
          items.add(dto.toDomain());
        }
      }
      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MediaItem>> getPopularMedia(MediaType type) async {
    try {
      if (type == MediaType.movie) {
        final result = await _tmdbApi.getPopularMovies();
        return result.results.map((dto) => dto.toDomain()).toList();
      } else if (type == MediaType.series) {
        final result = await _tmdbApi.getPopularSeries();
        return result.results.map((dto) => dto.toDomain()).toList();
      } else {
        final result = await _rawgApi.getPopularGames();
        return result.results.map((dto) => dto.toDomain()).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  // --- IMPLEMENTACIÓN DE BBDD ---

  @override
  Stream<List<MediaItem>> getPendingItems(MediaType type) {
    return _mediaDao
        .getPendingItems(type)
        .map((entries) => entries.map((e) => e.toDomain()).toList());
  }

  @override
  Stream<List<MediaItem>> getCompletedItems(MediaType type) {
    return _mediaDao
        .getCompletedItems(type)
        .map((entries) => entries.map((e) => e.toDomain()).toList());
  }

  @override
  Stream<MediaStatus> getMediaStatus(int id, MediaType type) {
    return _mediaDao.getMediaItemStream(id, type).map((entry) {
      if (entry == null) {
        return MediaStatus.notAdded;
      }
      return entry.status;
    });
  }

  @override
  Future<void> saveMediaItem(MediaItem item) {
    return _mediaDao.saveMediaItem(item.toEntry(MediaStatus.pending));
  }

  @override
  Future<void> markAsCompleted(int id, MediaType type) {
    return _mediaDao.markAsCompleted(id, type);
  }

  @override
  Future<void> moveToPending(int id, MediaType type) {
    return _mediaDao.moveToPending(id, type);
  }

  @override
  Future<void> deleteMediaItem(int id, MediaType type) {
    return _mediaDao.deleteMediaItem(id, type);
  }

  // --- IMPLEMENTACIÓN DE CÁLCULO DE TIEMPO ---

  @override
  Stream<int> getTotalPendingTime(MediaType type) {
    return _mediaDao.getTotalPendingTime(type);
  }

  @override
  Stream<int> getTotalCompletedTime(MediaType type) {
    return _mediaDao.getTotalCompletedTime(type);
  }
}
