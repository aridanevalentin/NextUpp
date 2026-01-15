import 'package:flutter/material.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/presentation/widgets/media_card.dart';

// Un Grid que se adapta según el tipo de medio (Cine = Vertical, Juegos = Horizontal)
class MediaGrid extends StatelessWidget {
  final List<MediaItem> items;
  final MediaType mediaType; // Para saber qué layout usar
  final Function(MediaItem) onTap;
  final Function(MediaItem) onSaveToPending;
  final Function(MediaItem) onMarkAsCompleted;
  final Function(MediaItem) onRemove;
  // Estados opcionales para listas donde el status es fijo
  final MediaStatus? fixedStatus;
  // O un builder que determine el status por item (ej. búsqueda)
  final MediaStatus Function(MediaItem)? statusBuilder;

  const MediaGrid({
    super.key,
    required this.items,
    required this.mediaType,
    required this.onTap,
    required this.onSaveToPending,
    required this.onMarkAsCompleted,
    required this.onRemove,
    this.fixedStatus,
    this.statusBuilder,
  }) : assert(
         fixedStatus != null || statusBuilder != null,
         'Debes proveer un fixedStatus o un statusBuilder',
       );

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    // Configuración Responsiva
    final bool isGame = mediaType == MediaType.game;

    // Columnas
    // Cine: 3 columnas en móvil.
    // Juegos: 1 columna en móvil (tipo feed), 2 en tablets.
    int crossAxisCount;
    double childAspectRatio;
    double mainAxisSpacing;
    double crossAxisSpacing;

    final width = MediaQuery.of(context).size.width;

    if (isGame) {
      // --- GAMES (Horizontal) ---
      crossAxisCount = width > 600 ? 2 : 1;
      childAspectRatio = 16 / 9; // Panorámico
      mainAxisSpacing = 16.0;
      crossAxisSpacing = 16.0;
    } else {
      // --- MOVIES / SERIES (Vertical) ---
      crossAxisCount = width > 600 ? 5 : 3;
      childAspectRatio = 2 / 3.2; // Poster ratio (Standard is 2:3 approx)
      mainAxisSpacing = 8.0;
      crossAxisSpacing = 8.0;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final status = fixedStatus ?? statusBuilder!(item);

        return MediaCard(
          item: item,
          status: status,
          onTap: () => onTap(item),
          onSaveToPending: () => onSaveToPending(item),
          onMarkAsCompleted: () => onMarkAsCompleted(item),
          onRemove: () => onRemove(item),
        );
      },
    );
  }
}
