import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/utils/localization_extensions.dart';
import 'package:nextupp/presentation/screens/pending_screen.dart';
import 'package:nextupp/presentation/screens/completed_screen.dart';

import 'package:nextupp/core/theme/app_theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  MediaType _selectedMediaType = MediaType.movie; // Por defecto

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Actualizar UI cuando termina el swipe para cambiar colores
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          l10n.libraryTitle, // Use generic "Biblioteca" or localized string
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AnimatedBuilder(
              animation: _tabController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildUnclippedTab(
                      context: context,
                      label: l10n.nav_pending_label,
                      index: 0,
                    ),
                    const SizedBox(width: 20),
                    _buildUnclippedTab(
                      context: context,
                      label: l10n.nav_completed_label,
                      index: 1,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: PopupMenuButton<MediaType>(
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159),
                child: const Icon(Icons.sort),
              ),
              color: Colors.black.withOpacity(0.8),
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.white12, width: 1),
              ),
              onSelected: (type) {
                setState(() {
                  _selectedMediaType = type;
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MediaType.movie,
                  child: Center(
                    child: Text(
                      MediaType.movie.toLocalizedString(l10n),
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: MediaType.series,
                  child: Center(
                    child: Text(
                      MediaType.series.toLocalizedString(l10n),
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: MediaType.game,
                  child: Center(
                    child: Text(
                      MediaType.game.toLocalizedString(l10n),
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PendingScreen(mediaType: _selectedMediaType),
          CompletedScreen(mediaType: _selectedMediaType),
        ],
      ),
    );
  }

  Widget _buildUnclippedTab({
    required BuildContext context,
    required String label,
    required int index,
  }) {
    final isSelected = _tabController.index == index;
    return InkResponse(
      onTap: () {
        _tabController.animateTo(index);
      },
      containedInkWell: false, // Permite que el splash se salga del botón
      radius: 60, // Radio grande para efecto expansivo
      highlightColor: Colors.transparent,
      splashColor: AppTheme.accent.withOpacity(0.3),
      // Si quieres el efecto 'purpurina' de Material 3, usa InkSparkle.splashFactory
      // Asegúrate de tener useMaterial3: true en tu ThemeData
      splashFactory: InkSparkle.splashFactory,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.accent : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
