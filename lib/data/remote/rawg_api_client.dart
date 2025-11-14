import 'package:dio/dio.dart';
import 'package:nextupp/data/remote/game_dto.dart';
import 'package:nextupp/data/remote/search_result_dto.dart';

// Cliente de API RAWG
class RawgApiClient {
  final Dio _dio;
  final String _apiKey;

  static const String _baseUrl = 'https://api.rawg.io/api';

  RawgApiClient({required Dio dio, required String apiKey})
      : _dio = dio,
        _apiKey = apiKey;

  // --- MÉTODOS DE LA API ---

  // Busca juegos
  Future<SearchResultDto<GameDto>> searchGames(String query) async {
    final response = await _dio.get(
      '$_baseUrl/games',
      queryParameters: {
        'key': _apiKey,
        'search': query,
      },
    );
    return SearchResultDto.fromJson(response.data, (json) => GameDto.fromJson(json as Map<String, dynamic>));
  }

  // Obtiene detalles de un juego
  Future<GameDto> getGameDetails(int id) async {
    final response = await _dio.get(
      '$_baseUrl/games/$id',
      queryParameters: {
        'key': _apiKey,
      },
    );
    return GameDto.fromJson(response.data);
  }
}