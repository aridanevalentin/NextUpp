// Interfaz marcadora o clase base para los DTOs de media
abstract class MediaItemDto {
  Map<String, dynamic> toJson();
}

// Aseguramos que los DTOs existentes implementen esto implicitamente o modificamos si es necesario.
// Como Dart usa duck typing para 'implements', si tienen los métodos coincide.
// Pero para ser estrictos, mejor modificaremos los DTOs existentes para que implementen o extiendan esto?
// O simplemente definimos MediaItemDto como un typedef o unión si fuera posible.

// En este caso, dado que SearchResultDto usa T, y queremos pasarle MediaItemDto,
// necesitamos que MovieDto y SeriesDto sean subtipos de MediaItemDto.

// Opción rápida sin modificar todo:
// Definir MediaItemDto como clase base abstracta y hacer que MovieDto/SeriesDto implementen.
