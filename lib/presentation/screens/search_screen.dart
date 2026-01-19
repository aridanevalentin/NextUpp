import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/core/theme/app_theme.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/providers/unified_search_provider.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/widgets/media_grid.dart';
import 'package:nextupp/presentation/screens/detail/detail_screen.dart';
import 'package:nextupp/core/utils/snackbar_utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final MediaType? mediaType;

  const SearchScreen({super.key, this.mediaType});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  MediaType? _selectedFilter; // Null = Todos

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        ref.read(unifiedSearchProvider.notifier).search(query);
      } else {
        ref.read(unifiedSearchProvider.notifier).clearSearch();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.mediaType;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      ref.read(unifiedSearchProvider.notifier).search(query);
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(unifiedSearchProvider);
    final notifier = ref.read(unifiedSearchProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80,
              title: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, child) {
                  final isSearching = value.text.isNotEmpty;
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSearching ? AppTheme.accent : Colors.white12,
                        width: 1,
                      ),
                      boxShadow: isSearching
                          ? [
                              BoxShadow(
                                color: AppTheme.accent.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: l10n.searchHint(""),
                            hintStyle: TextStyle(color: Colors.white60),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: isSearching
                                  ? AppTheme.accent
                                  : Colors.white60,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white60,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      notifier.clearSearch();
                                    },
                                    tooltip: l10n.searchClearTooltip,
                                  )
                                : null,
                          ),
                          onChanged: _onSearchChanged,
                          onSubmitted: (_) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();
                            _performSearch();
                          },
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(75),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: 24, // Increased to fit shadow
                  ),
                  child: Row(
                    children: [
                      _buildFilterChip(l10n, null, "Todos"),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        l10n,
                        MediaType.movie,
                        MediaType.movie.toLocalizedString(l10n),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        l10n,
                        MediaType.series,
                        MediaType.series.toLocalizedString(l10n),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        l10n,
                        MediaType.game,
                        MediaType.game.toLocalizedString(l10n),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: _buildBody(context, state, l10n, notifier),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    dynamic state,
    AppLocalizations l10n,
    UnifiedSearchNotifier notifier,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null) {
      return Center(child: Text(l10n.searchError(state.errorMessage!)));
    }
    if (state.results.isEmpty) {
      return Center(child: Text(l10n.searchInitialMessage));
    }

    // FILTRADO LOCAL
    final filteredResults = _selectedFilter == null
        ? state.results
        : state.results
              .where((item) => item.mediaType == _selectedFilter)
              .toList();

    if (filteredResults.isEmpty) {
      return Center(
        child: Text("No se encontraron resultados para este filtro"),
      ); // Todo localized
    }

    return MediaGrid(
      items: filteredResults,
      mediaType:
          _selectedFilter ??
          MediaType.movie, // Fallback type for grid layout hints
      statusBuilder: (item) {
        return state.mediaStatusMap[item.id] ?? MediaStatus.notAdded;
      },
      onTap: (item) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(args: (id: item.id, type: item.mediaType)),
          ),
        );
      },
      onSaveToPending: (item) {
        if (state.mediaStatusMap[item.id] == MediaStatus.notAdded) {
          notifier.addToPending(item);
          SnackbarUtils.showPending(context, l10n.snackbar_pending);
        } else if (state.mediaStatusMap[item.id] == MediaStatus.completed) {
          notifier.moveToPending(item);
          SnackbarUtils.showPending(context, l10n.snackbar_pending);
        }
      },
      onMarkAsCompleted: (item) {
        notifier.markAsCompleted(item);
        SnackbarUtils.showSuccess(context, l10n.snackbar_completed);
      },
      onRemove: (item) {
        notifier.removeMediaItem(item);
        SnackbarUtils.showDestructive(context, l10n.snackbar_removed);
      },
      bottomPadding: 100,
    );
  }

  Widget _buildFilterChip(
    AppLocalizations l10n,
    MediaType? type,
    String label,
  ) {
    final isSelected = _selectedFilter == type;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = type;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.4)
              : Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? primaryColor.withOpacity(0.5) : Colors.white12,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
