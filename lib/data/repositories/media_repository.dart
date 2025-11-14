import 'package:nextupp/domain/models/media_item.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/models/media_status.dart';

abstract class MediaRepository {

  // --- API ---

  // Busca cualquier tipo de media en las APIs
  // Devuelve una 'Future' (equivalente a 'suspend fun') de una Lista de MediaItem
  Future<List<MediaItem>> searchMedia(String query, MediaType type);

  // Obtiene los detalles de las peliculas incluyendo sus proveedores
  Future<MediaItem> getMediaDetails(int id, MediaType type);

  // --- LOCAL DATA BASE ---

  // Obtiene la lista de "pendientes" (status = 'pending')
  // Devuelve un 'Stream' (equivalente a 'Flow') que se actualiza solo
  Stream<List<MediaItem>> getWatchlistItems();

  // Obtiene la lista de "completados" (status = 'completed')
  Stream<List<MediaItem>> getCompletedItems(MediaType type);

  // Devuelve el estado de un item (NotAdded, Pending, Completed)
  Stream<MediaStatus> getMediaStatus(int id, MediaType type);

  // Guarda un item en la base de datos (lo guarda como 'pending')
  Future<void> saveMediaItem(MediaItem item);

  // Marca un item como "completado"
  Future<void> markAsCompleted(int id, MediaType type);

  // Borra un item de la base de datos
  Future<void> deleteMediaItem(int id, MediaType type);

  // --- TIME ---

  // Obtiene el sumatorio de minutos para la lista de Pendientes
  Stream<int> getTotalPendingTime(MediaType type);

  // Obtiene el sumatorio de minutos para la lista de Completados
  Stream<int> getTotalCompletedTime(MediaType type);
}