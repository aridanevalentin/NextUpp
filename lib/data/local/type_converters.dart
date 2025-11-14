import 'package:drift/drift.dart';
import 'package:nextupp/domain/models/media_status.dart';
import 'package:nextupp/domain/models/media_type.dart';

// Guarda el MediaType como un String en la base de datos
class MediaTypeConverter extends TypeConverter<MediaType, String> {
  const MediaTypeConverter();

  // Dart -> SQL / enum -> String
  @override
  String toSql(MediaType value) {
    return value.name; // Guarda el string
  }

  // Al revés
  @override
  MediaType fromSql(String fromSql) {
    return MediaType.values.firstWhere((e) => e.name == fromSql);
  }
}

// Guarda el MediaStatus como un String en la base de datos
class MediaStatusConverter extends TypeConverter<MediaStatus, String> {
  const MediaStatusConverter();

  @override
  String toSql(MediaStatus value) {
    return value.name;
  }

  @override
  MediaStatus fromSql(String fromSql) {
    // Primero busca 'pending' o 'completed' si no lo encuentra es 'notAdded'
    return MediaStatus.values.firstWhere(
        (e) => e.name == fromSql,
        orElse: () => MediaStatus.notAdded
    );
  }
}