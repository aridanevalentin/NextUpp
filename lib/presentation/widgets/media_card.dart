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
    // Si es un juego, usamos layout horizontal (paisaje)
    // Si es peli/serie, usamos layout vertical (poster)
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
              child: CachedNetworkImage(
                imageUrl: item.posterUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppTheme.surface),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.videogame_asset_off)),
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
                  CachedNetworkImage(
                    imageUrl: item.posterUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppTheme.surface),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.movie_filter)),
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

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: color, size: iconSize),
      tooltip: l10n.card_more_actions,
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
            // Logic to move back to pending if needed in future
            // For now we assume 'save' does this or we add a specific case
            // But reuse onSaveToPending for now as "Add/Move"
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
                child: Text(l10n.card_add_to_pending),
              ),
            ];
          case MediaStatus.pending:
            return [
              PopupMenuItem(
                value: 'complete',
                child: Text(l10n.card_mark_as_completed),
              ),
              PopupMenuItem(value: 'remove', child: Text(l10n.card_remove)),
            ];
          case MediaStatus.completed:
            return [
              // Usamos 'pending' como valor para diferenciar si es necesario
              PopupMenuItem(
                value: 'save',
                child: Text("Mover a Pendientes"),
              ), // TODO: Localizar
              PopupMenuItem(value: 'remove', child: Text(l10n.card_remove)),
            ];
        }
      },
    );
  }
}
