import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/providers/search_provider.dart';
import 'package:nextupp/presentation/providers/search_state.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/l10n/app_localizations.dart';

// Se usa 'ConsumerStatefulWidget' para poder "consumir" providers y tener un 'State' (para el texto del buscador).
class SearchScreen extends ConsumerStatefulWidget {
  final MediaType mediaType;

  const SearchScreen({required this.mediaType, super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  // El 'TextEditingController' maneja el texto del buscador
  final _searchController = TextEditingController();

  // Función 'dispose' limpia el controlador cuando la pantalla se destruye
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Función para ejecutar la búsqueda
  void _performSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      // Llama a la función 'search' en el 'SearchNotifier' y 'ref.read' obtiene el provider sin escucharlo
      ref.read(searchProvider(widget.mediaType).notifier).search(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp asegura que no es nulo
    final l10n = AppLocalizations.of(context)!;
    // 'ref.watch' obtiene el provider y se redibuja cuando cambia
    final state = ref.watch(searchProvider(widget.mediaType));

    return Scaffold(
      appBar: AppBar(
        // --- La Barra de Búsqueda ---
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: l10n.searchHint(widget.mediaType.toLocalizedString(l10n)),
            // Añade un icono 'x' para limpiar la búsqueda
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchProvider(widget.mediaType).notifier).clearSearch();
              },
            ),
          ),
          // Se ejecuta la búsqueda al pulsar el intro en el teclado
          onSubmitted: (_) => _performSearch(),
        ),
      ),
      body: Center(
        // --- El Contenido ---
        child: _buildBody(state, l10n),
      ),
    );
  }

  // --- Widget para construir el cuerpo ---
  Widget _buildBody(SearchState state, AppLocalizations l10n) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }
    if (state.errorMessage != null) {
      return Text(l10n.searchError(state.errorMessage!));
    }
    if (state.results.isEmpty) {
      return Text(l10n.searchInitialMessage);
    }

    // Estado con Resultados
    return ListView.builder(
      itemCount: state.results.length,
      itemBuilder: (context, index) {
        final item = state.results[index];
        // TODO: Reemplazar esto con el 'MediaCard' reutilizable
        return ListTile(
          leading: item.posterUrl.isNotEmpty
              ? Image.network(item.posterUrl, width: 50, fit: BoxFit.cover)
              : const Icon(Icons.movie),
          title: Text(item.title),
          subtitle: Text(
            item.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}