import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'NextUpp'**
  String get appName;

  /// Hint text for the search bar
  ///
  /// In en, this message translates to:
  /// **'Search {mediaType}...'**
  String searchHint(String mediaType);

  /// No description provided for @searchClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get searchClearTooltip;

  /// No description provided for @searchInitialMessage.
  ///
  /// In en, this message translates to:
  /// **'Search for movies, series or games'**
  String get searchInitialMessage;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String searchError(String message);

  /// No description provided for @mediaTypeMovie.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get mediaTypeMovie;

  /// No description provided for @mediaTypeSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get mediaTypeSeries;

  /// No description provided for @mediaTypeGame.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get mediaTypeGame;

  /// No description provided for @pendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending {mediaType}'**
  String pendingTitle(Object mediaType);

  /// No description provided for @completedTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed {mediaType}'**
  String completedTitle(Object mediaType);

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total: {time}'**
  String totalTime(Object time);

  /// No description provided for @pendingEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your pending list is empty.'**
  String get pendingEmptyMessage;

  /// No description provided for @completedEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your completed list is empty.'**
  String get completedEmptyMessage;

  /// No description provided for @nav_search_label.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get nav_search_label;

  /// No description provided for @nav_pending_label.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get nav_pending_label;

  /// No description provided for @nav_completed_label.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get nav_completed_label;

  /// No description provided for @card_more_actions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get card_more_actions;

  /// No description provided for @card_add_to_pending.
  ///
  /// In en, this message translates to:
  /// **'Add to Pending'**
  String get card_add_to_pending;

  /// No description provided for @card_mark_as_completed.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get card_mark_as_completed;

  /// No description provided for @card_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get card_remove;

  /// No description provided for @snackbar_pending.
  ///
  /// In en, this message translates to:
  /// **'Added to Pending'**
  String get snackbar_pending;

  /// No description provided for @snackbar_completed.
  ///
  /// In en, this message translates to:
  /// **'Marked as Completed'**
  String get snackbar_completed;

  /// No description provided for @snackbar_removed.
  ///
  /// In en, this message translates to:
  /// **'Removed from list'**
  String get snackbar_removed;

  /// No description provided for @detail_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get detail_loading;

  /// No description provided for @detail_back_button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get detail_back_button;

  /// No description provided for @detail_rating_year.
  ///
  /// In en, this message translates to:
  /// **'Rating: {rating}/10 | Year: {year}'**
  String detail_rating_year(String rating, String year);

  /// No description provided for @detail_series_info.
  ///
  /// In en, this message translates to:
  /// **'Seasons: {seasons} | Episodes: {episodes}'**
  String detail_series_info(String seasons, String episodes);

  /// No description provided for @detail_game_platforms.
  ///
  /// In en, this message translates to:
  /// **'Platforms: {platforms}'**
  String detail_game_platforms(String platforms);

  /// No description provided for @detail_fab_add.
  ///
  /// In en, this message translates to:
  /// **'Add to Pending'**
  String get detail_fab_add;

  /// No description provided for @detail_fab_watched.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get detail_fab_watched;

  /// No description provided for @detail_fab_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get detail_fab_remove;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @trendingSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Trending Today'**
  String get trendingSectionTitle;

  /// No description provided for @popularGamesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Games'**
  String get popularGamesSectionTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
