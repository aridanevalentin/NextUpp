import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/providers/search_provider.dart';
import 'package:nextupp/presentation/providers/search_state.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';
// ConsumerStatefulWidget para poder consumir providers y tener un State
class SearchScreen extends ConsumerStatefulWidget {
  final MediaType mediaType;
  const SearchScreen({required this.mediaType, super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  // El TextEditingController controla el texto del buscador
  final _searchController = TextEditingController();

  // Función dispose limpia el controlador cuando la pantalla se destruye
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Función para ejecutar la búsqueda
  void _performSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      // Llama a la función search en el SearchNotifier y ref.read obtiene el provider sin escucharlo
      ref.read(searchProvider(widget.mediaType).notifier).search(query);
      // Oculta el teclado
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp asegura que no es nulo
    final l10n = AppLocalizations.of(context)!;
    // ref.watch obtiene el provider y se redibuja cuando cambia
    final state = ref.watch(searchProvider(widget.mediaType));
    final notifier = ref.read(searchProvider(widget.mediaType).notifier);

    return Scaffold(
      appBar: AppBar(
        // --- La Barra de Búsqueda ---
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: l10n.searchHint(widget.mediaType.toLocalizedString(l10n)),
            // Añade un icono x para limpiar la búsqueda
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              tooltip: l10n.searchClearTooltip,
              onPressed: () {
                _searchController.clear();
                notifier.clearSearch();
              },
            ),
          ),
          // Se ejecuta la búsqueda al pulsar el intro en el teclado
          onSubmitted: (_) => _performSearch(),
        ),
      ),
      body: Center(
        // --- Contenido ---
        child: _buildBody(context, state, notifier, l10n),
      ),
    );
  }

  // --- Widget para construir el cuerpo ---
  Widget _buildBody(
      BuildContext context,
      SearchState state,
      SearchNotifier notifier,
      AppLocalizations l10n,
      ) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }
    if (state.errorMessage != null) {
      return Text(l10n.searchError(state.errorMessage!));
    }
    if (state.results.isEmpty) {
      return Text(l10n.searchInitialMessage);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: state.results.length,
      itemBuilder: (context, index) {
        final item = state.results[index];
        final status =
            state.mediaStatusMap[item.id] ?? MediaStatus.notAdded;

        return MediaCard(
          item: item,
          status: status,
          onTap: () {
            // TODO: Navegar a la pantalla de detalle
          },
          onSaveToPending: () {
            notifier.saveToPending(item);
          },
          onMarkAsCompleted: () {
            notifier.markAsCompleted(item);
          },
          onRemove: () {
            notifier.removeItem(item);
          },
        );
      },
    );
  }
}