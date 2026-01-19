import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/game.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/series.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/providers/detail_provider.dart';
import 'package:nextupp/presentation/providers/detail_state.dart';
import 'package:nextupp/core/theme/app_theme.dart';

class DetailScreen extends ConsumerWidget {
  final DetailProviderArgs args;

  const DetailScreen({required this.args, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final state = ref.watch(detailProvider(args));
    final notifier = ref.read(detailProvider(args).notifier);
    final snackbarHostState = GlobalKey<ScaffoldMessengerState>();

    ref.listen(detailProvider(args).select((value) => value.snackbarSignal), (
      previous,
      nextSignal,
    ) {
      if (nextSignal != null) {
        final String message;
        switch (nextSignal) {
          case "pending":
            message = l10n.snackbar_pending;
            break;
          case "completed":
            message = l10n.snackbar_completed;
            break;
          case "removed":
            message = l10n.snackbar_removed;
            break;
          default:
            message = "";
        }

        snackbarHostState.currentState?.showSnackBar(
          SnackBar(content: Text(message)),
        );
        notifier.snackbarMessageShown();
      }
    });

    return Scaffold(
      key: snackbarHostState,
      floatingActionButton: _buildFab(context, state, notifier, l10n),
      body: _buildBody(context, state, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    DetailState state,
    AppLocalizations l10n,
  ) {
    // --- ESTADO DE CARGA ---
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // --- ESTADO DE ERROR ---
    if (state.errorMessage != null) {
      return Center(child: Text(l10n.searchError(state.errorMessage!)));
    }

    // --- ESTADO DE ÉXITO ---
    if (state.item == null) {
      return Center(child: Text(l10n.searchError("Item not found")));
    }

    final item = state.item!;

    // --- ESTADO CON DATOS ---
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400.0,
          floating: false,
          pinned: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: l10n.detail_back_button,
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 10)],
              ),
            ),
            titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (item.posterUrl.isNotEmpty)
                  Hero(
                    tag: item.id,
                    child: Image.network(item.posterUrl, fit: BoxFit.cover),
                  )
                else
                  Container(color: Colors.grey),
                // Gradient overlay
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppTheme.background],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  l10n.detail_rating_year(
                    item.voteAverage.toStringAsFixed(1),
                    item.releaseDate.length >= 4
                        ? item.releaseDate.substring(0, 4)
                        : 'N/A',
                  ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MediaCard.getRatingColor(item.voteAverage),
                  ),
                ),
                const SizedBox(height: 16),

                // --- Información Específica ---
                if (item is Series) _buildSeriesInfo(context, item, l10n),
                if (item is Game) _buildGameInfo(context, item, l10n),
                Text(
                  item.overview,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildFab(
    BuildContext context,
    DetailState state,
    DetailNotifier notifier,
    AppLocalizations l10n,
  ) {
    if (state.item == null) return null;
    switch (state.status) {
      case MediaStatus.notAdded:
        return FloatingActionButton.extended(
          onPressed: notifier.saveToPending,
          icon: const Icon(Icons.add),
          label: Text(l10n.detail_fab_add),
        );
      case MediaStatus.pending:
        return FloatingActionButton.extended(
          onPressed: notifier.markAsCompleted,
          icon: const Icon(Icons.check),
          label: Text(l10n.detail_fab_watched),
        );
      case MediaStatus.completed:
        return FloatingActionButton.extended(
          onPressed: notifier.removeItem,
          icon: const Icon(Icons.delete_outline),
          label: Text(l10n.detail_fab_remove),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        );
    }
  }

  Widget _buildSeriesInfo(
    BuildContext context,
    Series series,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detail_series_info(
            series.numberOfSeasons.toString(),
            series.numberOfEpisodes.toString(),
          ),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGameInfo(
    BuildContext context,
    Game game,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.detail_game_platforms(game.platforms.join(", ")),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
