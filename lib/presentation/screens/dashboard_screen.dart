import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/theme/app_theme.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/providers/dashboard_provider.dart';
import 'package:nextupp/presentation/screens/detail/detail_screen.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';

import 'package:nextupp/core/utils/snackbar_utils.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar datos al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider.notifier).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Si hay error y no hay datos, mostrar error
    if (state.errorMessage != null && state.trendingMoviesAndSeries.isEmpty) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // --- HERO SECTION ---
            if (state.heroItem != null)
              SliverToBoxAdapter(child: _HeroHeader(item: state.heroItem!)),

            // --- SECTION: TRENDING (Movies & TV) ---
            SliverToBoxAdapter(
              child: _SectionHeader(title: l10n.trendingSectionTitle),
            ),
            SliverToBoxAdapter(
              child: _HorizontalMediaList(items: state.trendingMoviesAndSeries),
            ),

            // --- SECTION: POPULAR GAMES ---
            SliverToBoxAdapter(
              child: _SectionHeader(title: l10n.popularGamesSectionTitle),
            ),
            SliverToBoxAdapter(
              child: _HorizontalMediaList(items: state.popularGames),
            ),

            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
        // Floating Glass Profile Avatar
        Positioned(
          top:
              16, // SafeArea padding usually handled by Scaffold, but we might need MediaQuery
          right: 16,
          child: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final MediaItem item;

  const _HeroHeader({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(args: (id: item.id, type: item.mediaType)),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 3 / 4, // Portrait-ish Hero
        // O podríamos usar 16/9 si preferimos cinematic
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: item.posterUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: AppTheme.surface),
            ),
            // Degradado inferior
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Texto
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: MediaCard.getRatingColor(item.voteAverage),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Podríamos mostrar año, etc.
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _HorizontalMediaList extends ConsumerWidget {
  final List<MediaItem> items;

  const _HorizontalMediaList({required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double height = 240; // Altura fija
    final state = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final status = state.mediaStatusMap[item.id] ?? MediaStatus.notAdded;

          return SizedBox(
            // Ancho depende si es juego o peli
            width: item.mediaType == MediaType.game ? 280 : 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: MediaCard(
                item: item,
                status: status,
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
                  if (status == MediaStatus.notAdded) {
                    notifier.addToPending(item);
                    SnackbarUtils.showPending(context, l10n.snackbar_pending);
                  } else if (status == MediaStatus.completed) {
                    notifier.moveToPending(item);
                    SnackbarUtils.showPending(context, l10n.snackbar_pending);
                  }
                },
                onMarkAsCompleted: () {
                  notifier.markAsCompleted(item);
                  SnackbarUtils.showSuccess(context, l10n.snackbar_completed);
                },
                onRemove: () {
                  notifier.removeMediaItem(item);
                  SnackbarUtils.showDestructive(context, l10n.snackbar_removed);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
