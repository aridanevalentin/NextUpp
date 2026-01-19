import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';
import 'package:nextupp/presentation/providers/search_state.dart';

// Notificador para la búsqueda unificada
class UnifiedSearchNotifier extends StateNotifier<SearchState> {
  final MediaRepository _repository = sl<MediaRepository>();

  UnifiedSearchNotifier() : super(const SearchState());

  Future<void> search(String query) async {
    state = state.copyWith(isLoading: true, errorMessage: null, results: []);

    try {
      final results = await Future.wait([
        _repository.searchMedia(query, MediaType.movie),
        _repository.searchMedia(query, MediaType.game),
        _repository.searchMedia(query, MediaType.series),
      ]);

      final allItems = <MediaItem>[];
      for (final list in results) {
        allItems.addAll(list);
      }

      // Populate initial status map
      final statusMap = <int, MediaStatus>{};
      for (final item in allItems) {
        // We get the current status snapshot
        final statusStream = _repository.getMediaStatus(
          item.id,
          item.mediaType,
        );
        final status = await statusStream.first;
        statusMap[item.id] = status;
      }

      state = state.copyWith(
        isLoading: false,
        results: allItems,
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

  void clearSearch() {
    state = const SearchState();
  }
}

final unifiedSearchProvider =
    StateNotifierProvider<UnifiedSearchNotifier, SearchState>((ref) {
      return UnifiedSearchNotifier();
    });
