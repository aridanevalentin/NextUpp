import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/service_locator.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';
import 'package:nextupp/presentation/providers/search_state.dart';

// --- ViewModel (StateNotifier) ---
// Gestiona la lógica y el estado (SearchState)
class SearchNotifier extends StateNotifier<SearchState> {
  final MediaRepository _repository = sl<MediaRepository>();
  final MediaType _mediaType;

  SearchNotifier(this._mediaType) : super(const SearchState());

  // --- Funciones de la UI ---

  // La UI llamará a esta función para buscar
  Future<void> search(String query) async {
    // Pone el estado en "Cargando"
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Llama al repositorio
      final results = await _repository.searchMedia(query, _mediaType);

      // Pone el estado en "Éxito" con los resultados
      state = state.copyWith(isLoading: false, results: results);
    } catch (e) {
      // Pone el estado en "Error"
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // La UI llamará a esto para limpiar la búsqueda
  void clearSearch() {
    state = const SearchState();
  }
}

// --- El Provider ---
// La UI usará esto para "obtener" el ViewModel
// Equivalente a 'viewModel(factory = ...)' en Compose
final searchProvider = StateNotifierProvider.autoDispose.family<
    SearchNotifier, SearchState, MediaType>((ref, mediaType) {
  return SearchNotifier(mediaType);
});