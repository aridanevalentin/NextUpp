import 'dart:async'; // Para 'StreamSubscription'
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';
import 'package:nextupp/presentation/providers/detail_state.dart'; // (No, esto está mal)
import 'package:nextupp/presentation/providers/search_state.dart';

// --- ViewModel == StateNotifier ---
class SearchNotifier extends StateNotifier<SearchState> {
  final MediaRepository _repository = sl<MediaRepository>();
  final MediaType _mediaType;
  final List<StreamSubscription> _statusSubscriptions = [];

  SearchNotifier(this._mediaType) : super(const SearchState());

  // --- Funciones ---
  Future<void> search(String query) async {
    _cancelSubscriptions();
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      results: [],
      mediaStatusMap: {},
    );

    try {
      final results = await _repository.searchMedia(query, _mediaType);

      state = state.copyWith(isLoading: false, results: results);

      _listenToItemStatuses(results);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void _listenToItemStatuses(List<MediaItem> items) {
    for (final item in items) {
      final subscription = _repository
          .getMediaStatus(item.id, item.mediaType)
          .listen((status) {
        final currentMap = state.mediaStatusMap;
        final newMap = Map<int, MediaStatus>.from(currentMap);
        newMap[item.id] = status;
        state = state.copyWith(mediaStatusMap: newMap);
      });
      _statusSubscriptions.add(subscription);
    }
  }

  void clearSearch() {
    _cancelSubscriptions();
    state = const SearchState();
  }

  // --- ACCIONES ---
  Future<void> saveToPending(MediaItem item) async {
    final currentMap = state.mediaStatusMap;
    final newMap = Map<int, MediaStatus>.from(currentMap);
    newMap[item.id] = MediaStatus.pending;
    state = state.copyWith(mediaStatusMap: newMap);
    // TODO: Mostrar Snackbar "Añadido"

    try {
      await _repository.saveMediaItem(item);
    } catch (e) {
      // TODO: Revertir estado y mostrar error
    }
  }

  Future<void> markAsCompleted(MediaItem item) async {
    // Crea un nuevo mapa inmutable
    final currentMap = state.mediaStatusMap;
    final newMap = Map<int, MediaStatus>.from(currentMap);
    newMap[item.id] = MediaStatus.completed;

    // Pasa el mapa al estado
    state = state.copyWith(mediaStatusMap: newMap);
    // TODO: Mostrar Snackbar "Completado"

    try {
      await _repository.markAsCompleted(item.id, item.mediaType);
    } catch (e) {
      // TODO: Revertir estado
    }
  }

  Future<void> removeItem(MediaItem item) async {
    final currentMap = state.mediaStatusMap;
    final newMap = Map<int, MediaStatus>.from(currentMap);
    newMap[item.id] = MediaStatus.notAdded;

    state = state.copyWith(mediaStatusMap: newMap);
    // TODO: Mostrar Snackbar "Eliminado"

    try {
      await _repository.deleteMediaItem(item.id, item.mediaType);
    } catch (e) {
      // TODO: Revertir estado
    }
  }

  // --- Limpieza ---
  void _cancelSubscriptions() {
    for (final sub in _statusSubscriptions) {
      sub.cancel();
    }
    _statusSubscriptions.clear();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }
}

// --- Provider ---
final searchProvider = StateNotifierProvider.autoDispose
    .family<SearchNotifier, SearchState, MediaType>((ref, mediaType) {
  return SearchNotifier(mediaType);
});