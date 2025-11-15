import 'package:nextupp/data/remote/movie_dto.dart';
import 'package:nextupp/domain/models/movie.dart';

const String _tmdbPosterBaseUrl = 'https://image.tmdb.org/t/p/w500';

// Añade la función 'toDomain' a la clase MovieDto
extension MovieMapper on MovieDto {
  Movie toDomain() {
    return Movie(
      id: id,
      title: title,
      overview: overview ?? '',
      posterUrl: posterPath != null ? '$_tmdbPosterBaseUrl$posterPath' : '',
      voteAverage: (voteAverage ?? 0).toDouble(),
      releaseDate: releaseDate ?? '',
      runtime: runtime ?? 0,
    );
  }
}