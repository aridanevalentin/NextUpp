import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';
import 'package:nextupp/presentation/providers/media_list_state.dart';

// --- GESTOR DE ESTADO PARA LA LISTA PENDIENTE ---
class PendingListNotifier extends StateNotifier<MediaListState> {
  final MediaRepository _repository = sl<MediaRepository>();
  final MediaType _mediaType;

  // Suscripciones a los Streams para poder cancelarlas
  StreamSubscription? _itemsSubscription;
  StreamSubscription? _timeSubscription;

  PendingListNotifier(this._mediaType) : super(const MediaListState()) {
    // En cuanto se crea, empieza a escuchar a la BBDD
    _listenToPendingItems();
  }

  void _listenToPendingItems() {
    // Escucha la lista de items
    _itemsSubscription = _repository.getPendingItems(_mediaType).listen((items) {
      state = state.copyWith(isLoading: false, items: items);
    });

    // Escucha el sumatorio de tiempo
    _timeSubscription =
        _repository.getTotalPendingTime(_mediaType).listen((time) {
          state = state.copyWith(totalTimeInMinutes: time);
        });
  }

  // Limpia las suscripciones cuando el provider se destruye
  @override
  void dispose() {
    _itemsSubscription?.cancel();
    _timeSubscription?.cancel();
    super.dispose();
  }
}

// --- GESTOR DE ESTADO PARA LA LISTA COMPLETADA ---
class CompletedListNotifier extends StateNotifier<MediaListState> {
  final MediaRepository _repository = sl<MediaRepository>();
  final MediaType _mediaType;

  StreamSubscription? _itemsSubscription;
  StreamSubscription? _timeSubscription;

  CompletedListNotifier(this._mediaType) : super(const MediaListState()) {
    _listenToCompletedItems();
  }

  void _listenToCompletedItems() {
    // Escucha la lista de items
    _itemsSubscription =
        _repository.getCompletedItems(_mediaType).listen((items) {
          state = state.copyWith(isLoading: false, items: items);
        });

    // Escucha el sumatorio de tiempo
    _timeSubscription =
        _repository.getTotalCompletedTime(_mediaType).listen((time) {
          state = state.copyWith(totalTimeInMinutes: time);
        });
  }

  @override
  void dispose() {
    _itemsSubscription?.cancel();
    _timeSubscription?.cancel();
    super.dispose();
  }
}

// --- LOS PROVIDERS GLOBALES ---
// Los que la UI usa
// Al ser 'family' les podemos pasar un parámetro

// Provider para la lista de Pendientes
final pendingListProvider = StateNotifierProvider.family<
    PendingListNotifier, MediaListState, MediaType>((ref, mediaType) {
  return PendingListNotifier(mediaType);
});

// Provider para la lista de Completados
final completedListProvider = StateNotifierProvider.family<
    CompletedListNotifier, MediaListState, MediaType>((ref, mediaType) {
  return CompletedListNotifier(mediaType);
});