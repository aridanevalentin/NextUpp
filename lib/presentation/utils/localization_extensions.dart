import 'package:nextupp/domain/models/media_type.dart';
import 'package:nextupp/l10n/app_localizations.dart';

// Esto añade la función toLocalizedString a la clase MediaType
extension MediaTypeLocalization on MediaType {

  // Devuelve el string localizado correcto basado en el enum
  String toLocalizedString(AppLocalizations l10n) {
    switch (this) { // 'this' se refiere al valor del enum (movie, series, game)
      case MediaType.movie:
        return l10n.mediaTypeMovie;
      case MediaType.series:
        return l10n.mediaTypeSeries;
      case MediaType.game:
        return l10n.mediaTypeGame;
    }
  }
}