import 'package:flutter/material.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/l10n/app_localizations.dart';

// El widget reutilizable para mostrar un item de media
class MediaCard extends StatelessWidget {
  final MediaItem item;
  final MediaStatus status;

  // --- Callbacks == Funciones ---
  // Se ejecutarán cuando el usuario pulse las opciones
  final VoidCallback onTap; // Al pulsar la tarjeta
  final VoidCallback onSaveToPending; // Al pulsar "Añadir a pendientes"
  final VoidCallback onMarkAsCompleted; // Al pulsar "Marcar como completado"
  final VoidCallback onRemove; // Al pulsar "Eliminar"

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
    return Card(
      // clipBehavior evita que el ripple del InkWell se salga de los bordes
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Póster---
              _buildPoster(item.posterUrl),

              // --- Información ---
              // Expanded hace que la columna ocupe todo el espacio restante
              Expanded(
                child: _buildInfo(context, item),
              ),
            // --- Menú de 3 puntos ---
            _buildMenuButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets ---

  // Construye la imagen del póster
  Widget _buildPoster(String posterUrl) {
    return SizedBox(
      width: 100,
      height: 150,
      child: posterUrl.isNotEmpty
          ? Image.network(
        posterUrl,
        fit: BoxFit.cover,
        // Muestra un loading mientras carga
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : const Center(child: CircularProgressIndicator.adaptive());
        },
        // Muestra un icono de error si falla la carga
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.movie_filter_outlined, size: 40);
        },
      )
          : const Icon(Icons.movie_filter_outlined, size: 40),
    );
  }

  // Construye la información
  Widget _buildInfo(BuildContext context, MediaItem item) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            // Extrae el año del releaseDate
            item.releaseDate.length >= 4 ? item.releaseDate.substring(0, 4) : 'N/A',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            // TODO: Formatear esto (ej. "125 min" -> "2h 5m")
            '${item.totalDurationInMinutes} min',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  // Construye el botón de menú
  Widget _buildMenuButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // PopupMenuButton gestiona el menú
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
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
        }
      },
      // Define qué opciones mostrar, basado en el estado
      itemBuilder: (BuildContext context) {
        switch (status) {
          case MediaStatus.notAdded:
            return [
              PopupMenuItem<String>(
                value: 'save',
                child: Text(l10n.card_add_to_pending),
              ),
            ];
          case MediaStatus.pending:
            return [
              PopupMenuItem<String>(
                value: 'complete',
                child: Text(l10n.card_mark_as_completed),
              ),
              PopupMenuItem<String>(
                value: 'remove',
                child: Text(l10n.card_remove),
              ),
            ];
          case MediaStatus.completed:
            return [
              PopupMenuItem<String>(
                value: 'remove',
                child: Text(l10n.card_remove),
              ),
              // TODO: Añadir "Mover a pendientes"
            ];
        }
      },
    );
  }
}