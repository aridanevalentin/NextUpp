import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/presentation/screens/dashboard/media_dashboard_screen.dart';

// --- La Pantalla de Inicio ---
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Botón para Películas
          _MediaCategoryCard(
            title: l10n.mediaTypeMovie,
            icon: Icons.movie,
            onTap: () {
              _navigateToDashboard(context, MediaType.movie);
            },
          ),
          const SizedBox(height: 16),
          // Botón para Series
          _MediaCategoryCard(
            title: l10n.mediaTypeSeries,
            icon: Icons.tv,
            onTap: () {
              _navigateToDashboard(context, MediaType.series);
            },
          ),
          const SizedBox(height: 16),
          // Botón para Juegos
          _MediaCategoryCard(
            title: l10n.mediaTypeGame,
            icon: Icons.gamepad,
            onTap: () {
              _navigateToDashboard(context, MediaType.game);
            },
          ),
        ],
      ),
    );
  }

  // Función para navegar
  void _navigateToDashboard(BuildContext context, MediaType mediaType) {
    // Navigator.push añade una nueva pantalla a la pila
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MediaDashboardScreen(mediaType: mediaType),
      ),
    );
  }
}

// --- Widget reutilizable para los botones de categoría ---
class _MediaCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MediaCategoryCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // InkWell hace que la tarjeta sea clicable y tenga efecto ripple
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 24),
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}