// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MediaItemsTable extends MediaItems
    with TableInfo<$MediaItemsTable, MediaItemEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, String> mediaType =
      GeneratedColumn<String>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MediaType>($MediaItemsTable.$convertermediaType);
  @override
  late final GeneratedColumnWithTypeConverter<MediaStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MediaStatus>($MediaItemsTable.$converterstatus);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterUrlMeta = const VerificationMeta(
    'posterUrl',
  );
  @override
  late final GeneratedColumn<String> posterUrl = GeneratedColumn<String>(
    'poster_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voteAverageMeta = const VerificationMeta(
    'voteAverage',
  );
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
    'vote_average',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDurationInMinutesMeta =
      const VerificationMeta('totalDurationInMinutes');
  @override
  late final GeneratedColumn<int> totalDurationInMinutes = GeneratedColumn<int>(
    'total_duration_in_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfSeasonsMeta = const VerificationMeta(
    'numberOfSeasons',
  );
  @override
  late final GeneratedColumn<int> numberOfSeasons = GeneratedColumn<int>(
    'number_of_seasons',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numberOfEpisodesMeta = const VerificationMeta(
    'numberOfEpisodes',
  );
  @override
  late final GeneratedColumn<int> numberOfEpisodes = GeneratedColumn<int>(
    'number_of_episodes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformsMeta = const VerificationMeta(
    'platforms',
  );
  @override
  late final GeneratedColumn<String> platforms = GeneratedColumn<String>(
    'platforms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mediaType,
    status,
    title,
    overview,
    posterUrl,
    voteAverage,
    releaseDate,
    totalDurationInMinutes,
    numberOfSeasons,
    numberOfEpisodes,
    platforms,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaItemEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_url')) {
      context.handle(
        _posterUrlMeta,
        posterUrl.isAcceptableOrUnknown(data['poster_url']!, _posterUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_posterUrlMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
        _voteAverageMeta,
        voteAverage.isAcceptableOrUnknown(
          data['vote_average']!,
          _voteAverageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('total_duration_in_minutes')) {
      context.handle(
        _totalDurationInMinutesMeta,
        totalDurationInMinutes.isAcceptableOrUnknown(
          data['total_duration_in_minutes']!,
          _totalDurationInMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDurationInMinutesMeta);
    }
    if (data.containsKey('number_of_seasons')) {
      context.handle(
        _numberOfSeasonsMeta,
        numberOfSeasons.isAcceptableOrUnknown(
          data['number_of_seasons']!,
          _numberOfSeasonsMeta,
        ),
      );
    }
    if (data.containsKey('number_of_episodes')) {
      context.handle(
        _numberOfEpisodesMeta,
        numberOfEpisodes.isAcceptableOrUnknown(
          data['number_of_episodes']!,
          _numberOfEpisodesMeta,
        ),
      );
    }
    if (data.containsKey('platforms')) {
      context.handle(
        _platformsMeta,
        platforms.isAcceptableOrUnknown(data['platforms']!, _platformsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, mediaType};
  @override
  MediaItemEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaItemEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mediaType: $MediaItemsTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      status: $MediaItemsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      )!,
      posterUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_url'],
      )!,
      voteAverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vote_average'],
      )!,
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      )!,
      totalDurationInMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_duration_in_minutes'],
      )!,
      numberOfSeasons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_seasons'],
      ),
      numberOfEpisodes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_episodes'],
      ),
      platforms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platforms'],
      ),
    );
  }

  @override
  $MediaItemsTable createAlias(String alias) {
    return $MediaItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<MediaType, String> $convertermediaType =
      const MediaTypeConverter();
  static TypeConverter<MediaStatus, String> $converterstatus =
      const MediaStatusConverter();
}

class MediaItemEntry extends DataClass implements Insertable<MediaItemEntry> {
  final int id;
  final MediaType mediaType;
  final MediaStatus status;
  final String title;
  final String overview;
  final String posterUrl;
  final double voteAverage;
  final String releaseDate;
  final int totalDurationInMinutes;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final String? platforms;
  const MediaItemEntry({
    required this.id,
    required this.mediaType,
    required this.status,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.totalDurationInMinutes,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.platforms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['media_type'] = Variable<String>(
        $MediaItemsTable.$convertermediaType.toSql(mediaType),
      );
    }
    {
      map['status'] = Variable<String>(
        $MediaItemsTable.$converterstatus.toSql(status),
      );
    }
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    map['poster_url'] = Variable<String>(posterUrl);
    map['vote_average'] = Variable<double>(voteAverage);
    map['release_date'] = Variable<String>(releaseDate);
    map['total_duration_in_minutes'] = Variable<int>(totalDurationInMinutes);
    if (!nullToAbsent || numberOfSeasons != null) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons);
    }
    if (!nullToAbsent || numberOfEpisodes != null) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes);
    }
    if (!nullToAbsent || platforms != null) {
      map['platforms'] = Variable<String>(platforms);
    }
    return map;
  }

  MediaItemsCompanion toCompanion(bool nullToAbsent) {
    return MediaItemsCompanion(
      id: Value(id),
      mediaType: Value(mediaType),
      status: Value(status),
      title: Value(title),
      overview: Value(overview),
      posterUrl: Value(posterUrl),
      voteAverage: Value(voteAverage),
      releaseDate: Value(releaseDate),
      totalDurationInMinutes: Value(totalDurationInMinutes),
      numberOfSeasons: numberOfSeasons == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfSeasons),
      numberOfEpisodes: numberOfEpisodes == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfEpisodes),
      platforms: platforms == null && nullToAbsent
          ? const Value.absent()
          : Value(platforms),
    );
  }

  factory MediaItemEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaItemEntry(
      id: serializer.fromJson<int>(json['id']),
      mediaType: serializer.fromJson<MediaType>(json['mediaType']),
      status: serializer.fromJson<MediaStatus>(json['status']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterUrl: serializer.fromJson<String>(json['posterUrl']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      totalDurationInMinutes: serializer.fromJson<int>(
        json['totalDurationInMinutes'],
      ),
      numberOfSeasons: serializer.fromJson<int?>(json['numberOfSeasons']),
      numberOfEpisodes: serializer.fromJson<int?>(json['numberOfEpisodes']),
      platforms: serializer.fromJson<String?>(json['platforms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mediaType': serializer.toJson<MediaType>(mediaType),
      'status': serializer.toJson<MediaStatus>(status),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterUrl': serializer.toJson<String>(posterUrl),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'totalDurationInMinutes': serializer.toJson<int>(totalDurationInMinutes),
      'numberOfSeasons': serializer.toJson<int?>(numberOfSeasons),
      'numberOfEpisodes': serializer.toJson<int?>(numberOfEpisodes),
      'platforms': serializer.toJson<String?>(platforms),
    };
  }

  MediaItemEntry copyWith({
    int? id,
    MediaType? mediaType,
    MediaStatus? status,
    String? title,
    String? overview,
    String? posterUrl,
    double? voteAverage,
    String? releaseDate,
    int? totalDurationInMinutes,
    Value<int?> numberOfSeasons = const Value.absent(),
    Value<int?> numberOfEpisodes = const Value.absent(),
    Value<String?> platforms = const Value.absent(),
  }) => MediaItemEntry(
    id: id ?? this.id,
    mediaType: mediaType ?? this.mediaType,
    status: status ?? this.status,
    title: title ?? this.title,
    overview: overview ?? this.overview,
    posterUrl: posterUrl ?? this.posterUrl,
    voteAverage: voteAverage ?? this.voteAverage,
    releaseDate: releaseDate ?? this.releaseDate,
    totalDurationInMinutes:
        totalDurationInMinutes ?? this.totalDurationInMinutes,
    numberOfSeasons: numberOfSeasons.present
        ? numberOfSeasons.value
        : this.numberOfSeasons,
    numberOfEpisodes: numberOfEpisodes.present
        ? numberOfEpisodes.value
        : this.numberOfEpisodes,
    platforms: platforms.present ? platforms.value : this.platforms,
  );
  MediaItemEntry copyWithCompanion(MediaItemsCompanion data) {
    return MediaItemEntry(
      id: data.id.present ? data.id.value : this.id,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      status: data.status.present ? data.status.value : this.status,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterUrl: data.posterUrl.present ? data.posterUrl.value : this.posterUrl,
      voteAverage: data.voteAverage.present
          ? data.voteAverage.value
          : this.voteAverage,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      totalDurationInMinutes: data.totalDurationInMinutes.present
          ? data.totalDurationInMinutes.value
          : this.totalDurationInMinutes,
      numberOfSeasons: data.numberOfSeasons.present
          ? data.numberOfSeasons.value
          : this.numberOfSeasons,
      numberOfEpisodes: data.numberOfEpisodes.present
          ? data.numberOfEpisodes.value
          : this.numberOfEpisodes,
      platforms: data.platforms.present ? data.platforms.value : this.platforms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemEntry(')
          ..write('id: $id, ')
          ..write('mediaType: $mediaType, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterUrl: $posterUrl, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('totalDurationInMinutes: $totalDurationInMinutes, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('platforms: $platforms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mediaType,
    status,
    title,
    overview,
    posterUrl,
    voteAverage,
    releaseDate,
    totalDurationInMinutes,
    numberOfSeasons,
    numberOfEpisodes,
    platforms,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaItemEntry &&
          other.id == this.id &&
          other.mediaType == this.mediaType &&
          other.status == this.status &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterUrl == this.posterUrl &&
          other.voteAverage == this.voteAverage &&
          other.releaseDate == this.releaseDate &&
          other.totalDurationInMinutes == this.totalDurationInMinutes &&
          other.numberOfSeasons == this.numberOfSeasons &&
          other.numberOfEpisodes == this.numberOfEpisodes &&
          other.platforms == this.platforms);
}

class MediaItemsCompanion extends UpdateCompanion<MediaItemEntry> {
  final Value<int> id;
  final Value<MediaType> mediaType;
  final Value<MediaStatus> status;
  final Value<String> title;
  final Value<String> overview;
  final Value<String> posterUrl;
  final Value<double> voteAverage;
  final Value<String> releaseDate;
  final Value<int> totalDurationInMinutes;
  final Value<int?> numberOfSeasons;
  final Value<int?> numberOfEpisodes;
  final Value<String?> platforms;
  final Value<int> rowid;
  const MediaItemsCompanion({
    this.id = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterUrl = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.totalDurationInMinutes = const Value.absent(),
    this.numberOfSeasons = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.platforms = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaItemsCompanion.insert({
    required int id,
    required MediaType mediaType,
    required MediaStatus status,
    required String title,
    required String overview,
    required String posterUrl,
    required double voteAverage,
    required String releaseDate,
    required int totalDurationInMinutes,
    this.numberOfSeasons = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.platforms = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mediaType = Value(mediaType),
       status = Value(status),
       title = Value(title),
       overview = Value(overview),
       posterUrl = Value(posterUrl),
       voteAverage = Value(voteAverage),
       releaseDate = Value(releaseDate),
       totalDurationInMinutes = Value(totalDurationInMinutes);
  static Insertable<MediaItemEntry> custom({
    Expression<int>? id,
    Expression<String>? mediaType,
    Expression<String>? status,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterUrl,
    Expression<double>? voteAverage,
    Expression<String>? releaseDate,
    Expression<int>? totalDurationInMinutes,
    Expression<int>? numberOfSeasons,
    Expression<int>? numberOfEpisodes,
    Expression<String>? platforms,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mediaType != null) 'media_type': mediaType,
      if (status != null) 'status': status,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterUrl != null) 'poster_url': posterUrl,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (releaseDate != null) 'release_date': releaseDate,
      if (totalDurationInMinutes != null)
        'total_duration_in_minutes': totalDurationInMinutes,
      if (numberOfSeasons != null) 'number_of_seasons': numberOfSeasons,
      if (numberOfEpisodes != null) 'number_of_episodes': numberOfEpisodes,
      if (platforms != null) 'platforms': platforms,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaItemsCompanion copyWith({
    Value<int>? id,
    Value<MediaType>? mediaType,
    Value<MediaStatus>? status,
    Value<String>? title,
    Value<String>? overview,
    Value<String>? posterUrl,
    Value<double>? voteAverage,
    Value<String>? releaseDate,
    Value<int>? totalDurationInMinutes,
    Value<int?>? numberOfSeasons,
    Value<int?>? numberOfEpisodes,
    Value<String?>? platforms,
    Value<int>? rowid,
  }) {
    return MediaItemsCompanion(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      status: status ?? this.status,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterUrl: posterUrl ?? this.posterUrl,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      totalDurationInMinutes:
          totalDurationInMinutes ?? this.totalDurationInMinutes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      platforms: platforms ?? this.platforms,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
        $MediaItemsTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $MediaItemsTable.$converterstatus.toSql(status.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterUrl.present) {
      map['poster_url'] = Variable<String>(posterUrl.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (totalDurationInMinutes.present) {
      map['total_duration_in_minutes'] = Variable<int>(
        totalDurationInMinutes.value,
      );
    }
    if (numberOfSeasons.present) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons.value);
    }
    if (numberOfEpisodes.present) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes.value);
    }
    if (platforms.present) {
      map['platforms'] = Variable<String>(platforms.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemsCompanion(')
          ..write('id: $id, ')
          ..write('mediaType: $mediaType, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterUrl: $posterUrl, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('totalDurationInMinutes: $totalDurationInMinutes, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('platforms: $platforms, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MediaItemsTable mediaItems = $MediaItemsTable(this);
  late final MediaDao mediaDao = MediaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mediaItems];
}

typedef $$MediaItemsTableCreateCompanionBuilder =
    MediaItemsCompanion Function({
      required int id,
      required MediaType mediaType,
      required MediaStatus status,
      required String title,
      required String overview,
      required String posterUrl,
      required double voteAverage,
      required String releaseDate,
      required int totalDurationInMinutes,
      Value<int?> numberOfSeasons,
      Value<int?> numberOfEpisodes,
      Value<String?> platforms,
      Value<int> rowid,
    });
typedef $$MediaItemsTableUpdateCompanionBuilder =
    MediaItemsCompanion Function({
      Value<int> id,
      Value<MediaType> mediaType,
      Value<MediaStatus> status,
      Value<String> title,
      Value<String> overview,
      Value<String> posterUrl,
      Value<double> voteAverage,
      Value<String> releaseDate,
      Value<int> totalDurationInMinutes,
      Value<int?> numberOfSeasons,
      Value<int?> numberOfEpisodes,
      Value<String?> platforms,
      Value<int> rowid,
    });

class $$MediaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaType, MediaType, String> get mediaType =>
      $composableBuilder(
        column: $table.mediaType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<MediaStatus, MediaStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterUrl => $composableBuilder(
    column: $table.posterUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDurationInMinutes => $composableBuilder(
    column: $table.totalDurationInMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platforms => $composableBuilder(
    column: $table.platforms,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MediaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterUrl => $composableBuilder(
    column: $table.posterUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDurationInMinutes => $composableBuilder(
    column: $table.totalDurationInMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platforms => $composableBuilder(
    column: $table.platforms,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MediaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MediaType, String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MediaStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterUrl =>
      $composableBuilder(column: $table.posterUrl, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
    column: $table.voteAverage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDurationInMinutes => $composableBuilder(
    column: $table.totalDurationInMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfSeasons => $composableBuilder(
    column: $table.numberOfSeasons,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfEpisodes => $composableBuilder(
    column: $table.numberOfEpisodes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platforms =>
      $composableBuilder(column: $table.platforms, builder: (column) => column);
}

class $$MediaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaItemsTable,
          MediaItemEntry,
          $$MediaItemsTableFilterComposer,
          $$MediaItemsTableOrderingComposer,
          $$MediaItemsTableAnnotationComposer,
          $$MediaItemsTableCreateCompanionBuilder,
          $$MediaItemsTableUpdateCompanionBuilder,
          (
            MediaItemEntry,
            BaseReferences<_$AppDatabase, $MediaItemsTable, MediaItemEntry>,
          ),
          MediaItemEntry,
          PrefetchHooks Function()
        > {
  $$MediaItemsTableTableManager(_$AppDatabase db, $MediaItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MediaType> mediaType = const Value.absent(),
                Value<MediaStatus> status = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<String> posterUrl = const Value.absent(),
                Value<double> voteAverage = const Value.absent(),
                Value<String> releaseDate = const Value.absent(),
                Value<int> totalDurationInMinutes = const Value.absent(),
                Value<int?> numberOfSeasons = const Value.absent(),
                Value<int?> numberOfEpisodes = const Value.absent(),
                Value<String?> platforms = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion(
                id: id,
                mediaType: mediaType,
                status: status,
                title: title,
                overview: overview,
                posterUrl: posterUrl,
                voteAverage: voteAverage,
                releaseDate: releaseDate,
                totalDurationInMinutes: totalDurationInMinutes,
                numberOfSeasons: numberOfSeasons,
                numberOfEpisodes: numberOfEpisodes,
                platforms: platforms,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required MediaType mediaType,
                required MediaStatus status,
                required String title,
                required String overview,
                required String posterUrl,
                required double voteAverage,
                required String releaseDate,
                required int totalDurationInMinutes,
                Value<int?> numberOfSeasons = const Value.absent(),
                Value<int?> numberOfEpisodes = const Value.absent(),
                Value<String?> platforms = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion.insert(
                id: id,
                mediaType: mediaType,
                status: status,
                title: title,
                overview: overview,
                posterUrl: posterUrl,
                voteAverage: voteAverage,
                releaseDate: releaseDate,
                totalDurationInMinutes: totalDurationInMinutes,
                numberOfSeasons: numberOfSeasons,
                numberOfEpisodes: numberOfEpisodes,
                platforms: platforms,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MediaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaItemsTable,
      MediaItemEntry,
      $$MediaItemsTableFilterComposer,
      $$MediaItemsTableOrderingComposer,
      $$MediaItemsTableAnnotationComposer,
      $$MediaItemsTableCreateCompanionBuilder,
      $$MediaItemsTableUpdateCompanionBuilder,
      (
        MediaItemEntry,
        BaseReferences<_$AppDatabase, $MediaItemsTable, MediaItemEntry>,
      ),
      MediaItemEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db, _db.mediaItems);
}

mixin _$MediaDaoMixin on DatabaseAccessor<AppDatabase> {
  $MediaItemsTable get mediaItems => attachedDatabase.mediaItems;
}
