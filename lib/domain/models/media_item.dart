import 'package:equatable/equatable.dart';
import 'package:nextupp/domain/models/media_type.dart';

// Clase base sellada para todos los tipos de media.
// Extiende Equatable para la comparación de objetos por valor (anula == y hashCode).
abstract class MediaItem extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final double voteAverage;
  final String releaseDate;
  final int totalDurationInMinutes; // Campo unificado para la duración total en minutos.
  final MediaType mediaType;


  // Constructor base
  const MediaItem({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.totalDurationInMinutes,
    required this.mediaType
  });

  // 'props' (de Equatable): lista de propiedades que se usan para
  // determinar si dos objetos MediaItem son iguales.
  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterUrl,
    voteAverage,
    releaseDate,
    totalDurationInMinutes,
    mediaType
  ];


}