import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';

// Estado del Dashboard
class DashboardState {
  final bool isLoading;
  final String? errorMessage;
  final List<MediaItem> trendingMoviesAndSeries;
  final List<MediaItem> popularGames;
  final List<MediaItem> popularMovies;
  final Map<int, MediaStatus> mediaStatusMap;

  // Hero Item
  MediaItem? get heroItem {
    if (trendingMoviesAndSeries.isEmpty) return null;
    try {
      return trendingMoviesAndSeries.firstWhere(
        (item) => item.voteAverage >= 7.0,
      );
    } catch (_) {
      return trendingMoviesAndSeries.first;
    }
  }

  const DashboardState({
    this.isLoading = false,
    this.errorMessage,
    this.trendingMoviesAndSeries = const [],
    this.popularGames = const [],
    this.popularMovies = const [],
    this.mediaStatusMap = const {},
  });

  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MediaItem>? trendingMoviesAndSeries,
    List<MediaItem>? popularGames,
    List<MediaItem>? popularMovies,
    Map<int, MediaStatus>? mediaStatusMap,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      trendingMoviesAndSeries:
          trendingMoviesAndSeries ?? this.trendingMoviesAndSeries,
      popularGames: popularGames ?? this.popularGames,
      popularMovies: popularMovies ?? this.popularMovies,
      mediaStatusMap: mediaStatusMap ?? this.mediaStatusMap,
    );
  }
}

// Notifier
class DashboardNotifier extends StateNotifier<DashboardState> {
  final MediaRepository _repository;

  DashboardNotifier(this._repository) : super(const DashboardState());

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final results = await Future.wait([
        _repository.getTrendingMedia(),
        _repository.getPopularMedia(MediaType.game),
      ]);

      final trending = results[0];
      final games = results[1];

      // Populate Status Map
      final allItems = [...trending, ...games];
      final statusMap = <int, MediaStatus>{};

      for (final item in allItems) {
        final statusStream = _repository.getMediaStatus(
          item.id,
          item.mediaType,
        );
        final status = await statusStream.first;
        statusMap[item.id] = status;
      }

      state = state.copyWith(
        isLoading: false,
        trendingMoviesAndSeries: trending,
        popularGames: games,
        mediaStatusMap: statusMap,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addToPending(MediaItem item) async {
    await _repository.saveMediaItem(item);
    final newMap = Map<int, MediaStatus>.from(state.mediaStatusMap);
    newMap[item.id] = MediaStatus.pending;
    state = state.copyWith(mediaStatusMap: newMap);
  }

  Future<void> markAsCompleted(MediaItem item) async {
    await _repository.markAsCompleted(item.id, item.mediaType);
    final newMap = Map<int, MediaStatus>.from(state.mediaStatusMap);
    newMap[item.id] = MediaStatus.completed;
    state = state.copyWith(mediaStatusMap: newMap);
  }

  Future<void> removeMediaItem(MediaItem item) async {
    await _repository.deleteMediaItem(item.id, item.mediaType);
    final newMap = Map<int, MediaStatus>.from(state.mediaStatusMap);
    newMap[item.id] = MediaStatus.notAdded;
    state = state.copyWith(mediaStatusMap: newMap);
  }

  Future<void> moveToPending(MediaItem item) async {
    await _repository.moveToPending(item.id, item.mediaType);
    final newMap = Map<int, MediaStatus>.from(state.mediaStatusMap);
    newMap[item.id] = MediaStatus.pending;
    state = state.copyWith(mediaStatusMap: newMap);
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      return DashboardNotifier(sl<MediaRepository>());
    });
