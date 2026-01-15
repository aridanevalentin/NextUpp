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

class CompletedScreen extends ConsumerWidget {
  final MediaType mediaType;

  const CompletedScreen({required this.mediaType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mediaTypeString = mediaType.toLocalizedString(l10n);

    // Observa el provider de completados
    final provider = completedListProvider(mediaType);
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
              title: Text(l10n.completedTitle(mediaTypeString)),
              centerTitle: true,
              floating: true,
              snap: true,
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      l10n.totalTime(formatDuration(state.totalTimeInMinutes)),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
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
    WidgetRef ref,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      return Center(child: Text(l10n.completedEmptyMessage));
    }

    return MediaGrid(
      items: state.items,
      mediaType: mediaType,
      fixedStatus: MediaStatus.completed,
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(args: (id: item.id, type: item.mediaType)),
          ),
        );
      },
      onSaveToPending: (item) {
        ref.read(completedListProvider(mediaType).notifier).moveToPending(item);
      },
      onMarkAsCompleted: (item) {},
      onRemove: (item) {
        ref
            .read(completedListProvider(mediaType).notifier)
            .removeMediaItem(item);
      },
    );
  }
}
