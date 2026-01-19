import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/providers/media_list_provider.dart';
import 'package:nextupp/presentation/providers/media_list_state.dart';
import 'package:nextupp/core/utils/snackbar_utils.dart';
import 'package:nextupp/core/utils/time_formatter.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/widgets/media_grid.dart';
import 'package:nextupp/presentation/screens/detail/detail_screen.dart';

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
    final provider = pendingListProvider(mediaType);
    final state = ref.watch(provider);

    // Escucha cambios de error
    ref.listen(provider, (previous, next) {
      if (next.failure != null && next.failure != previous?.failure) {
        SnackbarUtils.showError(context, next.failure!.message);
      }
    });

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.pendingTitle(mediaTypeString),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.totalTime(formatDuration(state.totalTimeInMinutes)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              floating: true,
              snap: true,
            ),
          ];
        },
        body: _buildBody(context, state, l10n, ref),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    MediaListState state,
    AppLocalizations l10n,
    ref,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      // TODO: Localizar este texto
      return Center(child: Text(l10n.pendingEmptyMessage));
    }

    // Muestra la lista de items
    // Muestra la lista de items en GRID
    return MediaGrid(
      items: state.items,
      mediaType: mediaType,
      fixedStatus: MediaStatus.pending,
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(args: (id: item.id, type: item.mediaType)),
          ),
        );
      },
      onSaveToPending: (item) {},
      onMarkAsCompleted: (item) {
        ref.read(pendingListProvider(mediaType).notifier).markAsCompleted(item);
        SnackbarUtils.showSuccess(context, l10n.snackbar_completed);
      },
      onRemove: (item) {
        ref.read(pendingListProvider(mediaType).notifier).removeMediaItem(item);
        SnackbarUtils.showDestructive(context, l10n.snackbar_removed);
      },
      bottomPadding: 140, // Nav bar + spacing
    );
  }
}
