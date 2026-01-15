// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'NextUpp';

  @override
  String searchHint(String mediaType) {
    return 'Buscar $mediaType...';
  }

  @override
  String get searchClearTooltip => 'Limpiar búsqueda';

  @override
  String get searchInitialMessage => 'Busca películas, series o juegos';

  @override
  String searchError(String message) {
    return 'Error: $message';
  }

  @override
  String get mediaTypeMovie => 'Película';

  @override
  String get mediaTypeSeries => 'Serie';

  @override
  String get mediaTypeGame => 'Juego';

  @override
  String pendingTitle(Object mediaType) {
    return '$mediaType Pendientes';
  }

  @override
  String completedTitle(Object mediaType) {
    return '$mediaType Completados';
  }

  @override
  String totalTime(Object time) {
    return 'Total: $time';
  }

  @override
  String get pendingEmptyMessage => 'Tu lista de pendientes está vacía.';

  @override
  String get completedEmptyMessage => 'Tu lista de completados está vacía.';

  @override
  String get nav_search_label => 'Buscar';

  @override
  String get nav_pending_label => 'Pendientes';

  @override
  String get nav_completed_label => 'Completados';

  @override
  String get card_more_actions => 'Más acciones';

  @override
  String get card_add_to_pending => 'Añadir a Pendientes';

  @override
  String get card_mark_as_completed => 'Marcar como Completado';

  @override
  String get card_remove => 'Eliminar';

  @override
  String get snackbar_pending => 'Añadido a Pendientes';

  @override
  String get snackbar_completed => 'Marcado como Completado';

  @override
  String get snackbar_removed => 'Eliminado de la lista';

  @override
  String get detail_loading => 'Cargando...';

  @override
  String get detail_back_button => 'Atrás';

  @override
  String detail_rating_year(String rating, String year) {
    return 'Nota: $rating/10 | Año: $year';
  }

  @override
  String detail_series_info(String seasons, String episodes) {
    return 'Temporadas: $seasons | Episodios: $episodes';
  }

  @override
  String detail_game_platforms(String platforms) {
    return 'Plataformas: $platforms';
  }

  @override
  String get detail_fab_add => 'Añadir a Pendientes';

  @override
  String get detail_fab_watched => 'Marcar como Completado';

  @override
  String get detail_fab_remove => 'Eliminar';
}
