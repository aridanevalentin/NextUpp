import 'package:nextupp/data/remote/game_dto.dart';
import 'package:nextupp/domain/models/game.dart';

// Añade la función 'toDomain' a la clase GameDto
extension GameMapper on GameDto {
  Game toDomain() {
    // La API de RAWG da la puntuación sobre 5. Se multiplica por 2
    // para normalizarla a 10 (igual que TMDB).
    final double normalizedRating = voteAverage * 2;

    // Extrae los nombres de las plataformas
    final List<String> platformNames =
    platforms.map((p) => p.platform.name).toList();

    return Game(
      id: id,
      title: title, // 'name' en el DTO se mapea a 'title'
      // 'description_raw' se mapea a 'overview'
      overview: overview ?? '',
      // RAWG da la URL completa, no necesita construcción
      posterUrl: posterPath ?? '',
      voteAverage: normalizedRating, // Usa la puntuación normalizada
      releaseDate: released ?? '',
      playtimeInHours: playtime, // La API ya lo da en horas
      platforms: platformNames, // Pasa la lista de nombres
    );
  }
}