import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/core/errors/failure.dart';

// Representa el estado de una lista
class MediaListState extends Equatable {
  final bool isLoading;
  final List<MediaItem> items;
  final int totalTimeInMinutes; // El sumatorio de tiempo
  final Failure? failure;

  // Estado inicial
  const MediaListState({
    this.isLoading = true, // Empieza cargando
    this.items = const [],
    this.totalTimeInMinutes = 0,
    this.failure,
  });

  MediaListState copyWith({
    bool? isLoading,
    List<MediaItem>? items,
    int? totalTimeInMinutes,
    Failure? failure,
  }) {
    return MediaListState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      totalTimeInMinutes: totalTimeInMinutes ?? this.totalTimeInMinutes,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, totalTimeInMinutes, failure];
}
