
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/providers/media_list_provider.dart';
import 'package:nextupp/presentation/providers/media_list_state.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';
import 'package:nextupp/presentation/screens/detail/detail_screen.dart';

class CompletedScreen extends ConsumerWidget {
  final MediaType mediaType;

  const CompletedScreen({required this.mediaType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mediaTypeString = mediaType.toLocalizedString(l10n);

    // Observa el provider de completados
    final state = ref.watch(completedListProvider(mediaType));

    return Scaffold(
      appBar: AppBar(
        // TODO: Localizar este título
        title: Text(l10n.completedTitle(mediaTypeString)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              // TODO: Formatear estos minutos
              child: Text(l10n.totalTime('${state.totalTimeInMinutes} min')),
            ),
          ),
        ],
      ),
      body: _buildBody(state, l10n, ref),
    );
  }

  Widget _buildBody(MediaListState state, AppLocalizations l10n, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      return Center(child: Text(l10n.completedEmptyMessage));
    }

    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return MediaCard(
          item: item,
          status: MediaStatus.completed,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  args: (id: item.id, type: item.mediaType),
                ),
              ),
            );
          },
          onSaveToPending: () {
            // TODO: Llamar al ViewModel para "mover a pendientes"
          },
          onMarkAsCompleted: () { /* No se usa aquí */ },
          onRemove: () {
            ref.read(completedListProvider(mediaType).notifier).removeMediaItem(item);
          },
        );
      },
    );
  }
}