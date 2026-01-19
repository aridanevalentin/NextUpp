import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';
import 'package:nextupp/core/theme/app_theme.dart';

// Widget inteligente que decide cómo mostrarse según el tipo de medio
class MediaCard extends StatelessWidget {
  final MediaItem item;
  final MediaStatus status;
  final VoidCallback onTap;
  final VoidCallback onSaveToPending;
  final VoidCallback onMarkAsCompleted;
  final VoidCallback onRemove;

  const MediaCard({
    super.key,
    required this.item,
    required this.status,
    required this.onTap,
    required this.onSaveToPending,
    required this.onMarkAsCompleted,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (item.mediaType == MediaType.game) {
      return _GameCard(
        item: item,
        status: status,
        onTap: onTap,
        onSaveToPending: onSaveToPending,
        onMarkAsCompleted: onMarkAsCompleted,
        onRemove: onRemove,
      );
    } else {
      return _MovieCard(
        item: item,
        status: status,
        onTap: onTap,
        onSaveToPending: onSaveToPending,
        onMarkAsCompleted: onMarkAsCompleted,
        onRemove: onRemove,
      );
    }
  }

  static Color getRatingColor(double rating) {
    if (rating >= 7.0) return const Color(0xFF00E676); // Green Neon
    if (rating >= 5.0) return Colors.amber;
    return Colors.redAccent;
  }
}

// --- CASO B: GAME (Horizontal/Banner) ---
class _GameCard extends StatelessWidget {
  final MediaItem item;
  final MediaStatus status;
  final VoidCallback onTap;
  final VoidCallback onSaveToPending;
  final VoidCallback onMarkAsCompleted;
  final VoidCallback onRemove;

  const _GameCard({
    required this.item,
    required this.status,
    required this.onTap,
    required this.onSaveToPending,
    required this.onMarkAsCompleted,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Intentamos usar el backdrop (imagen ancha) si existe, si no el poster
    // Para juegos RAWG a veces el posterUrl ya es horizontal, pero idealmente buscariamos una propiedad background_image
    // Asumiremos que posterUrl en juegos es la imagen principal.

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            // Imagen de Fondo (Full Bleed)
            Positioned.fill(
              child: Hero(
                tag: item.id,
                child: CachedNetworkImage(
                  imageUrl: item.posterUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppTheme.surface),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.videogame_asset_off)),
                ),
              ),
            ),
            // Gradiente para mejorar legibilidad del texto
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                    ],
                    stops: [0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            // Información abajo a la izquierda
            Positioned(
              bottom: 12,
              left: 12,
              right: 48, // Espacio para el menú
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      shadows: [
                        const Shadow(offset: Offset(0, 1), blurRadius: 2),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.releaseDate.length >= 4)
                    Text(
                      item.releaseDate.substring(0, 4),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                ],
              ),
            ),
            // Botón de Menú arriba a la derecha (estilo overlay)
            Positioned(
              top: 4,
              right: 4,
              child: _MediaMenuButton(
                status: status,
                onSaveToPending: onSaveToPending,
                onMarkAsCompleted: onMarkAsCompleted,
                onRemove: onRemove,
                color: Colors.white, // Icono blanco para contraste
              ),
            ),
            // Rating Badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: MediaCard.getRatingColor(
                    item.voteAverage,
                  ).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CASO A: MOVIE/SERIES (Vertical/Poster) ---
class _MovieCard extends StatelessWidget {
  final MediaItem item;
  final MediaStatus status;
  final VoidCallback onTap;
  final VoidCallback onSaveToPending;
  final VoidCallback onMarkAsCompleted;
  final VoidCallback onRemove;

  const _MovieCard({
    required this.item,
    required this.status,
    required this.onTap,
    required this.onSaveToPending,
    required this.onMarkAsCompleted,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // El Poster ocupa la mayor parte (Expanded no funciona bien en Grid sin constraints,
            // pero aquí confiaremos en el AspectRatio del Grid)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: item.id,
                    child: CachedNetworkImage(
                      imageUrl: item.posterUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppTheme.surface),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.movie_filter)),
                    ),
                  ),
                  // Menú superpuesto discreto
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: _MediaMenuButton(
                        status: status,
                        onSaveToPending: onSaveToPending,
                        onMarkAsCompleted: onMarkAsCompleted,
                        onRemove: onRemove,
                        color: Colors.white,
                        iconSize: 20,
                      ),
                    ),
                  ),
                  // Rating Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: MediaCard.getRatingColor(
                          item.voteAverage,
                        ).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
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

// Botón de menú reutilizable
class _MediaMenuButton extends StatelessWidget {
  final MediaStatus status;
  final VoidCallback onSaveToPending;
  final VoidCallback onMarkAsCompleted;
  final VoidCallback onRemove;
  final Color color;
  final double iconSize;

  const _MediaMenuButton({
    required this.status,
    required this.onSaveToPending,
    required this.onMarkAsCompleted,
    required this.onRemove,
    this.color = Colors.white,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        tooltip: l10n.card_more_actions,
        color: Colors.black.withOpacity(0.8),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.white12, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert, color: color, size: iconSize),
        ),
        onSelected: (value) {
          switch (value) {
            case 'save':
              onSaveToPending();
              break;
            case 'complete':
              onMarkAsCompleted();
              break;
            case 'remove':
              onRemove();
              break;
            case 'pending':
              onSaveToPending();
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          switch (status) {
            case MediaStatus.notAdded:
              return [
                PopupMenuItem(
                  value: 'save',
                  child: Center(
                    child: Text(
                      l10n.card_add_to_pending,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
            case MediaStatus.pending:
              return [
                PopupMenuItem(
                  value: 'complete',
                  child: Center(
                    child: Text(
                      l10n.card_mark_as_completed,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'remove',
                  child: Center(
                    child: Text(
                      l10n.card_remove,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
            case MediaStatus.completed:
              return [
                PopupMenuItem(
                  value: 'save',
                  child: Center(
                    child: Text(
                      "Mover a Pendientes",
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ), // TODO: Localizar
                PopupMenuItem(
                  value: 'remove',
                  child: Center(
                    child: Text(
                      l10n.card_remove,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
          }
        },
      ),
    );
  }
}
