import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_item.dart';

// Representa el estado de una lista
class MediaListState extends Equatable {
  final bool isLoading;
  final List<MediaItem> items;
  final int totalTimeInMinutes; // El sumatorio de tiempo

  // Estado inicial
  const MediaListState({
    this.isLoading = true, // Empieza cargando
    this.items = const [],
    this.totalTimeInMinutes = 0,
  });

  MediaListState copyWith({
    bool? isLoading,
    List<MediaItem>? items,
    int? totalTimeInMinutes,
  }) {
    return MediaListState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      totalTimeInMinutes: totalTimeInMinutes ?? this.totalTimeInMinutes,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, totalTimeInMinutes];
}