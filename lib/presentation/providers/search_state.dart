import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_item.dart';

// Representa el estado de la UI para la pantalla de búsqueda
class SearchState extends Equatable {
  final bool isLoading;
  final List<MediaItem> results;
  final String? errorMessage;

  // Estado inicial
  const SearchState({
    this.isLoading = false,
    this.results = const [],
    this.errorMessage,
  });

  // Función 'copyWith' como Kotlin
  SearchState copyWith({
    bool? isLoading,
    List<MediaItem>? results,
    String? errorMessage,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, results, errorMessage];
}