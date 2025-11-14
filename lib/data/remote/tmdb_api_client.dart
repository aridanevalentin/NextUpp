import 'package:dio/dio.dart';
import 'package:nextupp/data/remote/movie_dto.dart';
import 'package:nextupp/data/remote/search_result_dto.dart';
import 'package:nextupp/data/remote/series_dto.dart';

// Cliente de API TMDB
class TmdbApiClient {
  final Dio _dio;
  final String _apiKey;

  static const String _baseUrl = 'https://api.themoviedb.org/3';

  TmdbApiClient({required Dio dio, required String apiKey})
      : _dio = dio,
        _apiKey = apiKey;

  // --- MÉTODOS DE LA API ---

  // Busca películas
  Future<SearchResultDto<MovieDto>> searchMovies(String query) async {
    final response = await _dio.get(
      '$_baseUrl/search/movie',
      queryParameters: {
        'api_key': _apiKey,
        'query': query,
        'language': 'en-US', // TODO: parametrizar
      },
    );
    // Transforma el JSON en el DTO genérico
    return SearchResultDto.fromJson(response.data, (json) => MovieDto.fromJson(json as Map<String, dynamic>));
  }

  // Busca series
  Future<SearchResultDto<SeriesDto>> searchSeries(String query) async {
    final response = await _dio.get(
      '$_baseUrl/search/tv',
      queryParameters: {
        'api_key': _apiKey,
        'query': query,
        'language': 'en-US',
      },
    );
    return SearchResultDto.fromJson(response.data, (json) => SeriesDto.fromJson(json as Map<String, dynamic>));
  }

  // Obtiene detalles de una película
  Future<MovieDto> getMovieDetails(int id) async {
    final response = await _dio.get(
      '$_baseUrl/movie/$id',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'append_to_response': 'watch/providers',
      },
    );
    return MovieDto.fromJson(response.data);
  }

  // Obtiene detalles de una serie
  Future<SeriesDto> getSeriesDetails(int id) async {
    final response = await _dio.get(
      '$_baseUrl/tv/$id',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'en-US',
        'append_to_response': 'watch/providers',
      },
    );
    return SeriesDto.fromJson(response.data);
  }
}