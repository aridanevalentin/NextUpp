import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_status.dart';

// Representa el estado de la UI para la pantalla de búsqueda
class SearchState extends Equatable {
  final bool isLoading;
  final List<MediaItem> results;
  final String? errorMessage;
  final Map<int, MediaStatus> mediaStatusMap;

  // Estado inicial
  const SearchState({
    this.isLoading = false,
    this.results = const [],
    this.errorMessage,
    this.mediaStatusMap = const {},
  });

  // Función 'copyWith' como Kotlin
  SearchState copyWith({
    bool? isLoading,
    List<MediaItem>? results,
    String? errorMessage,
    Map<int, MediaStatus>? mediaStatusMap,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
      mediaStatusMap: mediaStatusMap ?? this.mediaStatusMap,
    );
  }

  @override
  List<Object?> get props => [isLoading, results, errorMessage];
}