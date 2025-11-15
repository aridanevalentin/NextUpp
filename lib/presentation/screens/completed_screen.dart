import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/providers/media_list_provider.dart';
import 'package:nextupp/presentation/providers/media_list_state.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';

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
      body: _buildBody(state, l10n),
    );
  }

  Widget _buildBody(MediaListState state, AppLocalizations l10n) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      // TODO: Localizar este texto
      return Center(child: Text(l10n.completedEmptyMessage));
    }

    // Muestra la lista de items
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        // TODO: Reemplazar esto con un 'MediaCard' reutilizable
        return ListTile(
          leading: item.posterUrl.isNotEmpty
              ? Image.network(item.posterUrl, width: 50, fit: BoxFit.cover)
              : const Icon(Icons.movie),
          title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(item.title),
          ),
          subtitle: Text(
            '${item.releaseDate.substring(0, 4)} - ${item.totalDurationInMinutes} min',
          ),
          // TODO: Añadir menú para "Remove"
        );
      },
    );
  }
}