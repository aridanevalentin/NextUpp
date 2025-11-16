import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';
import 'package:nextupp/presentation/providers/detail_state.dart';

// Se crea una clase record para pasar los dos parámetros
// records == data class anónimas
typedef DetailProviderArgs = ({int id, MediaType type});

// --- El ViewModel == StateNotifier ---
class DetailNotifier extends StateNotifier<DetailState> {
  final MediaRepository _repository = sl<MediaRepository>();
  final DetailProviderArgs _args;

  StreamSubscription? _statusSubscription;

  DetailNotifier(this._args) : super(const DetailState()) {
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      // Llama a la API para los detalles
      final item = await _repository.getMediaDetails(_args.id, _args.type);

      //Si tiene éxito, actualiza el estado con el item
      state = state.copyWith(isLoading: false, item: item);

      _statusSubscription =
          _repository.getMediaStatus(_args.id, _args.type).listen((status) {
            state = state.copyWith(status: status);
          });
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // --- ACCIONES ---

  void snackbarMessageShown() {
    state = state.copyWith(clearSnackbar: true);
  }

  Future<void> saveToPending() async {
    final item = state.item;
    if (item == null) return;

    // UI Optimista: actualiza el estado al instante
    state = state.copyWith(
      status: MediaStatus.pending,
      snackbarSignal: "pending",
    );

    try {
      await _repository.saveMediaItem(item);
    } catch (e) {
      // TODO: Revertir estado y mostrar error
    }
  }

  Future<void> markAsCompleted() async {
    final item = state.item;
    if (item == null) return;

    state = state.copyWith(
      status: MediaStatus.completed,
      snackbarSignal: "completed",
    );
    try {
      await _repository.markAsCompleted(item.id, item.mediaType);
    } catch (e) {
      // TODO: Revertir estado
    }
  }

  Future<void> removeItem() async {
    final item = state.item;
    if (item == null) return;

    state = state.copyWith(
      status: MediaStatus.notAdded,
      snackbarSignal: "removed",
    );

    try {
      await _repository.deleteMediaItem(item.id, item.mediaType);
    } catch (e) {
      // TODO: Revertir estado
    }
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}

// --- El Provider ---
final detailProvider = StateNotifierProvider.autoDispose
    .family<DetailNotifier, DetailState, DetailProviderArgs>((ref, args) {
  return DetailNotifier(args);
});