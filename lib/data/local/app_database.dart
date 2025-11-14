import 'package:drift/drift.dart';
import 'package:nextupp/data/local/type_converters.dart';
import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Esta linea e dice al generador de código (build_runner) que cree un archivo llamado 'app_database.g.dart' con el código SQL
part 'app_database.g.dart';

// --- DEFINICIÓN DE LA TABLA ---
@DataClassName('MediaItemEntry')
class MediaItems extends Table {
  IntColumn get id => integer()(); // ID de la API
  TextColumn get mediaType => text().map(const MediaTypeConverter())();
  TextColumn get status => text().map(const MediaStatusConverter())();

  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get posterUrl => text()();
  RealColumn get voteAverage => real()(); // Numeros decimales
  TextColumn get releaseDate => text()();
  IntColumn get totalDurationInMinutes => integer()();

  // Columnas que pueden ser nulas al ser específicas
  IntColumn get numberOfSeasons => integer().nullable()();
  IntColumn get numberOfEpisodes => integer().nullable()();
  TextColumn get platforms => text().nullable()(); // JSON String

  // El id y el mediaType son la clave primaria
  @override
  Set<Column> get primaryKey => {id, mediaType};
}

// --- DEFINICIÓN DE LA BASE DE DATOS ---
@DriftDatabase(tables: [MediaItems], daos: [MediaDao])
class AppDatabase extends _$AppDatabase { // _$AppDatabase es la clase generada
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  MediaDao get mediaDao => MediaDao(this);
}
// --- DEFINICIÓN DEL DAO ---
@DriftAccessor(tables: [MediaItems])
class MediaDao extends DatabaseAccessor<AppDatabase> with _$MediaDaoMixin {

  MediaDao(AppDatabase db) : super(db);

  // Obtiene un Stream de items "Pendientes" de un tipo dado
  Stream<List<MediaItemEntry>> getPendingItems(MediaType type) {
    return (select(mediaItems)
            ..where((tbl) => tbl.status.equals(MediaStatus.pending.name))
            ..where((tbl) => tbl.mediaType.equals(type.name)))
        .watch();
  }

  // Obtiene un Stream de items "Pendientes" de un tipo dado
  Stream<List<MediaItemEntry>> getCompletedItems(MediaType type) {
    return (select(mediaItems)
            ..where((tbl) => tbl.status.equals(MediaStatus.completed.name))
            ..where((tbl) => tbl.mediaType.equals(type.name)))
        .watch();
  }

  // Obtiene el estado de un solo item
  Stream<MediaItemEntry?> getMediaItemStream(int id, MediaType type) {
    return (select(mediaItems)
            ..where((tbl) => tbl.id.equals(id))
            ..where((tbl) => tbl.mediaType.equals(type.name)))
        .watchSingleOrNull();
  }

  // Guarda un item (INSERT o UPDATE) con estado 'pending'
  Future<void> savedMediaItem(MediaItemEntry item) {
    return into(mediaItems).insert(
        item.copyWith(status: MediaStatus.pending),
        mode: InsertMode.insertOrReplace, // => onConflict = REPLACE
    );
  }

  // Marca un item como completado
  Future<void> markAsCompleted(int id, MediaType type) {
    return (update(mediaItems)
            ..where((tbl) => tbl.id.equals(id))
            ..where((tbl) => tbl.mediaType.equals(type.name)))
        .write(
      const MediaItemsCompanion(
        status: Value(MediaStatus.completed),
      ),
    );
  }

  // --- CÁLCULO DE TIEMPO ---

  // Obtiene el sumatorio de tiempo para la lista de "Pendientes"
  Stream<int> getTotalPendingTime(MediaType type) {
    // Define la expresión de suma
    final durationSum = mediaItems.totalDurationInMinutes.sum();
    // Define la consulta
    final query = selectOnly(mediaItems)
      ..addColumns([durationSum])
      ..where(mediaItems.status.equals(MediaStatus.pending.name))
      ..where(mediaItems.mediaType.equals(type.name));
    // Observa la consulta y transforma el resultado
    return query.watchSingleOrNull().map((row) => row?.read(durationSum) ?? 0);
  }

  // Obtiene el sumatorio de tiempo para la lista de "Completados"
  Stream<int> getTotalCompletedTime(MediaType type) {
    final durationSum = mediaItems.totalDurationInMinutes.sum();
    final query = selectOnly(mediaItems)
      ..addColumns([durationSum])
      ..where(mediaItems.status.equals(MediaStatus.completed.name))
      ..where(mediaItems.mediaType.equals(type.name));
    return query.watchSingleOrNull().map((row) => row?.read(durationSum) ?? 0);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'nextupp_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}