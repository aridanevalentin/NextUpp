import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:nextupp/data/local/app_database.dart';
import 'package:nextupp/data/remote/rawg_api_client.dart';
import 'package:nextupp/data/remote/tmdb_api_client.dart';
import 'package:nextupp/data/repositories/media_repository_impl.dart';
import 'package:nextupp/domain/repositories/media_repository.dart';

// Se crea una instancia global de GetIt
final sl = GetIt.instance; // 'sl' significa Service Locator

// Esta función inicializará todas las dependencias
Future<void> setupLocator() async {
  // --- Dependencias Externas ---

  // Singleton
  sl.registerSingleton<Dio>(Dio());
  // Singleton
  sl.registerSingleton<AppDatabase>(AppDatabase());

  // --- Clientes de API ---
  sl.registerSingleton<TmdbApiClient>(
    TmdbApiClient(
      dio: sl<Dio>(),
      apiKey: dotenv.env['TMDB_API_KEY'] ?? '',
    ),
  );
  sl.registerSingleton<RawgApiClient>(
    RawgApiClient(
      dio: sl<Dio>(),
      apiKey: dotenv.env['RAWG_API_KEY'] ?? '',
    ),
  );

  // --- Repositorio ---
  sl.registerSingleton<MediaRepository>(
    MediaRepositoryImpl(
      tmdbApi: sl<TmdbApiClient>(),
      rawgApi: sl<RawgApiClient>(),
      database: sl<AppDatabase>(),
    ),
  );

  // --- Providers / ViewModels (Se añadirán aquí más adelante) ---
  // TODO PROVIDERS
}