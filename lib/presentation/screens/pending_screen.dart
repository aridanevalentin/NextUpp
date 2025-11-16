import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/providers/media_list_provider.dart';
import 'package:nextupp/presentation/providers/media_list_state.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';

// Es un ConsumerWidget porque solo necesita leer el provider y no tiene estado local (como un TextEditingController).
class PendingScreen extends ConsumerWidget {
  final MediaType mediaType;

  const PendingScreen({required this.mediaType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mediaTypeString = mediaType.toLocalizedString(l10n);

    // Observa el provider
    // Riverpod se encarga de crear/obtener el Notifier correcto.
    final state = ref.watch(pendingListProvider(mediaType));

    return Scaffold(
      appBar: AppBar(
        // TODO: Localizar este título
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(l10n.pendingTitle(mediaTypeString)),
        ),
        // Muestra el tiempo total en la barra
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              // TODO: Formatear estos minutos (ej. "2h 30m")
              child: Text(l10n.totalTime('${state.totalTimeInMinutes} min')),
            ),
          ),
        ],
      ),
      body: _buildBody(state, l10n, ref),
    );
  }

  Widget _buildBody(MediaListState state, AppLocalizations l10n, ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      // TODO: Localizar este texto
      return Center(child: Text(l10n.pendingEmptyMessage));
    }

    // Muestra la lista de items
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return MediaCard(
          item: item,
          status: MediaStatus.pending,
          onTap: () {
            // TODO: Navegar a la pantalla de detalle
          },
          onSaveToPending: () { /* No se usa aquí (ya está en pendientes) */ },
          onMarkAsCompleted: () {
            ref.read(pendingListProvider(mediaType).notifier).markAsCompleted(item);
          },
          onRemove: () {
            ref.read(pendingListProvider(mediaType).notifier).removeMediaItem(item);
          },
        );
          // TODO: Añadir menú para "Mark as Completed" o "Remove"
      },
    );
  }
}