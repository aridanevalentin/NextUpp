// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NextUpp';

  @override
  String searchHint(String mediaType) {
    return 'Search $mediaType...';
  }

  @override
  String get searchClearTooltip => 'Clear search';

  @override
  String get searchInitialMessage => 'Search for movies, series or games';

  @override
  String searchError(String message) {
    return 'Error: $message';
  }

  @override
  String get mediaTypeMovie => 'Movie';

  @override
  String get mediaTypeSeries => 'Series';

  @override
  String get mediaTypeGame => 'Game';

  @override
  String pendingTitle(Object mediaType) {
    return 'Pending $mediaType';
  }

  @override
  String completedTitle(Object mediaType) {
    return 'Completed $mediaType';
  }

  @override
  String totalTime(Object time) {
    return 'Total: $time';
  }

  @override
  String get pendingEmptyMessage => 'Your pending list is empty.';

  @override
  String get completedEmptyMessage => 'Your completed list is empty.';

  @override
  String get nav_search_label => 'Search';

  @override
  String get nav_pending_label => 'Pending';

  @override
  String get nav_completed_label => 'Completed';

  @override
  String get card_more_actions => 'More actions';

  @override
  String get card_add_to_pending => 'Add to Pending';

  @override
  String get card_mark_as_completed => 'Mark as Completed';

  @override
  String get card_remove => 'Remove';

  @override
  String get snackbar_pending => 'Added to Pending';

  @override
  String get snackbar_completed => 'Marked as Completed';

  @override
  String get snackbar_removed => 'Removed from list';

  @override
  String get detail_loading => 'Loading...';

  @override
  String get detail_back_button => 'Back';

  @override
  String detail_rating_year(String rating, String year) {
    return 'Rating: $rating/10 | Year: $year';
  }

  @override
  String detail_series_info(String seasons, String episodes) {
    return 'Seasons: $seasons | Episodes: $episodes';
  }

  @override
  String detail_game_platforms(String platforms) {
    return 'Platforms: $platforms';
  }

  @override
  String get detail_fab_add => 'Add to Pending';

  @override
  String get detail_fab_watched => 'Mark as Completed';

  @override
  String get detail_fab_remove => 'Remove';
}
