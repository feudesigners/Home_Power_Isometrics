// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MetaEntriesTable extends MetaEntries
    with TableInfo<$MetaEntriesTable, MetaEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MetaEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $MetaEntriesTable createAlias(String alias) {
    return $MetaEntriesTable(attachedDatabase, alias);
  }
}

class MetaEntry extends DataClass implements Insertable<MetaEntry> {
  final String key;
  final String value;
  const MetaEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MetaEntriesCompanion toCompanion(bool nullToAbsent) {
    return MetaEntriesCompanion(key: Value(key), value: Value(value));
  }

  factory MetaEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  MetaEntry copyWith({String? key, String? value}) =>
      MetaEntry(key: key ?? this.key, value: value ?? this.value);
  MetaEntry copyWithCompanion(MetaEntriesCompanion data) {
    return MetaEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class MetaEntriesCompanion extends UpdateCompanion<MetaEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MetaEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaEntriesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<MetaEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return MetaEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Athlete'),
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startingLevelMeta = const VerificationMeta(
    'startingLevel',
  );
  @override
  late final GeneratedColumn<String> startingLevel = GeneratedColumn<String>(
    'starting_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('foundation'),
  );
  static const VerificationMeta _preferredSessionMinutesMeta =
      const VerificationMeta('preferredSessionMinutes');
  @override
  late final GeneratedColumn<int> preferredSessionMinutes =
      GeneratedColumn<int>(
        'preferred_session_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(10),
      );
  static const VerificationMeta _weeklyWorkoutTargetMeta =
      const VerificationMeta('weeklyWorkoutTarget');
  @override
  late final GeneratedColumn<int> weeklyWorkoutTarget = GeneratedColumn<int>(
    'weekly_workout_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _selectedAvatarIdMeta = const VerificationMeta(
    'selectedAvatarId',
  );
  @override
  late final GeneratedColumn<String> selectedAvatarId = GeneratedColumn<String>(
    'selected_avatar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pulse'),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onboardingStepMeta = const VerificationMeta(
    'onboardingStep',
  );
  @override
  late final GeneratedColumn<int> onboardingStep = GeneratedColumn<int>(
    'onboarding_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _disclaimerAcceptedMeta =
      const VerificationMeta('disclaimerAccepted');
  @override
  late final GeneratedColumn<bool> disclaimerAccepted = GeneratedColumn<bool>(
    'disclaimer_accepted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("disclaimer_accepted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    goal,
    startingLevel,
    preferredSessionMinutes,
    weeklyWorkoutTarget,
    selectedAvatarId,
    onboardingComplete,
    onboardingStep,
    disclaimerAccepted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('starting_level')) {
      context.handle(
        _startingLevelMeta,
        startingLevel.isAcceptableOrUnknown(
          data['starting_level']!,
          _startingLevelMeta,
        ),
      );
    }
    if (data.containsKey('preferred_session_minutes')) {
      context.handle(
        _preferredSessionMinutesMeta,
        preferredSessionMinutes.isAcceptableOrUnknown(
          data['preferred_session_minutes']!,
          _preferredSessionMinutesMeta,
        ),
      );
    }
    if (data.containsKey('weekly_workout_target')) {
      context.handle(
        _weeklyWorkoutTargetMeta,
        weeklyWorkoutTarget.isAcceptableOrUnknown(
          data['weekly_workout_target']!,
          _weeklyWorkoutTargetMeta,
        ),
      );
    }
    if (data.containsKey('selected_avatar_id')) {
      context.handle(
        _selectedAvatarIdMeta,
        selectedAvatarId.isAcceptableOrUnknown(
          data['selected_avatar_id']!,
          _selectedAvatarIdMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_step')) {
      context.handle(
        _onboardingStepMeta,
        onboardingStep.isAcceptableOrUnknown(
          data['onboarding_step']!,
          _onboardingStepMeta,
        ),
      );
    }
    if (data.containsKey('disclaimer_accepted')) {
      context.handle(
        _disclaimerAcceptedMeta,
        disclaimerAccepted.isAcceptableOrUnknown(
          data['disclaimer_accepted']!,
          _disclaimerAcceptedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      startingLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}starting_level'],
      )!,
      preferredSessionMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_session_minutes'],
      )!,
      weeklyWorkoutTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_workout_target'],
      )!,
      selectedAvatarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_avatar_id'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      onboardingStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}onboarding_step'],
      )!,
      disclaimerAccepted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}disclaimer_accepted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String displayName;
  final String? goal;
  final String startingLevel;
  final int preferredSessionMinutes;
  final int weeklyWorkoutTarget;
  final String selectedAvatarId;
  final bool onboardingComplete;
  final int onboardingStep;
  final bool disclaimerAccepted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    required this.displayName,
    this.goal,
    required this.startingLevel,
    required this.preferredSessionMinutes,
    required this.weeklyWorkoutTarget,
    required this.selectedAvatarId,
    required this.onboardingComplete,
    required this.onboardingStep,
    required this.disclaimerAccepted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    map['starting_level'] = Variable<String>(startingLevel);
    map['preferred_session_minutes'] = Variable<int>(preferredSessionMinutes);
    map['weekly_workout_target'] = Variable<int>(weeklyWorkoutTarget);
    map['selected_avatar_id'] = Variable<String>(selectedAvatarId);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['onboarding_step'] = Variable<int>(onboardingStep);
    map['disclaimer_accepted'] = Variable<bool>(disclaimerAccepted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      startingLevel: Value(startingLevel),
      preferredSessionMinutes: Value(preferredSessionMinutes),
      weeklyWorkoutTarget: Value(weeklyWorkoutTarget),
      selectedAvatarId: Value(selectedAvatarId),
      onboardingComplete: Value(onboardingComplete),
      onboardingStep: Value(onboardingStep),
      disclaimerAccepted: Value(disclaimerAccepted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      goal: serializer.fromJson<String?>(json['goal']),
      startingLevel: serializer.fromJson<String>(json['startingLevel']),
      preferredSessionMinutes: serializer.fromJson<int>(
        json['preferredSessionMinutes'],
      ),
      weeklyWorkoutTarget: serializer.fromJson<int>(
        json['weeklyWorkoutTarget'],
      ),
      selectedAvatarId: serializer.fromJson<String>(json['selectedAvatarId']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      onboardingStep: serializer.fromJson<int>(json['onboardingStep']),
      disclaimerAccepted: serializer.fromJson<bool>(json['disclaimerAccepted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'goal': serializer.toJson<String?>(goal),
      'startingLevel': serializer.toJson<String>(startingLevel),
      'preferredSessionMinutes': serializer.toJson<int>(
        preferredSessionMinutes,
      ),
      'weeklyWorkoutTarget': serializer.toJson<int>(weeklyWorkoutTarget),
      'selectedAvatarId': serializer.toJson<String>(selectedAvatarId),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'onboardingStep': serializer.toJson<int>(onboardingStep),
      'disclaimerAccepted': serializer.toJson<bool>(disclaimerAccepted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    int? id,
    String? displayName,
    Value<String?> goal = const Value.absent(),
    String? startingLevel,
    int? preferredSessionMinutes,
    int? weeklyWorkoutTarget,
    String? selectedAvatarId,
    bool? onboardingComplete,
    int? onboardingStep,
    bool? disclaimerAccepted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    goal: goal.present ? goal.value : this.goal,
    startingLevel: startingLevel ?? this.startingLevel,
    preferredSessionMinutes:
        preferredSessionMinutes ?? this.preferredSessionMinutes,
    weeklyWorkoutTarget: weeklyWorkoutTarget ?? this.weeklyWorkoutTarget,
    selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    onboardingStep: onboardingStep ?? this.onboardingStep,
    disclaimerAccepted: disclaimerAccepted ?? this.disclaimerAccepted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      goal: data.goal.present ? data.goal.value : this.goal,
      startingLevel: data.startingLevel.present
          ? data.startingLevel.value
          : this.startingLevel,
      preferredSessionMinutes: data.preferredSessionMinutes.present
          ? data.preferredSessionMinutes.value
          : this.preferredSessionMinutes,
      weeklyWorkoutTarget: data.weeklyWorkoutTarget.present
          ? data.weeklyWorkoutTarget.value
          : this.weeklyWorkoutTarget,
      selectedAvatarId: data.selectedAvatarId.present
          ? data.selectedAvatarId.value
          : this.selectedAvatarId,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      onboardingStep: data.onboardingStep.present
          ? data.onboardingStep.value
          : this.onboardingStep,
      disclaimerAccepted: data.disclaimerAccepted.present
          ? data.disclaimerAccepted.value
          : this.disclaimerAccepted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('goal: $goal, ')
          ..write('startingLevel: $startingLevel, ')
          ..write('preferredSessionMinutes: $preferredSessionMinutes, ')
          ..write('weeklyWorkoutTarget: $weeklyWorkoutTarget, ')
          ..write('selectedAvatarId: $selectedAvatarId, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('onboardingStep: $onboardingStep, ')
          ..write('disclaimerAccepted: $disclaimerAccepted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    goal,
    startingLevel,
    preferredSessionMinutes,
    weeklyWorkoutTarget,
    selectedAvatarId,
    onboardingComplete,
    onboardingStep,
    disclaimerAccepted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.goal == this.goal &&
          other.startingLevel == this.startingLevel &&
          other.preferredSessionMinutes == this.preferredSessionMinutes &&
          other.weeklyWorkoutTarget == this.weeklyWorkoutTarget &&
          other.selectedAvatarId == this.selectedAvatarId &&
          other.onboardingComplete == this.onboardingComplete &&
          other.onboardingStep == this.onboardingStep &&
          other.disclaimerAccepted == this.disclaimerAccepted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String?> goal;
  final Value<String> startingLevel;
  final Value<int> preferredSessionMinutes;
  final Value<int> weeklyWorkoutTarget;
  final Value<String> selectedAvatarId;
  final Value<bool> onboardingComplete;
  final Value<int> onboardingStep;
  final Value<bool> disclaimerAccepted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.goal = const Value.absent(),
    this.startingLevel = const Value.absent(),
    this.preferredSessionMinutes = const Value.absent(),
    this.weeklyWorkoutTarget = const Value.absent(),
    this.selectedAvatarId = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.onboardingStep = const Value.absent(),
    this.disclaimerAccepted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.goal = const Value.absent(),
    this.startingLevel = const Value.absent(),
    this.preferredSessionMinutes = const Value.absent(),
    this.weeklyWorkoutTarget = const Value.absent(),
    this.selectedAvatarId = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.onboardingStep = const Value.absent(),
    this.disclaimerAccepted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? goal,
    Expression<String>? startingLevel,
    Expression<int>? preferredSessionMinutes,
    Expression<int>? weeklyWorkoutTarget,
    Expression<String>? selectedAvatarId,
    Expression<bool>? onboardingComplete,
    Expression<int>? onboardingStep,
    Expression<bool>? disclaimerAccepted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (goal != null) 'goal': goal,
      if (startingLevel != null) 'starting_level': startingLevel,
      if (preferredSessionMinutes != null)
        'preferred_session_minutes': preferredSessionMinutes,
      if (weeklyWorkoutTarget != null)
        'weekly_workout_target': weeklyWorkoutTarget,
      if (selectedAvatarId != null) 'selected_avatar_id': selectedAvatarId,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (onboardingStep != null) 'onboarding_step': onboardingStep,
      if (disclaimerAccepted != null) 'disclaimer_accepted': disclaimerAccepted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<String?>? goal,
    Value<String>? startingLevel,
    Value<int>? preferredSessionMinutes,
    Value<int>? weeklyWorkoutTarget,
    Value<String>? selectedAvatarId,
    Value<bool>? onboardingComplete,
    Value<int>? onboardingStep,
    Value<bool>? disclaimerAccepted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      goal: goal ?? this.goal,
      startingLevel: startingLevel ?? this.startingLevel,
      preferredSessionMinutes:
          preferredSessionMinutes ?? this.preferredSessionMinutes,
      weeklyWorkoutTarget: weeklyWorkoutTarget ?? this.weeklyWorkoutTarget,
      selectedAvatarId: selectedAvatarId ?? this.selectedAvatarId,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      onboardingStep: onboardingStep ?? this.onboardingStep,
      disclaimerAccepted: disclaimerAccepted ?? this.disclaimerAccepted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (startingLevel.present) {
      map['starting_level'] = Variable<String>(startingLevel.value);
    }
    if (preferredSessionMinutes.present) {
      map['preferred_session_minutes'] = Variable<int>(
        preferredSessionMinutes.value,
      );
    }
    if (weeklyWorkoutTarget.present) {
      map['weekly_workout_target'] = Variable<int>(weeklyWorkoutTarget.value);
    }
    if (selectedAvatarId.present) {
      map['selected_avatar_id'] = Variable<String>(selectedAvatarId.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (onboardingStep.present) {
      map['onboarding_step'] = Variable<int>(onboardingStep.value);
    }
    if (disclaimerAccepted.present) {
      map['disclaimer_accepted'] = Variable<bool>(disclaimerAccepted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('goal: $goal, ')
          ..write('startingLevel: $startingLevel, ')
          ..write('preferredSessionMinutes: $preferredSessionMinutes, ')
          ..write('weeklyWorkoutTarget: $weeklyWorkoutTarget, ')
          ..write('selectedAvatarId: $selectedAvatarId, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('onboardingStep: $onboardingStep, ')
          ..write('disclaimerAccepted: $disclaimerAccepted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _audioEnabledMeta = const VerificationMeta(
    'audioEnabled',
  );
  @override
  late final GeneratedColumn<bool> audioEnabled = GeneratedColumn<bool>(
    'audio_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("audio_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _voiceEnabledMeta = const VerificationMeta(
    'voiceEnabled',
  );
  @override
  late final GeneratedColumn<bool> voiceEnabled = GeneratedColumn<bool>(
    'voice_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("voice_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _hapticsEnabledMeta = const VerificationMeta(
    'hapticsEnabled',
  );
  @override
  late final GeneratedColumn<bool> hapticsEnabled = GeneratedColumn<bool>(
    'haptics_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("haptics_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reducedMotionMeta = const VerificationMeta(
    'reducedMotion',
  );
  @override
  late final GeneratedColumn<bool> reducedMotion = GeneratedColumn<bool>(
    'reduced_motion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reduced_motion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    theme,
    audioEnabled,
    voiceEnabled,
    hapticsEnabled,
    reducedMotion,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('audio_enabled')) {
      context.handle(
        _audioEnabledMeta,
        audioEnabled.isAcceptableOrUnknown(
          data['audio_enabled']!,
          _audioEnabledMeta,
        ),
      );
    }
    if (data.containsKey('voice_enabled')) {
      context.handle(
        _voiceEnabledMeta,
        voiceEnabled.isAcceptableOrUnknown(
          data['voice_enabled']!,
          _voiceEnabledMeta,
        ),
      );
    }
    if (data.containsKey('haptics_enabled')) {
      context.handle(
        _hapticsEnabledMeta,
        hapticsEnabled.isAcceptableOrUnknown(
          data['haptics_enabled']!,
          _hapticsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reduced_motion')) {
      context.handle(
        _reducedMotionMeta,
        reducedMotion.isAcceptableOrUnknown(
          data['reduced_motion']!,
          _reducedMotionMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
      audioEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}audio_enabled'],
      )!,
      voiceEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}voice_enabled'],
      )!,
      hapticsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}haptics_enabled'],
      )!,
      reducedMotion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reduced_motion'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final int id;
  final String theme;
  final bool audioEnabled;
  final bool voiceEnabled;
  final bool hapticsEnabled;
  final bool reducedMotion;
  final DateTime updatedAt;
  const UserPreference({
    required this.id,
    required this.theme,
    required this.audioEnabled,
    required this.voiceEnabled,
    required this.hapticsEnabled,
    required this.reducedMotion,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme'] = Variable<String>(theme);
    map['audio_enabled'] = Variable<bool>(audioEnabled);
    map['voice_enabled'] = Variable<bool>(voiceEnabled);
    map['haptics_enabled'] = Variable<bool>(hapticsEnabled);
    map['reduced_motion'] = Variable<bool>(reducedMotion);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      id: Value(id),
      theme: Value(theme),
      audioEnabled: Value(audioEnabled),
      voiceEnabled: Value(voiceEnabled),
      hapticsEnabled: Value(hapticsEnabled),
      reducedMotion: Value(reducedMotion),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      id: serializer.fromJson<int>(json['id']),
      theme: serializer.fromJson<String>(json['theme']),
      audioEnabled: serializer.fromJson<bool>(json['audioEnabled']),
      voiceEnabled: serializer.fromJson<bool>(json['voiceEnabled']),
      hapticsEnabled: serializer.fromJson<bool>(json['hapticsEnabled']),
      reducedMotion: serializer.fromJson<bool>(json['reducedMotion']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'theme': serializer.toJson<String>(theme),
      'audioEnabled': serializer.toJson<bool>(audioEnabled),
      'voiceEnabled': serializer.toJson<bool>(voiceEnabled),
      'hapticsEnabled': serializer.toJson<bool>(hapticsEnabled),
      'reducedMotion': serializer.toJson<bool>(reducedMotion),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreference copyWith({
    int? id,
    String? theme,
    bool? audioEnabled,
    bool? voiceEnabled,
    bool? hapticsEnabled,
    bool? reducedMotion,
    DateTime? updatedAt,
  }) => UserPreference(
    id: id ?? this.id,
    theme: theme ?? this.theme,
    audioEnabled: audioEnabled ?? this.audioEnabled,
    voiceEnabled: voiceEnabled ?? this.voiceEnabled,
    hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
    reducedMotion: reducedMotion ?? this.reducedMotion,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      id: data.id.present ? data.id.value : this.id,
      theme: data.theme.present ? data.theme.value : this.theme,
      audioEnabled: data.audioEnabled.present
          ? data.audioEnabled.value
          : this.audioEnabled,
      voiceEnabled: data.voiceEnabled.present
          ? data.voiceEnabled.value
          : this.voiceEnabled,
      hapticsEnabled: data.hapticsEnabled.present
          ? data.hapticsEnabled.value
          : this.hapticsEnabled,
      reducedMotion: data.reducedMotion.present
          ? data.reducedMotion.value
          : this.reducedMotion,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('audioEnabled: $audioEnabled, ')
          ..write('voiceEnabled: $voiceEnabled, ')
          ..write('hapticsEnabled: $hapticsEnabled, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    theme,
    audioEnabled,
    voiceEnabled,
    hapticsEnabled,
    reducedMotion,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.id == this.id &&
          other.theme == this.theme &&
          other.audioEnabled == this.audioEnabled &&
          other.voiceEnabled == this.voiceEnabled &&
          other.hapticsEnabled == this.hapticsEnabled &&
          other.reducedMotion == this.reducedMotion &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<int> id;
  final Value<String> theme;
  final Value<bool> audioEnabled;
  final Value<bool> voiceEnabled;
  final Value<bool> hapticsEnabled;
  final Value<bool> reducedMotion;
  final Value<DateTime> updatedAt;
  const UserPreferencesCompanion({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.audioEnabled = const Value.absent(),
    this.voiceEnabled = const Value.absent(),
    this.hapticsEnabled = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.audioEnabled = const Value.absent(),
    this.voiceEnabled = const Value.absent(),
    this.hapticsEnabled = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserPreference> custom({
    Expression<int>? id,
    Expression<String>? theme,
    Expression<bool>? audioEnabled,
    Expression<bool>? voiceEnabled,
    Expression<bool>? hapticsEnabled,
    Expression<bool>? reducedMotion,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (theme != null) 'theme': theme,
      if (audioEnabled != null) 'audio_enabled': audioEnabled,
      if (voiceEnabled != null) 'voice_enabled': voiceEnabled,
      if (hapticsEnabled != null) 'haptics_enabled': hapticsEnabled,
      if (reducedMotion != null) 'reduced_motion': reducedMotion,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? theme,
    Value<bool>? audioEnabled,
    Value<bool>? voiceEnabled,
    Value<bool>? hapticsEnabled,
    Value<bool>? reducedMotion,
    Value<DateTime>? updatedAt,
  }) {
    return UserPreferencesCompanion(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      audioEnabled: audioEnabled ?? this.audioEnabled,
      voiceEnabled: voiceEnabled ?? this.voiceEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (audioEnabled.present) {
      map['audio_enabled'] = Variable<bool>(audioEnabled.value);
    }
    if (voiceEnabled.present) {
      map['voice_enabled'] = Variable<bool>(voiceEnabled.value);
    }
    if (hapticsEnabled.present) {
      map['haptics_enabled'] = Variable<bool>(hapticsEnabled.value);
    }
    if (reducedMotion.present) {
      map['reduced_motion'] = Variable<bool>(reducedMotion.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('audioEnabled: $audioEnabled, ')
          ..write('voiceEnabled: $voiceEnabled, ')
          ..write('hapticsEnabled: $hapticsEnabled, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HealthCautionPreferencesTable extends HealthCautionPreferences
    with TableInfo<$HealthCautionPreferencesTable, HealthCautionPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthCautionPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedMeta = const VerificationMeta(
    'selected',
  );
  @override
  late final GeneratedColumn<bool> selected = GeneratedColumn<bool>(
    'selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("selected" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tag, selected];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_caution_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthCautionPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('selected')) {
      context.handle(
        _selectedMeta,
        selected.isAcceptableOrUnknown(data['selected']!, _selectedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthCautionPreference map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthCautionPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
      selected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}selected'],
      )!,
    );
  }

  @override
  $HealthCautionPreferencesTable createAlias(String alias) {
    return $HealthCautionPreferencesTable(attachedDatabase, alias);
  }
}

class HealthCautionPreference extends DataClass
    implements Insertable<HealthCautionPreference> {
  final int id;
  final String tag;
  final bool selected;
  const HealthCautionPreference({
    required this.id,
    required this.tag,
    required this.selected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag'] = Variable<String>(tag);
    map['selected'] = Variable<bool>(selected);
    return map;
  }

  HealthCautionPreferencesCompanion toCompanion(bool nullToAbsent) {
    return HealthCautionPreferencesCompanion(
      id: Value(id),
      tag: Value(tag),
      selected: Value(selected),
    );
  }

  factory HealthCautionPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthCautionPreference(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
      selected: serializer.fromJson<bool>(json['selected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String>(tag),
      'selected': serializer.toJson<bool>(selected),
    };
  }

  HealthCautionPreference copyWith({int? id, String? tag, bool? selected}) =>
      HealthCautionPreference(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        selected: selected ?? this.selected,
      );
  HealthCautionPreference copyWithCompanion(
    HealthCautionPreferencesCompanion data,
  ) {
    return HealthCautionPreference(
      id: data.id.present ? data.id.value : this.id,
      tag: data.tag.present ? data.tag.value : this.tag,
      selected: data.selected.present ? data.selected.value : this.selected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthCautionPreference(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tag, selected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthCautionPreference &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.selected == this.selected);
}

class HealthCautionPreferencesCompanion
    extends UpdateCompanion<HealthCautionPreference> {
  final Value<int> id;
  final Value<String> tag;
  final Value<bool> selected;
  const HealthCautionPreferencesCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.selected = const Value.absent(),
  });
  HealthCautionPreferencesCompanion.insert({
    this.id = const Value.absent(),
    required String tag,
    this.selected = const Value.absent(),
  }) : tag = Value(tag);
  static Insertable<HealthCautionPreference> custom({
    Expression<int>? id,
    Expression<String>? tag,
    Expression<bool>? selected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (selected != null) 'selected': selected,
    });
  }

  HealthCautionPreferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? tag,
    Value<bool>? selected,
  }) {
    return HealthCautionPreferencesCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      selected: selected ?? this.selected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (selected.present) {
      map['selected'] = Variable<bool>(selected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthCautionPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('selected: $selected')
          ..write(')'))
        .toString();
  }
}

class $ReminderSchedulesTable extends ReminderSchedules
    with TableInfo<$ReminderSchedulesTable, ReminderSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _weekdaysCsvMeta = const VerificationMeta(
    'weekdaysCsv',
  );
  @override
  late final GeneratedColumn<String> weekdaysCsv = GeneratedColumn<String>(
    'weekdays_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1,3,5'),
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weekdaysCsv,
    hour,
    minute,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderSchedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('weekdays_csv')) {
      context.handle(
        _weekdaysCsvMeta,
        weekdaysCsv.isAcceptableOrUnknown(
          data['weekdays_csv']!,
          _weekdaysCsvMeta,
        ),
      );
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderSchedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      weekdaysCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays_csv'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $ReminderSchedulesTable createAlias(String alias) {
    return $ReminderSchedulesTable(attachedDatabase, alias);
  }
}

class ReminderSchedule extends DataClass
    implements Insertable<ReminderSchedule> {
  final int id;
  final String weekdaysCsv;
  final int hour;
  final int minute;
  final bool enabled;
  const ReminderSchedule({
    required this.id,
    required this.weekdaysCsv,
    required this.hour,
    required this.minute,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['weekdays_csv'] = Variable<String>(weekdaysCsv);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  ReminderSchedulesCompanion toCompanion(bool nullToAbsent) {
    return ReminderSchedulesCompanion(
      id: Value(id),
      weekdaysCsv: Value(weekdaysCsv),
      hour: Value(hour),
      minute: Value(minute),
      enabled: Value(enabled),
    );
  }

  factory ReminderSchedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderSchedule(
      id: serializer.fromJson<int>(json['id']),
      weekdaysCsv: serializer.fromJson<String>(json['weekdaysCsv']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weekdaysCsv': serializer.toJson<String>(weekdaysCsv),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  ReminderSchedule copyWith({
    int? id,
    String? weekdaysCsv,
    int? hour,
    int? minute,
    bool? enabled,
  }) => ReminderSchedule(
    id: id ?? this.id,
    weekdaysCsv: weekdaysCsv ?? this.weekdaysCsv,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    enabled: enabled ?? this.enabled,
  );
  ReminderSchedule copyWithCompanion(ReminderSchedulesCompanion data) {
    return ReminderSchedule(
      id: data.id.present ? data.id.value : this.id,
      weekdaysCsv: data.weekdaysCsv.present
          ? data.weekdaysCsv.value
          : this.weekdaysCsv,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSchedule(')
          ..write('id: $id, ')
          ..write('weekdaysCsv: $weekdaysCsv, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weekdaysCsv, hour, minute, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderSchedule &&
          other.id == this.id &&
          other.weekdaysCsv == this.weekdaysCsv &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.enabled == this.enabled);
}

class ReminderSchedulesCompanion extends UpdateCompanion<ReminderSchedule> {
  final Value<int> id;
  final Value<String> weekdaysCsv;
  final Value<int> hour;
  final Value<int> minute;
  final Value<bool> enabled;
  const ReminderSchedulesCompanion({
    this.id = const Value.absent(),
    this.weekdaysCsv = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  ReminderSchedulesCompanion.insert({
    this.id = const Value.absent(),
    this.weekdaysCsv = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  static Insertable<ReminderSchedule> custom({
    Expression<int>? id,
    Expression<String>? weekdaysCsv,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekdaysCsv != null) 'weekdays_csv': weekdaysCsv,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (enabled != null) 'enabled': enabled,
    });
  }

  ReminderSchedulesCompanion copyWith({
    Value<int>? id,
    Value<String>? weekdaysCsv,
    Value<int>? hour,
    Value<int>? minute,
    Value<bool>? enabled,
  }) {
    return ReminderSchedulesCompanion(
      id: id ?? this.id,
      weekdaysCsv: weekdaysCsv ?? this.weekdaysCsv,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weekdaysCsv.present) {
      map['weekdays_csv'] = Variable<String>(weekdaysCsv.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('weekdaysCsv: $weekdaysCsv, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $ExerciseCategoriesTable extends ExerciseCategories
    with TableInfo<$ExerciseCategoriesTable, ExerciseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
    );
  }

  @override
  $ExerciseCategoriesTable createAlias(String alias) {
    return $ExerciseCategoriesTable(attachedDatabase, alias);
  }
}

class ExerciseCategory extends DataClass
    implements Insertable<ExerciseCategory> {
  final String id;
  final String name;
  final String colorHex;
  const ExerciseCategory({
    required this.id,
    required this.name,
    required this.colorHex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_hex'] = Variable<String>(colorHex);
    return map;
  }

  ExerciseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      colorHex: Value(colorHex),
    );
  }

  factory ExerciseCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String>(colorHex),
    };
  }

  ExerciseCategory copyWith({String? id, String? name, String? colorHex}) =>
      ExerciseCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        colorHex: colorHex ?? this.colorHex,
      );
  ExerciseCategory copyWithCompanion(ExerciseCategoriesCompanion data) {
    return ExerciseCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorHex == this.colorHex);
}

class ExerciseCategoriesCompanion extends UpdateCompanion<ExerciseCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> colorHex;
  final Value<int> rowid;
  const ExerciseCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseCategoriesCompanion.insert({
    required String id,
    required String name,
    required String colorHex,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       colorHex = Value(colorHex);
  static Insertable<ExerciseCategory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? colorHex,
    Value<int>? rowid,
  }) {
    return ExerciseCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryMusclesJsonMeta =
      const VerificationMeta('primaryMusclesJson');
  @override
  late final GeneratedColumn<String> primaryMusclesJson =
      GeneratedColumn<String>(
        'primary_muscles_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _secondaryMusclesJsonMeta =
      const VerificationMeta('secondaryMusclesJson');
  @override
  late final GeneratedColumn<String> secondaryMusclesJson =
      GeneratedColumn<String>(
        'secondary_muscles_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    primaryMusclesJson,
    secondaryMusclesJson,
    contentVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_muscles_json')) {
      context.handle(
        _primaryMusclesJsonMeta,
        primaryMusclesJson.isAcceptableOrUnknown(
          data['primary_muscles_json']!,
          _primaryMusclesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMusclesJsonMeta);
    }
    if (data.containsKey('secondary_muscles_json')) {
      context.handle(
        _secondaryMusclesJsonMeta,
        secondaryMusclesJson.isAcceptableOrUnknown(
          data['secondary_muscles_json']!,
          _secondaryMusclesJsonMeta,
        ),
      );
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      primaryMusclesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscles_json'],
      )!,
      secondaryMusclesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscles_json'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String categoryId;
  final String name;
  final String primaryMusclesJson;
  final String secondaryMusclesJson;
  final int contentVersion;
  const Exercise({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.primaryMusclesJson,
    required this.secondaryMusclesJson,
    required this.contentVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    map['primary_muscles_json'] = Variable<String>(primaryMusclesJson);
    map['secondary_muscles_json'] = Variable<String>(secondaryMusclesJson);
    map['content_version'] = Variable<int>(contentVersion);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      primaryMusclesJson: Value(primaryMusclesJson),
      secondaryMusclesJson: Value(secondaryMusclesJson),
      contentVersion: Value(contentVersion),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      primaryMusclesJson: serializer.fromJson<String>(
        json['primaryMusclesJson'],
      ),
      secondaryMusclesJson: serializer.fromJson<String>(
        json['secondaryMusclesJson'],
      ),
      contentVersion: serializer.fromJson<int>(json['contentVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'primaryMusclesJson': serializer.toJson<String>(primaryMusclesJson),
      'secondaryMusclesJson': serializer.toJson<String>(secondaryMusclesJson),
      'contentVersion': serializer.toJson<int>(contentVersion),
    };
  }

  Exercise copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? primaryMusclesJson,
    String? secondaryMusclesJson,
    int? contentVersion,
  }) => Exercise(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    primaryMusclesJson: primaryMusclesJson ?? this.primaryMusclesJson,
    secondaryMusclesJson: secondaryMusclesJson ?? this.secondaryMusclesJson,
    contentVersion: contentVersion ?? this.contentVersion,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      primaryMusclesJson: data.primaryMusclesJson.present
          ? data.primaryMusclesJson.value
          : this.primaryMusclesJson,
      secondaryMusclesJson: data.secondaryMusclesJson.present
          ? data.secondaryMusclesJson.value
          : this.secondaryMusclesJson,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('primaryMusclesJson: $primaryMusclesJson, ')
          ..write('secondaryMusclesJson: $secondaryMusclesJson, ')
          ..write('contentVersion: $contentVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    primaryMusclesJson,
    secondaryMusclesJson,
    contentVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.primaryMusclesJson == this.primaryMusclesJson &&
          other.secondaryMusclesJson == this.secondaryMusclesJson &&
          other.contentVersion == this.contentVersion);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<String> primaryMusclesJson;
  final Value<String> secondaryMusclesJson;
  final Value<int> contentVersion;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryMusclesJson = const Value.absent(),
    this.secondaryMusclesJson = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String categoryId,
    required String name,
    required String primaryMusclesJson,
    this.secondaryMusclesJson = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       name = Value(name),
       primaryMusclesJson = Value(primaryMusclesJson);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<String>? primaryMusclesJson,
    Expression<String>? secondaryMusclesJson,
    Expression<int>? contentVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (primaryMusclesJson != null)
        'primary_muscles_json': primaryMusclesJson,
      if (secondaryMusclesJson != null)
        'secondary_muscles_json': secondaryMusclesJson,
      if (contentVersion != null) 'content_version': contentVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? name,
    Value<String>? primaryMusclesJson,
    Value<String>? secondaryMusclesJson,
    Value<int>? contentVersion,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      primaryMusclesJson: primaryMusclesJson ?? this.primaryMusclesJson,
      secondaryMusclesJson: secondaryMusclesJson ?? this.secondaryMusclesJson,
      contentVersion: contentVersion ?? this.contentVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryMusclesJson.present) {
      map['primary_muscles_json'] = Variable<String>(primaryMusclesJson.value);
    }
    if (secondaryMusclesJson.present) {
      map['secondary_muscles_json'] = Variable<String>(
        secondaryMusclesJson.value,
      );
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('primaryMusclesJson: $primaryMusclesJson, ')
          ..write('secondaryMusclesJson: $secondaryMusclesJson, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseVariantsTable extends ExerciseVariants
    with TableInfo<$ExerciseVariantsTable, ExerciseVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseVariantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyRankMeta = const VerificationMeta(
    'difficultyRank',
  );
  @override
  late final GeneratedColumn<int> difficultyRank = GeneratedColumn<int>(
    'difficulty_rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryMusclesJsonMeta =
      const VerificationMeta('primaryMusclesJson');
  @override
  late final GeneratedColumn<String> primaryMusclesJson =
      GeneratedColumn<String>(
        'primary_muscles_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _secondaryMusclesJsonMeta =
      const VerificationMeta('secondaryMusclesJson');
  @override
  late final GeneratedColumn<String> secondaryMusclesJson =
      GeneratedColumn<String>(
        'secondary_muscles_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _equipmentJsonMeta = const VerificationMeta(
    'equipmentJson',
  );
  @override
  late final GeneratedColumn<String> equipmentJson = GeneratedColumn<String>(
    'equipment_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _unilateralModeMeta = const VerificationMeta(
    'unilateralMode',
  );
  @override
  late final GeneratedColumn<String> unilateralMode = GeneratedColumn<String>(
    'unilateral_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _targetHoldMsMeta = const VerificationMeta(
    'targetHoldMs',
  );
  @override
  late final GeneratedColumn<int> targetHoldMs = GeneratedColumn<int>(
    'target_hold_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setupDurationMsMeta = const VerificationMeta(
    'setupDurationMs',
  );
  @override
  late final GeneratedColumn<int> setupDurationMs = GeneratedColumn<int>(
    'setup_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5000),
  );
  static const VerificationMeta _restDurationMsMeta = const VerificationMeta(
    'restDurationMs',
  );
  @override
  late final GeneratedColumn<int> restDurationMs = GeneratedColumn<int>(
    'rest_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15000),
  );
  static const VerificationMeta _easierVariantIdMeta = const VerificationMeta(
    'easierVariantId',
  );
  @override
  late final GeneratedColumn<String> easierVariantId = GeneratedColumn<String>(
    'easier_variant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _harderVariantIdMeta = const VerificationMeta(
    'harderVariantId',
  );
  @override
  late final GeneratedColumn<String> harderVariantId = GeneratedColumn<String>(
    'harder_variant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breathingCueMeta = const VerificationMeta(
    'breathingCue',
  );
  @override
  late final GeneratedColumn<String> breathingCue = GeneratedColumn<String>(
    'breathing_cue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _commonMistakesJsonMeta =
      const VerificationMeta('commonMistakesJson');
  @override
  late final GeneratedColumn<String> commonMistakesJson =
      GeneratedColumn<String>(
        'common_mistakes_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _safetyNotesMeta = const VerificationMeta(
    'safetyNotes',
  );
  @override
  late final GeneratedColumn<String> safetyNotes = GeneratedColumn<String>(
    'safety_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _limitationTagsJsonMeta =
      const VerificationMeta('limitationTagsJson');
  @override
  late final GeneratedColumn<String> limitationTagsJson =
      GeneratedColumn<String>(
        'limitation_tags_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _staticAssetIdMeta = const VerificationMeta(
    'staticAssetId',
  );
  @override
  late final GeneratedColumn<String> staticAssetId = GeneratedColumn<String>(
    'static_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _animatedAssetIdMeta = const VerificationMeta(
    'animatedAssetId',
  );
  @override
  late final GeneratedColumn<String> animatedAssetId = GeneratedColumn<String>(
    'animated_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gatedForBeginnersMeta = const VerificationMeta(
    'gatedForBeginners',
  );
  @override
  late final GeneratedColumn<bool> gatedForBeginners = GeneratedColumn<bool>(
    'gated_for_beginners',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("gated_for_beginners" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reviewStatusMeta = const VerificationMeta(
    'reviewStatus',
  );
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
    'review_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('provisional'),
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    displayName,
    difficultyRank,
    categoryId,
    primaryMusclesJson,
    secondaryMusclesJson,
    equipmentJson,
    unilateralMode,
    targetHoldMs,
    setupDurationMs,
    restDurationMs,
    easierVariantId,
    harderVariantId,
    breathingCue,
    commonMistakesJson,
    safetyNotes,
    limitationTagsJson,
    staticAssetId,
    animatedAssetId,
    gatedForBeginners,
    reviewStatus,
    contentVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseVariant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('difficulty_rank')) {
      context.handle(
        _difficultyRankMeta,
        difficultyRank.isAcceptableOrUnknown(
          data['difficulty_rank']!,
          _difficultyRankMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_difficultyRankMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('primary_muscles_json')) {
      context.handle(
        _primaryMusclesJsonMeta,
        primaryMusclesJson.isAcceptableOrUnknown(
          data['primary_muscles_json']!,
          _primaryMusclesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMusclesJsonMeta);
    }
    if (data.containsKey('secondary_muscles_json')) {
      context.handle(
        _secondaryMusclesJsonMeta,
        secondaryMusclesJson.isAcceptableOrUnknown(
          data['secondary_muscles_json']!,
          _secondaryMusclesJsonMeta,
        ),
      );
    }
    if (data.containsKey('equipment_json')) {
      context.handle(
        _equipmentJsonMeta,
        equipmentJson.isAcceptableOrUnknown(
          data['equipment_json']!,
          _equipmentJsonMeta,
        ),
      );
    }
    if (data.containsKey('unilateral_mode')) {
      context.handle(
        _unilateralModeMeta,
        unilateralMode.isAcceptableOrUnknown(
          data['unilateral_mode']!,
          _unilateralModeMeta,
        ),
      );
    }
    if (data.containsKey('target_hold_ms')) {
      context.handle(
        _targetHoldMsMeta,
        targetHoldMs.isAcceptableOrUnknown(
          data['target_hold_ms']!,
          _targetHoldMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetHoldMsMeta);
    }
    if (data.containsKey('setup_duration_ms')) {
      context.handle(
        _setupDurationMsMeta,
        setupDurationMs.isAcceptableOrUnknown(
          data['setup_duration_ms']!,
          _setupDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('rest_duration_ms')) {
      context.handle(
        _restDurationMsMeta,
        restDurationMs.isAcceptableOrUnknown(
          data['rest_duration_ms']!,
          _restDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('easier_variant_id')) {
      context.handle(
        _easierVariantIdMeta,
        easierVariantId.isAcceptableOrUnknown(
          data['easier_variant_id']!,
          _easierVariantIdMeta,
        ),
      );
    }
    if (data.containsKey('harder_variant_id')) {
      context.handle(
        _harderVariantIdMeta,
        harderVariantId.isAcceptableOrUnknown(
          data['harder_variant_id']!,
          _harderVariantIdMeta,
        ),
      );
    }
    if (data.containsKey('breathing_cue')) {
      context.handle(
        _breathingCueMeta,
        breathingCue.isAcceptableOrUnknown(
          data['breathing_cue']!,
          _breathingCueMeta,
        ),
      );
    }
    if (data.containsKey('common_mistakes_json')) {
      context.handle(
        _commonMistakesJsonMeta,
        commonMistakesJson.isAcceptableOrUnknown(
          data['common_mistakes_json']!,
          _commonMistakesJsonMeta,
        ),
      );
    }
    if (data.containsKey('safety_notes')) {
      context.handle(
        _safetyNotesMeta,
        safetyNotes.isAcceptableOrUnknown(
          data['safety_notes']!,
          _safetyNotesMeta,
        ),
      );
    }
    if (data.containsKey('limitation_tags_json')) {
      context.handle(
        _limitationTagsJsonMeta,
        limitationTagsJson.isAcceptableOrUnknown(
          data['limitation_tags_json']!,
          _limitationTagsJsonMeta,
        ),
      );
    }
    if (data.containsKey('static_asset_id')) {
      context.handle(
        _staticAssetIdMeta,
        staticAssetId.isAcceptableOrUnknown(
          data['static_asset_id']!,
          _staticAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('animated_asset_id')) {
      context.handle(
        _animatedAssetIdMeta,
        animatedAssetId.isAcceptableOrUnknown(
          data['animated_asset_id']!,
          _animatedAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('gated_for_beginners')) {
      context.handle(
        _gatedForBeginnersMeta,
        gatedForBeginners.isAcceptableOrUnknown(
          data['gated_for_beginners']!,
          _gatedForBeginnersMeta,
        ),
      );
    }
    if (data.containsKey('review_status')) {
      context.handle(
        _reviewStatusMeta,
        reviewStatus.isAcceptableOrUnknown(
          data['review_status']!,
          _reviewStatusMeta,
        ),
      );
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseVariant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      difficultyRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty_rank'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      primaryMusclesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscles_json'],
      )!,
      secondaryMusclesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscles_json'],
      )!,
      equipmentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_json'],
      )!,
      unilateralMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unilateral_mode'],
      )!,
      targetHoldMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_hold_ms'],
      )!,
      setupDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}setup_duration_ms'],
      )!,
      restDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_duration_ms'],
      )!,
      easierVariantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}easier_variant_id'],
      ),
      harderVariantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}harder_variant_id'],
      ),
      breathingCue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breathing_cue'],
      )!,
      commonMistakesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_mistakes_json'],
      )!,
      safetyNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}safety_notes'],
      )!,
      limitationTagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}limitation_tags_json'],
      )!,
      staticAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}static_asset_id'],
      ),
      animatedAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animated_asset_id'],
      ),
      gatedForBeginners: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}gated_for_beginners'],
      )!,
      reviewStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_status'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
    );
  }

  @override
  $ExerciseVariantsTable createAlias(String alias) {
    return $ExerciseVariantsTable(attachedDatabase, alias);
  }
}

class ExerciseVariant extends DataClass implements Insertable<ExerciseVariant> {
  final String id;
  final String exerciseId;
  final String displayName;
  final int difficultyRank;
  final String categoryId;
  final String primaryMusclesJson;
  final String secondaryMusclesJson;
  final String equipmentJson;
  final String unilateralMode;
  final int targetHoldMs;
  final int setupDurationMs;
  final int restDurationMs;
  final String? easierVariantId;
  final String? harderVariantId;
  final String breathingCue;
  final String commonMistakesJson;
  final String safetyNotes;
  final String limitationTagsJson;
  final String? staticAssetId;
  final String? animatedAssetId;
  final bool gatedForBeginners;
  final String reviewStatus;
  final int contentVersion;
  const ExerciseVariant({
    required this.id,
    required this.exerciseId,
    required this.displayName,
    required this.difficultyRank,
    required this.categoryId,
    required this.primaryMusclesJson,
    required this.secondaryMusclesJson,
    required this.equipmentJson,
    required this.unilateralMode,
    required this.targetHoldMs,
    required this.setupDurationMs,
    required this.restDurationMs,
    this.easierVariantId,
    this.harderVariantId,
    required this.breathingCue,
    required this.commonMistakesJson,
    required this.safetyNotes,
    required this.limitationTagsJson,
    this.staticAssetId,
    this.animatedAssetId,
    required this.gatedForBeginners,
    required this.reviewStatus,
    required this.contentVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['display_name'] = Variable<String>(displayName);
    map['difficulty_rank'] = Variable<int>(difficultyRank);
    map['category_id'] = Variable<String>(categoryId);
    map['primary_muscles_json'] = Variable<String>(primaryMusclesJson);
    map['secondary_muscles_json'] = Variable<String>(secondaryMusclesJson);
    map['equipment_json'] = Variable<String>(equipmentJson);
    map['unilateral_mode'] = Variable<String>(unilateralMode);
    map['target_hold_ms'] = Variable<int>(targetHoldMs);
    map['setup_duration_ms'] = Variable<int>(setupDurationMs);
    map['rest_duration_ms'] = Variable<int>(restDurationMs);
    if (!nullToAbsent || easierVariantId != null) {
      map['easier_variant_id'] = Variable<String>(easierVariantId);
    }
    if (!nullToAbsent || harderVariantId != null) {
      map['harder_variant_id'] = Variable<String>(harderVariantId);
    }
    map['breathing_cue'] = Variable<String>(breathingCue);
    map['common_mistakes_json'] = Variable<String>(commonMistakesJson);
    map['safety_notes'] = Variable<String>(safetyNotes);
    map['limitation_tags_json'] = Variable<String>(limitationTagsJson);
    if (!nullToAbsent || staticAssetId != null) {
      map['static_asset_id'] = Variable<String>(staticAssetId);
    }
    if (!nullToAbsent || animatedAssetId != null) {
      map['animated_asset_id'] = Variable<String>(animatedAssetId);
    }
    map['gated_for_beginners'] = Variable<bool>(gatedForBeginners);
    map['review_status'] = Variable<String>(reviewStatus);
    map['content_version'] = Variable<int>(contentVersion);
    return map;
  }

  ExerciseVariantsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseVariantsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      displayName: Value(displayName),
      difficultyRank: Value(difficultyRank),
      categoryId: Value(categoryId),
      primaryMusclesJson: Value(primaryMusclesJson),
      secondaryMusclesJson: Value(secondaryMusclesJson),
      equipmentJson: Value(equipmentJson),
      unilateralMode: Value(unilateralMode),
      targetHoldMs: Value(targetHoldMs),
      setupDurationMs: Value(setupDurationMs),
      restDurationMs: Value(restDurationMs),
      easierVariantId: easierVariantId == null && nullToAbsent
          ? const Value.absent()
          : Value(easierVariantId),
      harderVariantId: harderVariantId == null && nullToAbsent
          ? const Value.absent()
          : Value(harderVariantId),
      breathingCue: Value(breathingCue),
      commonMistakesJson: Value(commonMistakesJson),
      safetyNotes: Value(safetyNotes),
      limitationTagsJson: Value(limitationTagsJson),
      staticAssetId: staticAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(staticAssetId),
      animatedAssetId: animatedAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(animatedAssetId),
      gatedForBeginners: Value(gatedForBeginners),
      reviewStatus: Value(reviewStatus),
      contentVersion: Value(contentVersion),
    );
  }

  factory ExerciseVariant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseVariant(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      difficultyRank: serializer.fromJson<int>(json['difficultyRank']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      primaryMusclesJson: serializer.fromJson<String>(
        json['primaryMusclesJson'],
      ),
      secondaryMusclesJson: serializer.fromJson<String>(
        json['secondaryMusclesJson'],
      ),
      equipmentJson: serializer.fromJson<String>(json['equipmentJson']),
      unilateralMode: serializer.fromJson<String>(json['unilateralMode']),
      targetHoldMs: serializer.fromJson<int>(json['targetHoldMs']),
      setupDurationMs: serializer.fromJson<int>(json['setupDurationMs']),
      restDurationMs: serializer.fromJson<int>(json['restDurationMs']),
      easierVariantId: serializer.fromJson<String?>(json['easierVariantId']),
      harderVariantId: serializer.fromJson<String?>(json['harderVariantId']),
      breathingCue: serializer.fromJson<String>(json['breathingCue']),
      commonMistakesJson: serializer.fromJson<String>(
        json['commonMistakesJson'],
      ),
      safetyNotes: serializer.fromJson<String>(json['safetyNotes']),
      limitationTagsJson: serializer.fromJson<String>(
        json['limitationTagsJson'],
      ),
      staticAssetId: serializer.fromJson<String?>(json['staticAssetId']),
      animatedAssetId: serializer.fromJson<String?>(json['animatedAssetId']),
      gatedForBeginners: serializer.fromJson<bool>(json['gatedForBeginners']),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      contentVersion: serializer.fromJson<int>(json['contentVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'displayName': serializer.toJson<String>(displayName),
      'difficultyRank': serializer.toJson<int>(difficultyRank),
      'categoryId': serializer.toJson<String>(categoryId),
      'primaryMusclesJson': serializer.toJson<String>(primaryMusclesJson),
      'secondaryMusclesJson': serializer.toJson<String>(secondaryMusclesJson),
      'equipmentJson': serializer.toJson<String>(equipmentJson),
      'unilateralMode': serializer.toJson<String>(unilateralMode),
      'targetHoldMs': serializer.toJson<int>(targetHoldMs),
      'setupDurationMs': serializer.toJson<int>(setupDurationMs),
      'restDurationMs': serializer.toJson<int>(restDurationMs),
      'easierVariantId': serializer.toJson<String?>(easierVariantId),
      'harderVariantId': serializer.toJson<String?>(harderVariantId),
      'breathingCue': serializer.toJson<String>(breathingCue),
      'commonMistakesJson': serializer.toJson<String>(commonMistakesJson),
      'safetyNotes': serializer.toJson<String>(safetyNotes),
      'limitationTagsJson': serializer.toJson<String>(limitationTagsJson),
      'staticAssetId': serializer.toJson<String?>(staticAssetId),
      'animatedAssetId': serializer.toJson<String?>(animatedAssetId),
      'gatedForBeginners': serializer.toJson<bool>(gatedForBeginners),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'contentVersion': serializer.toJson<int>(contentVersion),
    };
  }

  ExerciseVariant copyWith({
    String? id,
    String? exerciseId,
    String? displayName,
    int? difficultyRank,
    String? categoryId,
    String? primaryMusclesJson,
    String? secondaryMusclesJson,
    String? equipmentJson,
    String? unilateralMode,
    int? targetHoldMs,
    int? setupDurationMs,
    int? restDurationMs,
    Value<String?> easierVariantId = const Value.absent(),
    Value<String?> harderVariantId = const Value.absent(),
    String? breathingCue,
    String? commonMistakesJson,
    String? safetyNotes,
    String? limitationTagsJson,
    Value<String?> staticAssetId = const Value.absent(),
    Value<String?> animatedAssetId = const Value.absent(),
    bool? gatedForBeginners,
    String? reviewStatus,
    int? contentVersion,
  }) => ExerciseVariant(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    displayName: displayName ?? this.displayName,
    difficultyRank: difficultyRank ?? this.difficultyRank,
    categoryId: categoryId ?? this.categoryId,
    primaryMusclesJson: primaryMusclesJson ?? this.primaryMusclesJson,
    secondaryMusclesJson: secondaryMusclesJson ?? this.secondaryMusclesJson,
    equipmentJson: equipmentJson ?? this.equipmentJson,
    unilateralMode: unilateralMode ?? this.unilateralMode,
    targetHoldMs: targetHoldMs ?? this.targetHoldMs,
    setupDurationMs: setupDurationMs ?? this.setupDurationMs,
    restDurationMs: restDurationMs ?? this.restDurationMs,
    easierVariantId: easierVariantId.present
        ? easierVariantId.value
        : this.easierVariantId,
    harderVariantId: harderVariantId.present
        ? harderVariantId.value
        : this.harderVariantId,
    breathingCue: breathingCue ?? this.breathingCue,
    commonMistakesJson: commonMistakesJson ?? this.commonMistakesJson,
    safetyNotes: safetyNotes ?? this.safetyNotes,
    limitationTagsJson: limitationTagsJson ?? this.limitationTagsJson,
    staticAssetId: staticAssetId.present
        ? staticAssetId.value
        : this.staticAssetId,
    animatedAssetId: animatedAssetId.present
        ? animatedAssetId.value
        : this.animatedAssetId,
    gatedForBeginners: gatedForBeginners ?? this.gatedForBeginners,
    reviewStatus: reviewStatus ?? this.reviewStatus,
    contentVersion: contentVersion ?? this.contentVersion,
  );
  ExerciseVariant copyWithCompanion(ExerciseVariantsCompanion data) {
    return ExerciseVariant(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      difficultyRank: data.difficultyRank.present
          ? data.difficultyRank.value
          : this.difficultyRank,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      primaryMusclesJson: data.primaryMusclesJson.present
          ? data.primaryMusclesJson.value
          : this.primaryMusclesJson,
      secondaryMusclesJson: data.secondaryMusclesJson.present
          ? data.secondaryMusclesJson.value
          : this.secondaryMusclesJson,
      equipmentJson: data.equipmentJson.present
          ? data.equipmentJson.value
          : this.equipmentJson,
      unilateralMode: data.unilateralMode.present
          ? data.unilateralMode.value
          : this.unilateralMode,
      targetHoldMs: data.targetHoldMs.present
          ? data.targetHoldMs.value
          : this.targetHoldMs,
      setupDurationMs: data.setupDurationMs.present
          ? data.setupDurationMs.value
          : this.setupDurationMs,
      restDurationMs: data.restDurationMs.present
          ? data.restDurationMs.value
          : this.restDurationMs,
      easierVariantId: data.easierVariantId.present
          ? data.easierVariantId.value
          : this.easierVariantId,
      harderVariantId: data.harderVariantId.present
          ? data.harderVariantId.value
          : this.harderVariantId,
      breathingCue: data.breathingCue.present
          ? data.breathingCue.value
          : this.breathingCue,
      commonMistakesJson: data.commonMistakesJson.present
          ? data.commonMistakesJson.value
          : this.commonMistakesJson,
      safetyNotes: data.safetyNotes.present
          ? data.safetyNotes.value
          : this.safetyNotes,
      limitationTagsJson: data.limitationTagsJson.present
          ? data.limitationTagsJson.value
          : this.limitationTagsJson,
      staticAssetId: data.staticAssetId.present
          ? data.staticAssetId.value
          : this.staticAssetId,
      animatedAssetId: data.animatedAssetId.present
          ? data.animatedAssetId.value
          : this.animatedAssetId,
      gatedForBeginners: data.gatedForBeginners.present
          ? data.gatedForBeginners.value
          : this.gatedForBeginners,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseVariant(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('displayName: $displayName, ')
          ..write('difficultyRank: $difficultyRank, ')
          ..write('categoryId: $categoryId, ')
          ..write('primaryMusclesJson: $primaryMusclesJson, ')
          ..write('secondaryMusclesJson: $secondaryMusclesJson, ')
          ..write('equipmentJson: $equipmentJson, ')
          ..write('unilateralMode: $unilateralMode, ')
          ..write('targetHoldMs: $targetHoldMs, ')
          ..write('setupDurationMs: $setupDurationMs, ')
          ..write('restDurationMs: $restDurationMs, ')
          ..write('easierVariantId: $easierVariantId, ')
          ..write('harderVariantId: $harderVariantId, ')
          ..write('breathingCue: $breathingCue, ')
          ..write('commonMistakesJson: $commonMistakesJson, ')
          ..write('safetyNotes: $safetyNotes, ')
          ..write('limitationTagsJson: $limitationTagsJson, ')
          ..write('staticAssetId: $staticAssetId, ')
          ..write('animatedAssetId: $animatedAssetId, ')
          ..write('gatedForBeginners: $gatedForBeginners, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('contentVersion: $contentVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    exerciseId,
    displayName,
    difficultyRank,
    categoryId,
    primaryMusclesJson,
    secondaryMusclesJson,
    equipmentJson,
    unilateralMode,
    targetHoldMs,
    setupDurationMs,
    restDurationMs,
    easierVariantId,
    harderVariantId,
    breathingCue,
    commonMistakesJson,
    safetyNotes,
    limitationTagsJson,
    staticAssetId,
    animatedAssetId,
    gatedForBeginners,
    reviewStatus,
    contentVersion,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseVariant &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.displayName == this.displayName &&
          other.difficultyRank == this.difficultyRank &&
          other.categoryId == this.categoryId &&
          other.primaryMusclesJson == this.primaryMusclesJson &&
          other.secondaryMusclesJson == this.secondaryMusclesJson &&
          other.equipmentJson == this.equipmentJson &&
          other.unilateralMode == this.unilateralMode &&
          other.targetHoldMs == this.targetHoldMs &&
          other.setupDurationMs == this.setupDurationMs &&
          other.restDurationMs == this.restDurationMs &&
          other.easierVariantId == this.easierVariantId &&
          other.harderVariantId == this.harderVariantId &&
          other.breathingCue == this.breathingCue &&
          other.commonMistakesJson == this.commonMistakesJson &&
          other.safetyNotes == this.safetyNotes &&
          other.limitationTagsJson == this.limitationTagsJson &&
          other.staticAssetId == this.staticAssetId &&
          other.animatedAssetId == this.animatedAssetId &&
          other.gatedForBeginners == this.gatedForBeginners &&
          other.reviewStatus == this.reviewStatus &&
          other.contentVersion == this.contentVersion);
}

class ExerciseVariantsCompanion extends UpdateCompanion<ExerciseVariant> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<String> displayName;
  final Value<int> difficultyRank;
  final Value<String> categoryId;
  final Value<String> primaryMusclesJson;
  final Value<String> secondaryMusclesJson;
  final Value<String> equipmentJson;
  final Value<String> unilateralMode;
  final Value<int> targetHoldMs;
  final Value<int> setupDurationMs;
  final Value<int> restDurationMs;
  final Value<String?> easierVariantId;
  final Value<String?> harderVariantId;
  final Value<String> breathingCue;
  final Value<String> commonMistakesJson;
  final Value<String> safetyNotes;
  final Value<String> limitationTagsJson;
  final Value<String?> staticAssetId;
  final Value<String?> animatedAssetId;
  final Value<bool> gatedForBeginners;
  final Value<String> reviewStatus;
  final Value<int> contentVersion;
  final Value<int> rowid;
  const ExerciseVariantsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.difficultyRank = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.primaryMusclesJson = const Value.absent(),
    this.secondaryMusclesJson = const Value.absent(),
    this.equipmentJson = const Value.absent(),
    this.unilateralMode = const Value.absent(),
    this.targetHoldMs = const Value.absent(),
    this.setupDurationMs = const Value.absent(),
    this.restDurationMs = const Value.absent(),
    this.easierVariantId = const Value.absent(),
    this.harderVariantId = const Value.absent(),
    this.breathingCue = const Value.absent(),
    this.commonMistakesJson = const Value.absent(),
    this.safetyNotes = const Value.absent(),
    this.limitationTagsJson = const Value.absent(),
    this.staticAssetId = const Value.absent(),
    this.animatedAssetId = const Value.absent(),
    this.gatedForBeginners = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseVariantsCompanion.insert({
    required String id,
    required String exerciseId,
    required String displayName,
    required int difficultyRank,
    required String categoryId,
    required String primaryMusclesJson,
    this.secondaryMusclesJson = const Value.absent(),
    this.equipmentJson = const Value.absent(),
    this.unilateralMode = const Value.absent(),
    required int targetHoldMs,
    this.setupDurationMs = const Value.absent(),
    this.restDurationMs = const Value.absent(),
    this.easierVariantId = const Value.absent(),
    this.harderVariantId = const Value.absent(),
    this.breathingCue = const Value.absent(),
    this.commonMistakesJson = const Value.absent(),
    this.safetyNotes = const Value.absent(),
    this.limitationTagsJson = const Value.absent(),
    this.staticAssetId = const Value.absent(),
    this.animatedAssetId = const Value.absent(),
    this.gatedForBeginners = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       displayName = Value(displayName),
       difficultyRank = Value(difficultyRank),
       categoryId = Value(categoryId),
       primaryMusclesJson = Value(primaryMusclesJson),
       targetHoldMs = Value(targetHoldMs);
  static Insertable<ExerciseVariant> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<String>? displayName,
    Expression<int>? difficultyRank,
    Expression<String>? categoryId,
    Expression<String>? primaryMusclesJson,
    Expression<String>? secondaryMusclesJson,
    Expression<String>? equipmentJson,
    Expression<String>? unilateralMode,
    Expression<int>? targetHoldMs,
    Expression<int>? setupDurationMs,
    Expression<int>? restDurationMs,
    Expression<String>? easierVariantId,
    Expression<String>? harderVariantId,
    Expression<String>? breathingCue,
    Expression<String>? commonMistakesJson,
    Expression<String>? safetyNotes,
    Expression<String>? limitationTagsJson,
    Expression<String>? staticAssetId,
    Expression<String>? animatedAssetId,
    Expression<bool>? gatedForBeginners,
    Expression<String>? reviewStatus,
    Expression<int>? contentVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (displayName != null) 'display_name': displayName,
      if (difficultyRank != null) 'difficulty_rank': difficultyRank,
      if (categoryId != null) 'category_id': categoryId,
      if (primaryMusclesJson != null)
        'primary_muscles_json': primaryMusclesJson,
      if (secondaryMusclesJson != null)
        'secondary_muscles_json': secondaryMusclesJson,
      if (equipmentJson != null) 'equipment_json': equipmentJson,
      if (unilateralMode != null) 'unilateral_mode': unilateralMode,
      if (targetHoldMs != null) 'target_hold_ms': targetHoldMs,
      if (setupDurationMs != null) 'setup_duration_ms': setupDurationMs,
      if (restDurationMs != null) 'rest_duration_ms': restDurationMs,
      if (easierVariantId != null) 'easier_variant_id': easierVariantId,
      if (harderVariantId != null) 'harder_variant_id': harderVariantId,
      if (breathingCue != null) 'breathing_cue': breathingCue,
      if (commonMistakesJson != null)
        'common_mistakes_json': commonMistakesJson,
      if (safetyNotes != null) 'safety_notes': safetyNotes,
      if (limitationTagsJson != null)
        'limitation_tags_json': limitationTagsJson,
      if (staticAssetId != null) 'static_asset_id': staticAssetId,
      if (animatedAssetId != null) 'animated_asset_id': animatedAssetId,
      if (gatedForBeginners != null) 'gated_for_beginners': gatedForBeginners,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (contentVersion != null) 'content_version': contentVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseVariantsCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<String>? displayName,
    Value<int>? difficultyRank,
    Value<String>? categoryId,
    Value<String>? primaryMusclesJson,
    Value<String>? secondaryMusclesJson,
    Value<String>? equipmentJson,
    Value<String>? unilateralMode,
    Value<int>? targetHoldMs,
    Value<int>? setupDurationMs,
    Value<int>? restDurationMs,
    Value<String?>? easierVariantId,
    Value<String?>? harderVariantId,
    Value<String>? breathingCue,
    Value<String>? commonMistakesJson,
    Value<String>? safetyNotes,
    Value<String>? limitationTagsJson,
    Value<String?>? staticAssetId,
    Value<String?>? animatedAssetId,
    Value<bool>? gatedForBeginners,
    Value<String>? reviewStatus,
    Value<int>? contentVersion,
    Value<int>? rowid,
  }) {
    return ExerciseVariantsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      displayName: displayName ?? this.displayName,
      difficultyRank: difficultyRank ?? this.difficultyRank,
      categoryId: categoryId ?? this.categoryId,
      primaryMusclesJson: primaryMusclesJson ?? this.primaryMusclesJson,
      secondaryMusclesJson: secondaryMusclesJson ?? this.secondaryMusclesJson,
      equipmentJson: equipmentJson ?? this.equipmentJson,
      unilateralMode: unilateralMode ?? this.unilateralMode,
      targetHoldMs: targetHoldMs ?? this.targetHoldMs,
      setupDurationMs: setupDurationMs ?? this.setupDurationMs,
      restDurationMs: restDurationMs ?? this.restDurationMs,
      easierVariantId: easierVariantId ?? this.easierVariantId,
      harderVariantId: harderVariantId ?? this.harderVariantId,
      breathingCue: breathingCue ?? this.breathingCue,
      commonMistakesJson: commonMistakesJson ?? this.commonMistakesJson,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      limitationTagsJson: limitationTagsJson ?? this.limitationTagsJson,
      staticAssetId: staticAssetId ?? this.staticAssetId,
      animatedAssetId: animatedAssetId ?? this.animatedAssetId,
      gatedForBeginners: gatedForBeginners ?? this.gatedForBeginners,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      contentVersion: contentVersion ?? this.contentVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (difficultyRank.present) {
      map['difficulty_rank'] = Variable<int>(difficultyRank.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (primaryMusclesJson.present) {
      map['primary_muscles_json'] = Variable<String>(primaryMusclesJson.value);
    }
    if (secondaryMusclesJson.present) {
      map['secondary_muscles_json'] = Variable<String>(
        secondaryMusclesJson.value,
      );
    }
    if (equipmentJson.present) {
      map['equipment_json'] = Variable<String>(equipmentJson.value);
    }
    if (unilateralMode.present) {
      map['unilateral_mode'] = Variable<String>(unilateralMode.value);
    }
    if (targetHoldMs.present) {
      map['target_hold_ms'] = Variable<int>(targetHoldMs.value);
    }
    if (setupDurationMs.present) {
      map['setup_duration_ms'] = Variable<int>(setupDurationMs.value);
    }
    if (restDurationMs.present) {
      map['rest_duration_ms'] = Variable<int>(restDurationMs.value);
    }
    if (easierVariantId.present) {
      map['easier_variant_id'] = Variable<String>(easierVariantId.value);
    }
    if (harderVariantId.present) {
      map['harder_variant_id'] = Variable<String>(harderVariantId.value);
    }
    if (breathingCue.present) {
      map['breathing_cue'] = Variable<String>(breathingCue.value);
    }
    if (commonMistakesJson.present) {
      map['common_mistakes_json'] = Variable<String>(commonMistakesJson.value);
    }
    if (safetyNotes.present) {
      map['safety_notes'] = Variable<String>(safetyNotes.value);
    }
    if (limitationTagsJson.present) {
      map['limitation_tags_json'] = Variable<String>(limitationTagsJson.value);
    }
    if (staticAssetId.present) {
      map['static_asset_id'] = Variable<String>(staticAssetId.value);
    }
    if (animatedAssetId.present) {
      map['animated_asset_id'] = Variable<String>(animatedAssetId.value);
    }
    if (gatedForBeginners.present) {
      map['gated_for_beginners'] = Variable<bool>(gatedForBeginners.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseVariantsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('displayName: $displayName, ')
          ..write('difficultyRank: $difficultyRank, ')
          ..write('categoryId: $categoryId, ')
          ..write('primaryMusclesJson: $primaryMusclesJson, ')
          ..write('secondaryMusclesJson: $secondaryMusclesJson, ')
          ..write('equipmentJson: $equipmentJson, ')
          ..write('unilateralMode: $unilateralMode, ')
          ..write('targetHoldMs: $targetHoldMs, ')
          ..write('setupDurationMs: $setupDurationMs, ')
          ..write('restDurationMs: $restDurationMs, ')
          ..write('easierVariantId: $easierVariantId, ')
          ..write('harderVariantId: $harderVariantId, ')
          ..write('breathingCue: $breathingCue, ')
          ..write('commonMistakesJson: $commonMistakesJson, ')
          ..write('safetyNotes: $safetyNotes, ')
          ..write('limitationTagsJson: $limitationTagsJson, ')
          ..write('staticAssetId: $staticAssetId, ')
          ..write('animatedAssetId: $animatedAssetId, ')
          ..write('gatedForBeginners: $gatedForBeginners, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseMediaTable extends ExerciseMedia
    with TableInfo<$ExerciseMediaTable, ExerciseMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseMediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  @override
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accessibilityLabelMeta =
      const VerificationMeta('accessibilityLabel');
  @override
  late final GeneratedColumn<String> accessibilityLabel =
      GeneratedColumn<String>(
        'accessibility_label',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    variantId,
    kind,
    assetPath,
    accessibilityLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_media';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseMediaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    } else if (isInserting) {
      context.missing(_assetPathMeta);
    }
    if (data.containsKey('accessibility_label')) {
      context.handle(
        _accessibilityLabelMeta,
        accessibilityLabel.isAcceptableOrUnknown(
          data['accessibility_label']!,
          _accessibilityLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accessibilityLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseMediaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      )!,
      accessibilityLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accessibility_label'],
      )!,
    );
  }

  @override
  $ExerciseMediaTable createAlias(String alias) {
    return $ExerciseMediaTable(attachedDatabase, alias);
  }
}

class ExerciseMediaData extends DataClass
    implements Insertable<ExerciseMediaData> {
  final String id;
  final String? variantId;
  final String kind;
  final String assetPath;
  final String accessibilityLabel;
  const ExerciseMediaData({
    required this.id,
    this.variantId,
    required this.kind,
    required this.assetPath,
    required this.accessibilityLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<String>(variantId);
    }
    map['kind'] = Variable<String>(kind);
    map['asset_path'] = Variable<String>(assetPath);
    map['accessibility_label'] = Variable<String>(accessibilityLabel);
    return map;
  }

  ExerciseMediaCompanion toCompanion(bool nullToAbsent) {
    return ExerciseMediaCompanion(
      id: Value(id),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      kind: Value(kind),
      assetPath: Value(assetPath),
      accessibilityLabel: Value(accessibilityLabel),
    );
  }

  factory ExerciseMediaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseMediaData(
      id: serializer.fromJson<String>(json['id']),
      variantId: serializer.fromJson<String?>(json['variantId']),
      kind: serializer.fromJson<String>(json['kind']),
      assetPath: serializer.fromJson<String>(json['assetPath']),
      accessibilityLabel: serializer.fromJson<String>(
        json['accessibilityLabel'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'variantId': serializer.toJson<String?>(variantId),
      'kind': serializer.toJson<String>(kind),
      'assetPath': serializer.toJson<String>(assetPath),
      'accessibilityLabel': serializer.toJson<String>(accessibilityLabel),
    };
  }

  ExerciseMediaData copyWith({
    String? id,
    Value<String?> variantId = const Value.absent(),
    String? kind,
    String? assetPath,
    String? accessibilityLabel,
  }) => ExerciseMediaData(
    id: id ?? this.id,
    variantId: variantId.present ? variantId.value : this.variantId,
    kind: kind ?? this.kind,
    assetPath: assetPath ?? this.assetPath,
    accessibilityLabel: accessibilityLabel ?? this.accessibilityLabel,
  );
  ExerciseMediaData copyWithCompanion(ExerciseMediaCompanion data) {
    return ExerciseMediaData(
      id: data.id.present ? data.id.value : this.id,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      kind: data.kind.present ? data.kind.value : this.kind,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
      accessibilityLabel: data.accessibilityLabel.present
          ? data.accessibilityLabel.value
          : this.accessibilityLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMediaData(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('kind: $kind, ')
          ..write('assetPath: $assetPath, ')
          ..write('accessibilityLabel: $accessibilityLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, variantId, kind, assetPath, accessibilityLabel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseMediaData &&
          other.id == this.id &&
          other.variantId == this.variantId &&
          other.kind == this.kind &&
          other.assetPath == this.assetPath &&
          other.accessibilityLabel == this.accessibilityLabel);
}

class ExerciseMediaCompanion extends UpdateCompanion<ExerciseMediaData> {
  final Value<String> id;
  final Value<String?> variantId;
  final Value<String> kind;
  final Value<String> assetPath;
  final Value<String> accessibilityLabel;
  final Value<int> rowid;
  const ExerciseMediaCompanion({
    this.id = const Value.absent(),
    this.variantId = const Value.absent(),
    this.kind = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.accessibilityLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseMediaCompanion.insert({
    required String id,
    this.variantId = const Value.absent(),
    required String kind,
    required String assetPath,
    required String accessibilityLabel,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       assetPath = Value(assetPath),
       accessibilityLabel = Value(accessibilityLabel);
  static Insertable<ExerciseMediaData> custom({
    Expression<String>? id,
    Expression<String>? variantId,
    Expression<String>? kind,
    Expression<String>? assetPath,
    Expression<String>? accessibilityLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (variantId != null) 'variant_id': variantId,
      if (kind != null) 'kind': kind,
      if (assetPath != null) 'asset_path': assetPath,
      if (accessibilityLabel != null) 'accessibility_label': accessibilityLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseMediaCompanion copyWith({
    Value<String>? id,
    Value<String?>? variantId,
    Value<String>? kind,
    Value<String>? assetPath,
    Value<String>? accessibilityLabel,
    Value<int>? rowid,
  }) {
    return ExerciseMediaCompanion(
      id: id ?? this.id,
      variantId: variantId ?? this.variantId,
      kind: kind ?? this.kind,
      assetPath: assetPath ?? this.assetPath,
      accessibilityLabel: accessibilityLabel ?? this.accessibilityLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    if (accessibilityLabel.present) {
      map['accessibility_label'] = Variable<String>(accessibilityLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMediaCompanion(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('kind: $kind, ')
          ..write('assetPath: $assetPath, ')
          ..write('accessibilityLabel: $accessibilityLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormCuesTable extends FormCues with TableInfo<$FormCuesTable, FormCue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormCuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cueMeta = const VerificationMeta('cue');
  @override
  late final GeneratedColumn<String> cue = GeneratedColumn<String>(
    'cue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, variantId, sortOrder, cue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'form_cues';
  @override
  VerificationContext validateIntegrity(
    Insertable<FormCue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('cue')) {
      context.handle(
        _cueMeta,
        cue.isAcceptableOrUnknown(data['cue']!, _cueMeta),
      );
    } else if (isInserting) {
      context.missing(_cueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormCue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormCue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      cue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cue'],
      )!,
    );
  }

  @override
  $FormCuesTable createAlias(String alias) {
    return $FormCuesTable(attachedDatabase, alias);
  }
}

class FormCue extends DataClass implements Insertable<FormCue> {
  final int id;
  final String variantId;
  final int sortOrder;
  final String cue;
  const FormCue({
    required this.id,
    required this.variantId,
    required this.sortOrder,
    required this.cue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['variant_id'] = Variable<String>(variantId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['cue'] = Variable<String>(cue);
    return map;
  }

  FormCuesCompanion toCompanion(bool nullToAbsent) {
    return FormCuesCompanion(
      id: Value(id),
      variantId: Value(variantId),
      sortOrder: Value(sortOrder),
      cue: Value(cue),
    );
  }

  factory FormCue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormCue(
      id: serializer.fromJson<int>(json['id']),
      variantId: serializer.fromJson<String>(json['variantId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      cue: serializer.fromJson<String>(json['cue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'variantId': serializer.toJson<String>(variantId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'cue': serializer.toJson<String>(cue),
    };
  }

  FormCue copyWith({int? id, String? variantId, int? sortOrder, String? cue}) =>
      FormCue(
        id: id ?? this.id,
        variantId: variantId ?? this.variantId,
        sortOrder: sortOrder ?? this.sortOrder,
        cue: cue ?? this.cue,
      );
  FormCue copyWithCompanion(FormCuesCompanion data) {
    return FormCue(
      id: data.id.present ? data.id.value : this.id,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      cue: data.cue.present ? data.cue.value : this.cue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormCue(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('cue: $cue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, variantId, sortOrder, cue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormCue &&
          other.id == this.id &&
          other.variantId == this.variantId &&
          other.sortOrder == this.sortOrder &&
          other.cue == this.cue);
}

class FormCuesCompanion extends UpdateCompanion<FormCue> {
  final Value<int> id;
  final Value<String> variantId;
  final Value<int> sortOrder;
  final Value<String> cue;
  const FormCuesCompanion({
    this.id = const Value.absent(),
    this.variantId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.cue = const Value.absent(),
  });
  FormCuesCompanion.insert({
    this.id = const Value.absent(),
    required String variantId,
    this.sortOrder = const Value.absent(),
    required String cue,
  }) : variantId = Value(variantId),
       cue = Value(cue);
  static Insertable<FormCue> custom({
    Expression<int>? id,
    Expression<String>? variantId,
    Expression<int>? sortOrder,
    Expression<String>? cue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (variantId != null) 'variant_id': variantId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (cue != null) 'cue': cue,
    });
  }

  FormCuesCompanion copyWith({
    Value<int>? id,
    Value<String>? variantId,
    Value<int>? sortOrder,
    Value<String>? cue,
  }) {
    return FormCuesCompanion(
      id: id ?? this.id,
      variantId: variantId ?? this.variantId,
      sortOrder: sortOrder ?? this.sortOrder,
      cue: cue ?? this.cue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (cue.present) {
      map['cue'] = Variable<String>(cue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormCuesCompanion(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('cue: $cue')
          ..write(')'))
        .toString();
  }
}

class $ProgramsTable extends Programs with TableInfo<$ProgramsTable, Program> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<int> weeks = GeneratedColumn<int>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _sessionsPerWeekMeta = const VerificationMeta(
    'sessionsPerWeek',
  );
  @override
  late final GeneratedColumn<int> sessionsPerWeek = GeneratedColumn<int>(
    'sessions_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    weeks,
    sessionsPerWeek,
    estimatedMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Program> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    }
    if (data.containsKey('sessions_per_week')) {
      context.handle(
        _sessionsPerWeekMeta,
        sessionsPerWeek.isAcceptableOrUnknown(
          data['sessions_per_week']!,
          _sessionsPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Program map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Program(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks'],
      )!,
      sessionsPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sessions_per_week'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
    );
  }

  @override
  $ProgramsTable createAlias(String alias) {
    return $ProgramsTable(attachedDatabase, alias);
  }
}

class Program extends DataClass implements Insertable<Program> {
  final String id;
  final String name;
  final String description;
  final int weeks;
  final int sessionsPerWeek;
  final int estimatedMinutes;
  const Program({
    required this.id,
    required this.name,
    required this.description,
    required this.weeks,
    required this.sessionsPerWeek,
    required this.estimatedMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['weeks'] = Variable<int>(weeks);
    map['sessions_per_week'] = Variable<int>(sessionsPerWeek);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    return map;
  }

  ProgramsCompanion toCompanion(bool nullToAbsent) {
    return ProgramsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      weeks: Value(weeks),
      sessionsPerWeek: Value(sessionsPerWeek),
      estimatedMinutes: Value(estimatedMinutes),
    );
  }

  factory Program.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Program(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      weeks: serializer.fromJson<int>(json['weeks']),
      sessionsPerWeek: serializer.fromJson<int>(json['sessionsPerWeek']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'weeks': serializer.toJson<int>(weeks),
      'sessionsPerWeek': serializer.toJson<int>(sessionsPerWeek),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
    };
  }

  Program copyWith({
    String? id,
    String? name,
    String? description,
    int? weeks,
    int? sessionsPerWeek,
    int? estimatedMinutes,
  }) => Program(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    weeks: weeks ?? this.weeks,
    sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
  );
  Program copyWithCompanion(ProgramsCompanion data) {
    return Program(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
      sessionsPerWeek: data.sessionsPerWeek.present
          ? data.sessionsPerWeek.value
          : this.sessionsPerWeek,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Program(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('weeks: $weeks, ')
          ..write('sessionsPerWeek: $sessionsPerWeek, ')
          ..write('estimatedMinutes: $estimatedMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    weeks,
    sessionsPerWeek,
    estimatedMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Program &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.weeks == this.weeks &&
          other.sessionsPerWeek == this.sessionsPerWeek &&
          other.estimatedMinutes == this.estimatedMinutes);
}

class ProgramsCompanion extends UpdateCompanion<Program> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> weeks;
  final Value<int> sessionsPerWeek;
  final Value<int> estimatedMinutes;
  final Value<int> rowid;
  const ProgramsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.weeks = const Value.absent(),
    this.sessionsPerWeek = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgramsCompanion.insert({
    required String id,
    required String name,
    required String description,
    this.weeks = const Value.absent(),
    this.sessionsPerWeek = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description);
  static Insertable<Program> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? weeks,
    Expression<int>? sessionsPerWeek,
    Expression<int>? estimatedMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (weeks != null) 'weeks': weeks,
      if (sessionsPerWeek != null) 'sessions_per_week': sessionsPerWeek,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgramsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? weeks,
    Value<int>? sessionsPerWeek,
    Value<int>? estimatedMinutes,
    Value<int>? rowid,
  }) {
    return ProgramsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      weeks: weeks ?? this.weeks,
      sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (weeks.present) {
      map['weeks'] = Variable<int>(weeks.value);
    }
    if (sessionsPerWeek.present) {
      map['sessions_per_week'] = Variable<int>(sessionsPerWeek.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('weeks: $weeks, ')
          ..write('sessionsPerWeek: $sessionsPerWeek, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgramWeeksTable extends ProgramWeeks
    with TableInfo<$ProgramWeeksTable, ProgramWeek> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramWeeksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<String> programId = GeneratedColumn<String>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekNumberMeta = const VerificationMeta(
    'weekNumber',
  );
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
    'week_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusMeta = const VerificationMeta('focus');
  @override
  late final GeneratedColumn<String> focus = GeneratedColumn<String>(
    'focus',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, programId, weekNumber, focus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'program_weeks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgramWeek> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
        _weekNumberMeta,
        weekNumber.isAcceptableOrUnknown(data['week_number']!, _weekNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_weekNumberMeta);
    }
    if (data.containsKey('focus')) {
      context.handle(
        _focusMeta,
        focus.isAcceptableOrUnknown(data['focus']!, _focusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgramWeek map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgramWeek(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_id'],
      )!,
      weekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_number'],
      )!,
      focus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}focus'],
      )!,
    );
  }

  @override
  $ProgramWeeksTable createAlias(String alias) {
    return $ProgramWeeksTable(attachedDatabase, alias);
  }
}

class ProgramWeek extends DataClass implements Insertable<ProgramWeek> {
  final String id;
  final String programId;
  final int weekNumber;
  final String focus;
  const ProgramWeek({
    required this.id,
    required this.programId,
    required this.weekNumber,
    required this.focus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['program_id'] = Variable<String>(programId);
    map['week_number'] = Variable<int>(weekNumber);
    map['focus'] = Variable<String>(focus);
    return map;
  }

  ProgramWeeksCompanion toCompanion(bool nullToAbsent) {
    return ProgramWeeksCompanion(
      id: Value(id),
      programId: Value(programId),
      weekNumber: Value(weekNumber),
      focus: Value(focus),
    );
  }

  factory ProgramWeek.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgramWeek(
      id: serializer.fromJson<String>(json['id']),
      programId: serializer.fromJson<String>(json['programId']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
      focus: serializer.fromJson<String>(json['focus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'programId': serializer.toJson<String>(programId),
      'weekNumber': serializer.toJson<int>(weekNumber),
      'focus': serializer.toJson<String>(focus),
    };
  }

  ProgramWeek copyWith({
    String? id,
    String? programId,
    int? weekNumber,
    String? focus,
  }) => ProgramWeek(
    id: id ?? this.id,
    programId: programId ?? this.programId,
    weekNumber: weekNumber ?? this.weekNumber,
    focus: focus ?? this.focus,
  );
  ProgramWeek copyWithCompanion(ProgramWeeksCompanion data) {
    return ProgramWeek(
      id: data.id.present ? data.id.value : this.id,
      programId: data.programId.present ? data.programId.value : this.programId,
      weekNumber: data.weekNumber.present
          ? data.weekNumber.value
          : this.weekNumber,
      focus: data.focus.present ? data.focus.value : this.focus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgramWeek(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('focus: $focus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, programId, weekNumber, focus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgramWeek &&
          other.id == this.id &&
          other.programId == this.programId &&
          other.weekNumber == this.weekNumber &&
          other.focus == this.focus);
}

class ProgramWeeksCompanion extends UpdateCompanion<ProgramWeek> {
  final Value<String> id;
  final Value<String> programId;
  final Value<int> weekNumber;
  final Value<String> focus;
  final Value<int> rowid;
  const ProgramWeeksCompanion({
    this.id = const Value.absent(),
    this.programId = const Value.absent(),
    this.weekNumber = const Value.absent(),
    this.focus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgramWeeksCompanion.insert({
    required String id,
    required String programId,
    required int weekNumber,
    this.focus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       programId = Value(programId),
       weekNumber = Value(weekNumber);
  static Insertable<ProgramWeek> custom({
    Expression<String>? id,
    Expression<String>? programId,
    Expression<int>? weekNumber,
    Expression<String>? focus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programId != null) 'program_id': programId,
      if (weekNumber != null) 'week_number': weekNumber,
      if (focus != null) 'focus': focus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgramWeeksCompanion copyWith({
    Value<String>? id,
    Value<String>? programId,
    Value<int>? weekNumber,
    Value<String>? focus,
    Value<int>? rowid,
  }) {
    return ProgramWeeksCompanion(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      weekNumber: weekNumber ?? this.weekNumber,
      focus: focus ?? this.focus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<String>(programId.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    if (focus.present) {
      map['focus'] = Variable<String>(focus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramWeeksCompanion(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('weekNumber: $weekNumber, ')
          ..write('focus: $focus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTemplatesTable extends WorkoutTemplates
    with TableInfo<$WorkoutTemplatesTable, WorkoutTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<String> programId = GeneratedColumn<String>(
    'program_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _programWeekIdMeta = const VerificationMeta(
    'programWeekId',
  );
  @override
  late final GeneratedColumn<String> programWeekId = GeneratedColumn<String>(
    'program_week_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _isQuickStartMeta = const VerificationMeta(
    'isQuickStart',
  );
  @override
  late final GeneratedColumn<bool> isQuickStart = GeneratedColumn<bool>(
    'is_quick_start',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_quick_start" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDefaultRecommendedMeta =
      const VerificationMeta('isDefaultRecommended');
  @override
  late final GeneratedColumn<bool> isDefaultRecommended = GeneratedColumn<bool>(
    'is_default_recommended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default_recommended" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    programId,
    programWeekId,
    name,
    estimatedMinutes,
    isQuickStart,
    isDefaultRecommended,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    }
    if (data.containsKey('program_week_id')) {
      context.handle(
        _programWeekIdMeta,
        programWeekId.isAcceptableOrUnknown(
          data['program_week_id']!,
          _programWeekIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('is_quick_start')) {
      context.handle(
        _isQuickStartMeta,
        isQuickStart.isAcceptableOrUnknown(
          data['is_quick_start']!,
          _isQuickStartMeta,
        ),
      );
    }
    if (data.containsKey('is_default_recommended')) {
      context.handle(
        _isDefaultRecommendedMeta,
        isDefaultRecommended.isAcceptableOrUnknown(
          data['is_default_recommended']!,
          _isDefaultRecommendedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_id'],
      ),
      programWeekId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_week_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      isQuickStart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_quick_start'],
      )!,
      isDefaultRecommended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default_recommended'],
      )!,
    );
  }

  @override
  $WorkoutTemplatesTable createAlias(String alias) {
    return $WorkoutTemplatesTable(attachedDatabase, alias);
  }
}

class WorkoutTemplate extends DataClass implements Insertable<WorkoutTemplate> {
  final String id;
  final String? programId;
  final String? programWeekId;
  final String name;
  final int estimatedMinutes;
  final bool isQuickStart;
  final bool isDefaultRecommended;
  const WorkoutTemplate({
    required this.id,
    this.programId,
    this.programWeekId,
    required this.name,
    required this.estimatedMinutes,
    required this.isQuickStart,
    required this.isDefaultRecommended,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || programId != null) {
      map['program_id'] = Variable<String>(programId);
    }
    if (!nullToAbsent || programWeekId != null) {
      map['program_week_id'] = Variable<String>(programWeekId);
    }
    map['name'] = Variable<String>(name);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['is_quick_start'] = Variable<bool>(isQuickStart);
    map['is_default_recommended'] = Variable<bool>(isDefaultRecommended);
    return map;
  }

  WorkoutTemplatesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplatesCompanion(
      id: Value(id),
      programId: programId == null && nullToAbsent
          ? const Value.absent()
          : Value(programId),
      programWeekId: programWeekId == null && nullToAbsent
          ? const Value.absent()
          : Value(programWeekId),
      name: Value(name),
      estimatedMinutes: Value(estimatedMinutes),
      isQuickStart: Value(isQuickStart),
      isDefaultRecommended: Value(isDefaultRecommended),
    );
  }

  factory WorkoutTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplate(
      id: serializer.fromJson<String>(json['id']),
      programId: serializer.fromJson<String?>(json['programId']),
      programWeekId: serializer.fromJson<String?>(json['programWeekId']),
      name: serializer.fromJson<String>(json['name']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      isQuickStart: serializer.fromJson<bool>(json['isQuickStart']),
      isDefaultRecommended: serializer.fromJson<bool>(
        json['isDefaultRecommended'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'programId': serializer.toJson<String?>(programId),
      'programWeekId': serializer.toJson<String?>(programWeekId),
      'name': serializer.toJson<String>(name),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'isQuickStart': serializer.toJson<bool>(isQuickStart),
      'isDefaultRecommended': serializer.toJson<bool>(isDefaultRecommended),
    };
  }

  WorkoutTemplate copyWith({
    String? id,
    Value<String?> programId = const Value.absent(),
    Value<String?> programWeekId = const Value.absent(),
    String? name,
    int? estimatedMinutes,
    bool? isQuickStart,
    bool? isDefaultRecommended,
  }) => WorkoutTemplate(
    id: id ?? this.id,
    programId: programId.present ? programId.value : this.programId,
    programWeekId: programWeekId.present
        ? programWeekId.value
        : this.programWeekId,
    name: name ?? this.name,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    isQuickStart: isQuickStart ?? this.isQuickStart,
    isDefaultRecommended: isDefaultRecommended ?? this.isDefaultRecommended,
  );
  WorkoutTemplate copyWithCompanion(WorkoutTemplatesCompanion data) {
    return WorkoutTemplate(
      id: data.id.present ? data.id.value : this.id,
      programId: data.programId.present ? data.programId.value : this.programId,
      programWeekId: data.programWeekId.present
          ? data.programWeekId.value
          : this.programWeekId,
      name: data.name.present ? data.name.value : this.name,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      isQuickStart: data.isQuickStart.present
          ? data.isQuickStart.value
          : this.isQuickStart,
      isDefaultRecommended: data.isDefaultRecommended.present
          ? data.isDefaultRecommended.value
          : this.isDefaultRecommended,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplate(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('programWeekId: $programWeekId, ')
          ..write('name: $name, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('isQuickStart: $isQuickStart, ')
          ..write('isDefaultRecommended: $isDefaultRecommended')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    programId,
    programWeekId,
    name,
    estimatedMinutes,
    isQuickStart,
    isDefaultRecommended,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplate &&
          other.id == this.id &&
          other.programId == this.programId &&
          other.programWeekId == this.programWeekId &&
          other.name == this.name &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.isQuickStart == this.isQuickStart &&
          other.isDefaultRecommended == this.isDefaultRecommended);
}

class WorkoutTemplatesCompanion extends UpdateCompanion<WorkoutTemplate> {
  final Value<String> id;
  final Value<String?> programId;
  final Value<String?> programWeekId;
  final Value<String> name;
  final Value<int> estimatedMinutes;
  final Value<bool> isQuickStart;
  final Value<bool> isDefaultRecommended;
  final Value<int> rowid;
  const WorkoutTemplatesCompanion({
    this.id = const Value.absent(),
    this.programId = const Value.absent(),
    this.programWeekId = const Value.absent(),
    this.name = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.isQuickStart = const Value.absent(),
    this.isDefaultRecommended = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutTemplatesCompanion.insert({
    required String id,
    this.programId = const Value.absent(),
    this.programWeekId = const Value.absent(),
    required String name,
    this.estimatedMinutes = const Value.absent(),
    this.isQuickStart = const Value.absent(),
    this.isDefaultRecommended = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<WorkoutTemplate> custom({
    Expression<String>? id,
    Expression<String>? programId,
    Expression<String>? programWeekId,
    Expression<String>? name,
    Expression<int>? estimatedMinutes,
    Expression<bool>? isQuickStart,
    Expression<bool>? isDefaultRecommended,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programId != null) 'program_id': programId,
      if (programWeekId != null) 'program_week_id': programWeekId,
      if (name != null) 'name': name,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (isQuickStart != null) 'is_quick_start': isQuickStart,
      if (isDefaultRecommended != null)
        'is_default_recommended': isDefaultRecommended,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String?>? programId,
    Value<String?>? programWeekId,
    Value<String>? name,
    Value<int>? estimatedMinutes,
    Value<bool>? isQuickStart,
    Value<bool>? isDefaultRecommended,
    Value<int>? rowid,
  }) {
    return WorkoutTemplatesCompanion(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      programWeekId: programWeekId ?? this.programWeekId,
      name: name ?? this.name,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      isQuickStart: isQuickStart ?? this.isQuickStart,
      isDefaultRecommended: isDefaultRecommended ?? this.isDefaultRecommended,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<String>(programId.value);
    }
    if (programWeekId.present) {
      map['program_week_id'] = Variable<String>(programWeekId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (isQuickStart.present) {
      map['is_quick_start'] = Variable<bool>(isQuickStart.value);
    }
    if (isDefaultRecommended.present) {
      map['is_default_recommended'] = Variable<bool>(
        isDefaultRecommended.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('programWeekId: $programWeekId, ')
          ..write('name: $name, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('isQuickStart: $isQuickStart, ')
          ..write('isDefaultRecommended: $isDefaultRecommended, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTemplateItemsTable extends WorkoutTemplateItems
    with TableInfo<$WorkoutTemplateItemsTable, WorkoutTemplateItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTemplateItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hold'),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    sortOrder,
    variantId,
    itemType,
    label,
    durationMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_template_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutTemplateItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplateItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplateItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      ),
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
    );
  }

  @override
  $WorkoutTemplateItemsTable createAlias(String alias) {
    return $WorkoutTemplateItemsTable(attachedDatabase, alias);
  }
}

class WorkoutTemplateItem extends DataClass
    implements Insertable<WorkoutTemplateItem> {
  final int id;
  final String templateId;
  final int sortOrder;
  final String? variantId;
  final String itemType;
  final String label;
  final int durationMs;
  const WorkoutTemplateItem({
    required this.id,
    required this.templateId,
    required this.sortOrder,
    this.variantId,
    required this.itemType,
    required this.label,
    required this.durationMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<String>(templateId);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<String>(variantId);
    }
    map['item_type'] = Variable<String>(itemType);
    map['label'] = Variable<String>(label);
    map['duration_ms'] = Variable<int>(durationMs);
    return map;
  }

  WorkoutTemplateItemsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplateItemsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      sortOrder: Value(sortOrder),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
      itemType: Value(itemType),
      label: Value(label),
      durationMs: Value(durationMs),
    );
  }

  factory WorkoutTemplateItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplateItem(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      variantId: serializer.fromJson<String?>(json['variantId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      label: serializer.fromJson<String>(json['label']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<String>(templateId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'variantId': serializer.toJson<String?>(variantId),
      'itemType': serializer.toJson<String>(itemType),
      'label': serializer.toJson<String>(label),
      'durationMs': serializer.toJson<int>(durationMs),
    };
  }

  WorkoutTemplateItem copyWith({
    int? id,
    String? templateId,
    int? sortOrder,
    Value<String?> variantId = const Value.absent(),
    String? itemType,
    String? label,
    int? durationMs,
  }) => WorkoutTemplateItem(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    sortOrder: sortOrder ?? this.sortOrder,
    variantId: variantId.present ? variantId.value : this.variantId,
    itemType: itemType ?? this.itemType,
    label: label ?? this.label,
    durationMs: durationMs ?? this.durationMs,
  );
  WorkoutTemplateItem copyWithCompanion(WorkoutTemplateItemsCompanion data) {
    return WorkoutTemplateItem(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      label: data.label.present ? data.label.value : this.label,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplateItem(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('variantId: $variantId, ')
          ..write('itemType: $itemType, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    sortOrder,
    variantId,
    itemType,
    label,
    durationMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplateItem &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.sortOrder == this.sortOrder &&
          other.variantId == this.variantId &&
          other.itemType == this.itemType &&
          other.label == this.label &&
          other.durationMs == this.durationMs);
}

class WorkoutTemplateItemsCompanion
    extends UpdateCompanion<WorkoutTemplateItem> {
  final Value<int> id;
  final Value<String> templateId;
  final Value<int> sortOrder;
  final Value<String?> variantId;
  final Value<String> itemType;
  final Value<String> label;
  final Value<int> durationMs;
  const WorkoutTemplateItemsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.variantId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.label = const Value.absent(),
    this.durationMs = const Value.absent(),
  });
  WorkoutTemplateItemsCompanion.insert({
    this.id = const Value.absent(),
    required String templateId,
    required int sortOrder,
    this.variantId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.label = const Value.absent(),
    this.durationMs = const Value.absent(),
  }) : templateId = Value(templateId),
       sortOrder = Value(sortOrder);
  static Insertable<WorkoutTemplateItem> custom({
    Expression<int>? id,
    Expression<String>? templateId,
    Expression<int>? sortOrder,
    Expression<String>? variantId,
    Expression<String>? itemType,
    Expression<String>? label,
    Expression<int>? durationMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (variantId != null) 'variant_id': variantId,
      if (itemType != null) 'item_type': itemType,
      if (label != null) 'label': label,
      if (durationMs != null) 'duration_ms': durationMs,
    });
  }

  WorkoutTemplateItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? templateId,
    Value<int>? sortOrder,
    Value<String?>? variantId,
    Value<String>? itemType,
    Value<String>? label,
    Value<int>? durationMs,
  }) {
    return WorkoutTemplateItemsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      sortOrder: sortOrder ?? this.sortOrder,
      variantId: variantId ?? this.variantId,
      itemType: itemType ?? this.itemType,
      label: label ?? this.label,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplateItemsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('variantId: $variantId, ')
          ..write('itemType: $itemType, ')
          ..write('label: $label, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<String> programId = GeneratedColumn<String>(
    'program_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedDurationMsMeta = const VerificationMeta(
    'plannedDurationMs',
  );
  @override
  late final GeneratedColumn<int> plannedDurationMs = GeneratedColumn<int>(
    'planned_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _actualDurationMsMeta = const VerificationMeta(
    'actualDurationMs',
  );
  @override
  late final GeneratedColumn<int> actualDurationMs = GeneratedColumn<int>(
    'actual_duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedExerciseCountMeta =
      const VerificationMeta('completedExerciseCount');
  @override
  late final GeneratedColumn<int> completedExerciseCount = GeneratedColumn<int>(
    'completed_exercise_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skippedExerciseCountMeta =
      const VerificationMeta('skippedExerciseCount');
  @override
  late final GeneratedColumn<int> skippedExerciseCount = GeneratedColumn<int>(
    'skipped_exercise_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _perceivedEffortMeta = const VerificationMeta(
    'perceivedEffort',
  );
  @override
  late final GeneratedColumn<int> perceivedEffort = GeneratedColumn<int>(
    'perceived_effort',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _painFlagMeta = const VerificationMeta(
    'painFlag',
  );
  @override
  late final GeneratedColumn<bool> painFlag = GeneratedColumn<bool>(
    'pain_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pain_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recoveryJsonMeta = const VerificationMeta(
    'recoveryJson',
  );
  @override
  late final GeneratedColumn<String> recoveryJson = GeneratedColumn<String>(
    'recovery_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    completedAt,
    status,
    templateId,
    programId,
    plannedDurationMs,
    actualDurationMs,
    completedExerciseCount,
    skippedExerciseCount,
    perceivedEffort,
    painFlag,
    note,
    recoveryJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    }
    if (data.containsKey('planned_duration_ms')) {
      context.handle(
        _plannedDurationMsMeta,
        plannedDurationMs.isAcceptableOrUnknown(
          data['planned_duration_ms']!,
          _plannedDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('actual_duration_ms')) {
      context.handle(
        _actualDurationMsMeta,
        actualDurationMs.isAcceptableOrUnknown(
          data['actual_duration_ms']!,
          _actualDurationMsMeta,
        ),
      );
    }
    if (data.containsKey('completed_exercise_count')) {
      context.handle(
        _completedExerciseCountMeta,
        completedExerciseCount.isAcceptableOrUnknown(
          data['completed_exercise_count']!,
          _completedExerciseCountMeta,
        ),
      );
    }
    if (data.containsKey('skipped_exercise_count')) {
      context.handle(
        _skippedExerciseCountMeta,
        skippedExerciseCount.isAcceptableOrUnknown(
          data['skipped_exercise_count']!,
          _skippedExerciseCountMeta,
        ),
      );
    }
    if (data.containsKey('perceived_effort')) {
      context.handle(
        _perceivedEffortMeta,
        perceivedEffort.isAcceptableOrUnknown(
          data['perceived_effort']!,
          _perceivedEffortMeta,
        ),
      );
    }
    if (data.containsKey('pain_flag')) {
      context.handle(
        _painFlagMeta,
        painFlag.isAcceptableOrUnknown(data['pain_flag']!, _painFlagMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('recovery_json')) {
      context.handle(
        _recoveryJsonMeta,
        recoveryJson.isAcceptableOrUnknown(
          data['recovery_json']!,
          _recoveryJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_id'],
      ),
      plannedDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_duration_ms'],
      )!,
      actualDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_ms'],
      )!,
      completedExerciseCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_exercise_count'],
      )!,
      skippedExerciseCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skipped_exercise_count'],
      )!,
      perceivedEffort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_effort'],
      ),
      painFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pain_flag'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      recoveryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_json'],
      ),
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final String id;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;
  final String? templateId;
  final String? programId;
  final int plannedDurationMs;
  final int actualDurationMs;
  final int completedExerciseCount;
  final int skippedExerciseCount;
  final int? perceivedEffort;
  final bool painFlag;
  final String? note;
  final String? recoveryJson;
  const WorkoutSession({
    required this.id,
    required this.startedAt,
    this.completedAt,
    required this.status,
    this.templateId,
    this.programId,
    required this.plannedDurationMs,
    required this.actualDurationMs,
    required this.completedExerciseCount,
    required this.skippedExerciseCount,
    this.perceivedEffort,
    required this.painFlag,
    this.note,
    this.recoveryJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    if (!nullToAbsent || programId != null) {
      map['program_id'] = Variable<String>(programId);
    }
    map['planned_duration_ms'] = Variable<int>(plannedDurationMs);
    map['actual_duration_ms'] = Variable<int>(actualDurationMs);
    map['completed_exercise_count'] = Variable<int>(completedExerciseCount);
    map['skipped_exercise_count'] = Variable<int>(skippedExerciseCount);
    if (!nullToAbsent || perceivedEffort != null) {
      map['perceived_effort'] = Variable<int>(perceivedEffort);
    }
    map['pain_flag'] = Variable<bool>(painFlag);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || recoveryJson != null) {
      map['recovery_json'] = Variable<String>(recoveryJson);
    }
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      programId: programId == null && nullToAbsent
          ? const Value.absent()
          : Value(programId),
      plannedDurationMs: Value(plannedDurationMs),
      actualDurationMs: Value(actualDurationMs),
      completedExerciseCount: Value(completedExerciseCount),
      skippedExerciseCount: Value(skippedExerciseCount),
      perceivedEffort: perceivedEffort == null && nullToAbsent
          ? const Value.absent()
          : Value(perceivedEffort),
      painFlag: Value(painFlag),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      recoveryJson: recoveryJson == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryJson),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      programId: serializer.fromJson<String?>(json['programId']),
      plannedDurationMs: serializer.fromJson<int>(json['plannedDurationMs']),
      actualDurationMs: serializer.fromJson<int>(json['actualDurationMs']),
      completedExerciseCount: serializer.fromJson<int>(
        json['completedExerciseCount'],
      ),
      skippedExerciseCount: serializer.fromJson<int>(
        json['skippedExerciseCount'],
      ),
      perceivedEffort: serializer.fromJson<int?>(json['perceivedEffort']),
      painFlag: serializer.fromJson<bool>(json['painFlag']),
      note: serializer.fromJson<String?>(json['note']),
      recoveryJson: serializer.fromJson<String?>(json['recoveryJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
      'templateId': serializer.toJson<String?>(templateId),
      'programId': serializer.toJson<String?>(programId),
      'plannedDurationMs': serializer.toJson<int>(plannedDurationMs),
      'actualDurationMs': serializer.toJson<int>(actualDurationMs),
      'completedExerciseCount': serializer.toJson<int>(completedExerciseCount),
      'skippedExerciseCount': serializer.toJson<int>(skippedExerciseCount),
      'perceivedEffort': serializer.toJson<int?>(perceivedEffort),
      'painFlag': serializer.toJson<bool>(painFlag),
      'note': serializer.toJson<String?>(note),
      'recoveryJson': serializer.toJson<String?>(recoveryJson),
    };
  }

  WorkoutSession copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
    Value<String?> templateId = const Value.absent(),
    Value<String?> programId = const Value.absent(),
    int? plannedDurationMs,
    int? actualDurationMs,
    int? completedExerciseCount,
    int? skippedExerciseCount,
    Value<int?> perceivedEffort = const Value.absent(),
    bool? painFlag,
    Value<String?> note = const Value.absent(),
    Value<String?> recoveryJson = const Value.absent(),
  }) => WorkoutSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    templateId: templateId.present ? templateId.value : this.templateId,
    programId: programId.present ? programId.value : this.programId,
    plannedDurationMs: plannedDurationMs ?? this.plannedDurationMs,
    actualDurationMs: actualDurationMs ?? this.actualDurationMs,
    completedExerciseCount:
        completedExerciseCount ?? this.completedExerciseCount,
    skippedExerciseCount: skippedExerciseCount ?? this.skippedExerciseCount,
    perceivedEffort: perceivedEffort.present
        ? perceivedEffort.value
        : this.perceivedEffort,
    painFlag: painFlag ?? this.painFlag,
    note: note.present ? note.value : this.note,
    recoveryJson: recoveryJson.present ? recoveryJson.value : this.recoveryJson,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      programId: data.programId.present ? data.programId.value : this.programId,
      plannedDurationMs: data.plannedDurationMs.present
          ? data.plannedDurationMs.value
          : this.plannedDurationMs,
      actualDurationMs: data.actualDurationMs.present
          ? data.actualDurationMs.value
          : this.actualDurationMs,
      completedExerciseCount: data.completedExerciseCount.present
          ? data.completedExerciseCount.value
          : this.completedExerciseCount,
      skippedExerciseCount: data.skippedExerciseCount.present
          ? data.skippedExerciseCount.value
          : this.skippedExerciseCount,
      perceivedEffort: data.perceivedEffort.present
          ? data.perceivedEffort.value
          : this.perceivedEffort,
      painFlag: data.painFlag.present ? data.painFlag.value : this.painFlag,
      note: data.note.present ? data.note.value : this.note,
      recoveryJson: data.recoveryJson.present
          ? data.recoveryJson.value
          : this.recoveryJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('templateId: $templateId, ')
          ..write('programId: $programId, ')
          ..write('plannedDurationMs: $plannedDurationMs, ')
          ..write('actualDurationMs: $actualDurationMs, ')
          ..write('completedExerciseCount: $completedExerciseCount, ')
          ..write('skippedExerciseCount: $skippedExerciseCount, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('note: $note, ')
          ..write('recoveryJson: $recoveryJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    completedAt,
    status,
    templateId,
    programId,
    plannedDurationMs,
    actualDurationMs,
    completedExerciseCount,
    skippedExerciseCount,
    perceivedEffort,
    painFlag,
    note,
    recoveryJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.templateId == this.templateId &&
          other.programId == this.programId &&
          other.plannedDurationMs == this.plannedDurationMs &&
          other.actualDurationMs == this.actualDurationMs &&
          other.completedExerciseCount == this.completedExerciseCount &&
          other.skippedExerciseCount == this.skippedExerciseCount &&
          other.perceivedEffort == this.perceivedEffort &&
          other.painFlag == this.painFlag &&
          other.note == this.note &&
          other.recoveryJson == this.recoveryJson);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<String?> templateId;
  final Value<String?> programId;
  final Value<int> plannedDurationMs;
  final Value<int> actualDurationMs;
  final Value<int> completedExerciseCount;
  final Value<int> skippedExerciseCount;
  final Value<int?> perceivedEffort;
  final Value<bool> painFlag;
  final Value<String?> note;
  final Value<String?> recoveryJson;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.templateId = const Value.absent(),
    this.programId = const Value.absent(),
    this.plannedDurationMs = const Value.absent(),
    this.actualDurationMs = const Value.absent(),
    this.completedExerciseCount = const Value.absent(),
    this.skippedExerciseCount = const Value.absent(),
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.recoveryJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required String status,
    this.templateId = const Value.absent(),
    this.programId = const Value.absent(),
    this.plannedDurationMs = const Value.absent(),
    this.actualDurationMs = const Value.absent(),
    this.completedExerciseCount = const Value.absent(),
    this.skippedExerciseCount = const Value.absent(),
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.recoveryJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<WorkoutSession> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<String>? templateId,
    Expression<String>? programId,
    Expression<int>? plannedDurationMs,
    Expression<int>? actualDurationMs,
    Expression<int>? completedExerciseCount,
    Expression<int>? skippedExerciseCount,
    Expression<int>? perceivedEffort,
    Expression<bool>? painFlag,
    Expression<String>? note,
    Expression<String>? recoveryJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (templateId != null) 'template_id': templateId,
      if (programId != null) 'program_id': programId,
      if (plannedDurationMs != null) 'planned_duration_ms': plannedDurationMs,
      if (actualDurationMs != null) 'actual_duration_ms': actualDurationMs,
      if (completedExerciseCount != null)
        'completed_exercise_count': completedExerciseCount,
      if (skippedExerciseCount != null)
        'skipped_exercise_count': skippedExerciseCount,
      if (perceivedEffort != null) 'perceived_effort': perceivedEffort,
      if (painFlag != null) 'pain_flag': painFlag,
      if (note != null) 'note': note,
      if (recoveryJson != null) 'recovery_json': recoveryJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
    Value<String?>? templateId,
    Value<String?>? programId,
    Value<int>? plannedDurationMs,
    Value<int>? actualDurationMs,
    Value<int>? completedExerciseCount,
    Value<int>? skippedExerciseCount,
    Value<int?>? perceivedEffort,
    Value<bool>? painFlag,
    Value<String?>? note,
    Value<String?>? recoveryJson,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      templateId: templateId ?? this.templateId,
      programId: programId ?? this.programId,
      plannedDurationMs: plannedDurationMs ?? this.plannedDurationMs,
      actualDurationMs: actualDurationMs ?? this.actualDurationMs,
      completedExerciseCount:
          completedExerciseCount ?? this.completedExerciseCount,
      skippedExerciseCount: skippedExerciseCount ?? this.skippedExerciseCount,
      perceivedEffort: perceivedEffort ?? this.perceivedEffort,
      painFlag: painFlag ?? this.painFlag,
      note: note ?? this.note,
      recoveryJson: recoveryJson ?? this.recoveryJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<String>(programId.value);
    }
    if (plannedDurationMs.present) {
      map['planned_duration_ms'] = Variable<int>(plannedDurationMs.value);
    }
    if (actualDurationMs.present) {
      map['actual_duration_ms'] = Variable<int>(actualDurationMs.value);
    }
    if (completedExerciseCount.present) {
      map['completed_exercise_count'] = Variable<int>(
        completedExerciseCount.value,
      );
    }
    if (skippedExerciseCount.present) {
      map['skipped_exercise_count'] = Variable<int>(skippedExerciseCount.value);
    }
    if (perceivedEffort.present) {
      map['perceived_effort'] = Variable<int>(perceivedEffort.value);
    }
    if (painFlag.present) {
      map['pain_flag'] = Variable<bool>(painFlag.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (recoveryJson.present) {
      map['recovery_json'] = Variable<String>(recoveryJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('templateId: $templateId, ')
          ..write('programId: $programId, ')
          ..write('plannedDurationMs: $plannedDurationMs, ')
          ..write('actualDurationMs: $actualDurationMs, ')
          ..write('completedExerciseCount: $completedExerciseCount, ')
          ..write('skippedExerciseCount: $skippedExerciseCount, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('note: $note, ')
          ..write('recoveryJson: $recoveryJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HoldAttemptsTable extends HoldAttempts
    with TableInfo<$HoldAttemptsTable, HoldAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HoldAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _targetMsMeta = const VerificationMeta(
    'targetMs',
  );
  @override
  late final GeneratedColumn<int> targetMs = GeneratedColumn<int>(
    'target_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMsMeta = const VerificationMeta(
    'completedMs',
  );
  @override
  late final GeneratedColumn<int> completedMs = GeneratedColumn<int>(
    'completed_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preparationMsMeta = const VerificationMeta(
    'preparationMs',
  );
  @override
  late final GeneratedColumn<int> preparationMs = GeneratedColumn<int>(
    'preparation_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _restMsMeta = const VerificationMeta('restMs');
  @override
  late final GeneratedColumn<int> restMs = GeneratedColumn<int>(
    'rest_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pauseMsMeta = const VerificationMeta(
    'pauseMs',
  );
  @override
  late final GeneratedColumn<int> pauseMs = GeneratedColumn<int>(
    'pause_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perceivedEffortMeta = const VerificationMeta(
    'perceivedEffort',
  );
  @override
  late final GeneratedColumn<int> perceivedEffort = GeneratedColumn<int>(
    'perceived_effort',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _painFlagMeta = const VerificationMeta(
    'painFlag',
  );
  @override
  late final GeneratedColumn<bool> painFlag = GeneratedColumn<bool>(
    'pain_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pain_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    variantId,
    side,
    setNumber,
    targetMs,
    completedMs,
    preparationMs,
    restMs,
    pauseMs,
    result,
    perceivedEffort,
    painFlag,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hold_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<HoldAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    }
    if (data.containsKey('target_ms')) {
      context.handle(
        _targetMsMeta,
        targetMs.isAcceptableOrUnknown(data['target_ms']!, _targetMsMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMsMeta);
    }
    if (data.containsKey('completed_ms')) {
      context.handle(
        _completedMsMeta,
        completedMs.isAcceptableOrUnknown(
          data['completed_ms']!,
          _completedMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedMsMeta);
    }
    if (data.containsKey('preparation_ms')) {
      context.handle(
        _preparationMsMeta,
        preparationMs.isAcceptableOrUnknown(
          data['preparation_ms']!,
          _preparationMsMeta,
        ),
      );
    }
    if (data.containsKey('rest_ms')) {
      context.handle(
        _restMsMeta,
        restMs.isAcceptableOrUnknown(data['rest_ms']!, _restMsMeta),
      );
    }
    if (data.containsKey('pause_ms')) {
      context.handle(
        _pauseMsMeta,
        pauseMs.isAcceptableOrUnknown(data['pause_ms']!, _pauseMsMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('perceived_effort')) {
      context.handle(
        _perceivedEffortMeta,
        perceivedEffort.isAcceptableOrUnknown(
          data['perceived_effort']!,
          _perceivedEffortMeta,
        ),
      );
    }
    if (data.containsKey('pain_flag')) {
      context.handle(
        _painFlagMeta,
        painFlag.isAcceptableOrUnknown(data['pain_flag']!, _painFlagMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HoldAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HoldAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      targetMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_ms'],
      )!,
      completedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_ms'],
      )!,
      preparationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preparation_ms'],
      )!,
      restMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_ms'],
      )!,
      pauseMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pause_ms'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      perceivedEffort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_effort'],
      ),
      painFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pain_flag'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
    );
  }

  @override
  $HoldAttemptsTable createAlias(String alias) {
    return $HoldAttemptsTable(attachedDatabase, alias);
  }
}

class HoldAttempt extends DataClass implements Insertable<HoldAttempt> {
  final String id;
  final String sessionId;
  final String exerciseId;
  final String variantId;
  final String side;
  final int setNumber;
  final int targetMs;
  final int completedMs;
  final int preparationMs;
  final int restMs;
  final int pauseMs;
  final String result;
  final int? perceivedEffort;
  final bool painFlag;
  final DateTime startedAt;
  final DateTime endedAt;
  const HoldAttempt({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.variantId,
    required this.side,
    required this.setNumber,
    required this.targetMs,
    required this.completedMs,
    required this.preparationMs,
    required this.restMs,
    required this.pauseMs,
    required this.result,
    this.perceivedEffort,
    required this.painFlag,
    required this.startedAt,
    required this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['variant_id'] = Variable<String>(variantId);
    map['side'] = Variable<String>(side);
    map['set_number'] = Variable<int>(setNumber);
    map['target_ms'] = Variable<int>(targetMs);
    map['completed_ms'] = Variable<int>(completedMs);
    map['preparation_ms'] = Variable<int>(preparationMs);
    map['rest_ms'] = Variable<int>(restMs);
    map['pause_ms'] = Variable<int>(pauseMs);
    map['result'] = Variable<String>(result);
    if (!nullToAbsent || perceivedEffort != null) {
      map['perceived_effort'] = Variable<int>(perceivedEffort);
    }
    map['pain_flag'] = Variable<bool>(painFlag);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    return map;
  }

  HoldAttemptsCompanion toCompanion(bool nullToAbsent) {
    return HoldAttemptsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      variantId: Value(variantId),
      side: Value(side),
      setNumber: Value(setNumber),
      targetMs: Value(targetMs),
      completedMs: Value(completedMs),
      preparationMs: Value(preparationMs),
      restMs: Value(restMs),
      pauseMs: Value(pauseMs),
      result: Value(result),
      perceivedEffort: perceivedEffort == null && nullToAbsent
          ? const Value.absent()
          : Value(perceivedEffort),
      painFlag: Value(painFlag),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
    );
  }

  factory HoldAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HoldAttempt(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      side: serializer.fromJson<String>(json['side']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      targetMs: serializer.fromJson<int>(json['targetMs']),
      completedMs: serializer.fromJson<int>(json['completedMs']),
      preparationMs: serializer.fromJson<int>(json['preparationMs']),
      restMs: serializer.fromJson<int>(json['restMs']),
      pauseMs: serializer.fromJson<int>(json['pauseMs']),
      result: serializer.fromJson<String>(json['result']),
      perceivedEffort: serializer.fromJson<int?>(json['perceivedEffort']),
      painFlag: serializer.fromJson<bool>(json['painFlag']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'variantId': serializer.toJson<String>(variantId),
      'side': serializer.toJson<String>(side),
      'setNumber': serializer.toJson<int>(setNumber),
      'targetMs': serializer.toJson<int>(targetMs),
      'completedMs': serializer.toJson<int>(completedMs),
      'preparationMs': serializer.toJson<int>(preparationMs),
      'restMs': serializer.toJson<int>(restMs),
      'pauseMs': serializer.toJson<int>(pauseMs),
      'result': serializer.toJson<String>(result),
      'perceivedEffort': serializer.toJson<int?>(perceivedEffort),
      'painFlag': serializer.toJson<bool>(painFlag),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
    };
  }

  HoldAttempt copyWith({
    String? id,
    String? sessionId,
    String? exerciseId,
    String? variantId,
    String? side,
    int? setNumber,
    int? targetMs,
    int? completedMs,
    int? preparationMs,
    int? restMs,
    int? pauseMs,
    String? result,
    Value<int?> perceivedEffort = const Value.absent(),
    bool? painFlag,
    DateTime? startedAt,
    DateTime? endedAt,
  }) => HoldAttempt(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    variantId: variantId ?? this.variantId,
    side: side ?? this.side,
    setNumber: setNumber ?? this.setNumber,
    targetMs: targetMs ?? this.targetMs,
    completedMs: completedMs ?? this.completedMs,
    preparationMs: preparationMs ?? this.preparationMs,
    restMs: restMs ?? this.restMs,
    pauseMs: pauseMs ?? this.pauseMs,
    result: result ?? this.result,
    perceivedEffort: perceivedEffort.present
        ? perceivedEffort.value
        : this.perceivedEffort,
    painFlag: painFlag ?? this.painFlag,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
  );
  HoldAttempt copyWithCompanion(HoldAttemptsCompanion data) {
    return HoldAttempt(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      side: data.side.present ? data.side.value : this.side,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      targetMs: data.targetMs.present ? data.targetMs.value : this.targetMs,
      completedMs: data.completedMs.present
          ? data.completedMs.value
          : this.completedMs,
      preparationMs: data.preparationMs.present
          ? data.preparationMs.value
          : this.preparationMs,
      restMs: data.restMs.present ? data.restMs.value : this.restMs,
      pauseMs: data.pauseMs.present ? data.pauseMs.value : this.pauseMs,
      result: data.result.present ? data.result.value : this.result,
      perceivedEffort: data.perceivedEffort.present
          ? data.perceivedEffort.value
          : this.perceivedEffort,
      painFlag: data.painFlag.present ? data.painFlag.value : this.painFlag,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HoldAttempt(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('variantId: $variantId, ')
          ..write('side: $side, ')
          ..write('setNumber: $setNumber, ')
          ..write('targetMs: $targetMs, ')
          ..write('completedMs: $completedMs, ')
          ..write('preparationMs: $preparationMs, ')
          ..write('restMs: $restMs, ')
          ..write('pauseMs: $pauseMs, ')
          ..write('result: $result, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseId,
    variantId,
    side,
    setNumber,
    targetMs,
    completedMs,
    preparationMs,
    restMs,
    pauseMs,
    result,
    perceivedEffort,
    painFlag,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HoldAttempt &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.variantId == this.variantId &&
          other.side == this.side &&
          other.setNumber == this.setNumber &&
          other.targetMs == this.targetMs &&
          other.completedMs == this.completedMs &&
          other.preparationMs == this.preparationMs &&
          other.restMs == this.restMs &&
          other.pauseMs == this.pauseMs &&
          other.result == this.result &&
          other.perceivedEffort == this.perceivedEffort &&
          other.painFlag == this.painFlag &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class HoldAttemptsCompanion extends UpdateCompanion<HoldAttempt> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseId;
  final Value<String> variantId;
  final Value<String> side;
  final Value<int> setNumber;
  final Value<int> targetMs;
  final Value<int> completedMs;
  final Value<int> preparationMs;
  final Value<int> restMs;
  final Value<int> pauseMs;
  final Value<String> result;
  final Value<int?> perceivedEffort;
  final Value<bool> painFlag;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> rowid;
  const HoldAttemptsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.side = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.targetMs = const Value.absent(),
    this.completedMs = const Value.absent(),
    this.preparationMs = const Value.absent(),
    this.restMs = const Value.absent(),
    this.pauseMs = const Value.absent(),
    this.result = const Value.absent(),
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HoldAttemptsCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseId,
    required String variantId,
    this.side = const Value.absent(),
    this.setNumber = const Value.absent(),
    required int targetMs,
    required int completedMs,
    this.preparationMs = const Value.absent(),
    this.restMs = const Value.absent(),
    this.pauseMs = const Value.absent(),
    required String result,
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    required DateTime startedAt,
    required DateTime endedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       variantId = Value(variantId),
       targetMs = Value(targetMs),
       completedMs = Value(completedMs),
       result = Value(result),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt);
  static Insertable<HoldAttempt> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<String>? variantId,
    Expression<String>? side,
    Expression<int>? setNumber,
    Expression<int>? targetMs,
    Expression<int>? completedMs,
    Expression<int>? preparationMs,
    Expression<int>? restMs,
    Expression<int>? pauseMs,
    Expression<String>? result,
    Expression<int>? perceivedEffort,
    Expression<bool>? painFlag,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (variantId != null) 'variant_id': variantId,
      if (side != null) 'side': side,
      if (setNumber != null) 'set_number': setNumber,
      if (targetMs != null) 'target_ms': targetMs,
      if (completedMs != null) 'completed_ms': completedMs,
      if (preparationMs != null) 'preparation_ms': preparationMs,
      if (restMs != null) 'rest_ms': restMs,
      if (pauseMs != null) 'pause_ms': pauseMs,
      if (result != null) 'result': result,
      if (perceivedEffort != null) 'perceived_effort': perceivedEffort,
      if (painFlag != null) 'pain_flag': painFlag,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HoldAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? exerciseId,
    Value<String>? variantId,
    Value<String>? side,
    Value<int>? setNumber,
    Value<int>? targetMs,
    Value<int>? completedMs,
    Value<int>? preparationMs,
    Value<int>? restMs,
    Value<int>? pauseMs,
    Value<String>? result,
    Value<int?>? perceivedEffort,
    Value<bool>? painFlag,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? rowid,
  }) {
    return HoldAttemptsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      variantId: variantId ?? this.variantId,
      side: side ?? this.side,
      setNumber: setNumber ?? this.setNumber,
      targetMs: targetMs ?? this.targetMs,
      completedMs: completedMs ?? this.completedMs,
      preparationMs: preparationMs ?? this.preparationMs,
      restMs: restMs ?? this.restMs,
      pauseMs: pauseMs ?? this.pauseMs,
      result: result ?? this.result,
      perceivedEffort: perceivedEffort ?? this.perceivedEffort,
      painFlag: painFlag ?? this.painFlag,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (targetMs.present) {
      map['target_ms'] = Variable<int>(targetMs.value);
    }
    if (completedMs.present) {
      map['completed_ms'] = Variable<int>(completedMs.value);
    }
    if (preparationMs.present) {
      map['preparation_ms'] = Variable<int>(preparationMs.value);
    }
    if (restMs.present) {
      map['rest_ms'] = Variable<int>(restMs.value);
    }
    if (pauseMs.present) {
      map['pause_ms'] = Variable<int>(pauseMs.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (perceivedEffort.present) {
      map['perceived_effort'] = Variable<int>(perceivedEffort.value);
    }
    if (painFlag.present) {
      map['pain_flag'] = Variable<bool>(painFlag.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HoldAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('variantId: $variantId, ')
          ..write('side: $side, ')
          ..write('setNumber: $setNumber, ')
          ..write('targetMs: $targetMs, ')
          ..write('completedMs: $completedMs, ')
          ..write('preparationMs: $preparationMs, ')
          ..write('restMs: $restMs, ')
          ..write('pauseMs: $pauseMs, ')
          ..write('result: $result, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionFeedbackTable extends SessionFeedback
    with TableInfo<$SessionFeedbackTable, SessionFeedbackData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionFeedbackTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perceivedEffortMeta = const VerificationMeta(
    'perceivedEffort',
  );
  @override
  late final GeneratedColumn<int> perceivedEffort = GeneratedColumn<int>(
    'perceived_effort',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _painFlagMeta = const VerificationMeta(
    'painFlag',
  );
  @override
  late final GeneratedColumn<bool> painFlag = GeneratedColumn<bool>(
    'pain_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pain_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    perceivedEffort,
    painFlag,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionFeedbackData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('perceived_effort')) {
      context.handle(
        _perceivedEffortMeta,
        perceivedEffort.isAcceptableOrUnknown(
          data['perceived_effort']!,
          _perceivedEffortMeta,
        ),
      );
    }
    if (data.containsKey('pain_flag')) {
      context.handle(
        _painFlagMeta,
        painFlag.isAcceptableOrUnknown(data['pain_flag']!, _painFlagMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionFeedbackData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionFeedbackData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      perceivedEffort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}perceived_effort'],
      ),
      painFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pain_flag'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionFeedbackTable createAlias(String alias) {
    return $SessionFeedbackTable(attachedDatabase, alias);
  }
}

class SessionFeedbackData extends DataClass
    implements Insertable<SessionFeedbackData> {
  final int id;
  final String sessionId;
  final int? perceivedEffort;
  final bool painFlag;
  final String? note;
  final DateTime createdAt;
  const SessionFeedbackData({
    required this.id,
    required this.sessionId,
    this.perceivedEffort,
    required this.painFlag,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || perceivedEffort != null) {
      map['perceived_effort'] = Variable<int>(perceivedEffort);
    }
    map['pain_flag'] = Variable<bool>(painFlag);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionFeedbackCompanion toCompanion(bool nullToAbsent) {
    return SessionFeedbackCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      perceivedEffort: perceivedEffort == null && nullToAbsent
          ? const Value.absent()
          : Value(perceivedEffort),
      painFlag: Value(painFlag),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory SessionFeedbackData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionFeedbackData(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      perceivedEffort: serializer.fromJson<int?>(json['perceivedEffort']),
      painFlag: serializer.fromJson<bool>(json['painFlag']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'perceivedEffort': serializer.toJson<int?>(perceivedEffort),
      'painFlag': serializer.toJson<bool>(painFlag),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionFeedbackData copyWith({
    int? id,
    String? sessionId,
    Value<int?> perceivedEffort = const Value.absent(),
    bool? painFlag,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => SessionFeedbackData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    perceivedEffort: perceivedEffort.present
        ? perceivedEffort.value
        : this.perceivedEffort,
    painFlag: painFlag ?? this.painFlag,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  SessionFeedbackData copyWithCompanion(SessionFeedbackCompanion data) {
    return SessionFeedbackData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      perceivedEffort: data.perceivedEffort.present
          ? data.perceivedEffort.value
          : this.perceivedEffort,
      painFlag: data.painFlag.present ? data.painFlag.value : this.painFlag,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionFeedbackData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, perceivedEffort, painFlag, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionFeedbackData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.perceivedEffort == this.perceivedEffort &&
          other.painFlag == this.painFlag &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class SessionFeedbackCompanion extends UpdateCompanion<SessionFeedbackData> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int?> perceivedEffort;
  final Value<bool> painFlag;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const SessionFeedbackCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SessionFeedbackCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    this.perceivedEffort = const Value.absent(),
    this.painFlag = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : sessionId = Value(sessionId);
  static Insertable<SessionFeedbackData> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? perceivedEffort,
    Expression<bool>? painFlag,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (perceivedEffort != null) 'perceived_effort': perceivedEffort,
      if (painFlag != null) 'pain_flag': painFlag,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SessionFeedbackCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int?>? perceivedEffort,
    Value<bool>? painFlag,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return SessionFeedbackCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      perceivedEffort: perceivedEffort ?? this.perceivedEffort,
      painFlag: painFlag ?? this.painFlag,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (perceivedEffort.present) {
      map['perceived_effort'] = Variable<int>(perceivedEffort.value);
    }
    if (painFlag.present) {
      map['pain_flag'] = Variable<bool>(painFlag.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionFeedbackCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('perceivedEffort: $perceivedEffort, ')
          ..write('painFlag: $painFlag, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PersonalBestsTable extends PersonalBests
    with TableInfo<$PersonalBestsTable, PersonalBest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalBestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _bestMsMeta = const VerificationMeta('bestMs');
  @override
  late final GeneratedColumn<int> bestMs = GeneratedColumn<int>(
    'best_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    variantId,
    side,
    bestMs,
    achievedAt,
    sessionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_bests';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalBest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    }
    if (data.containsKey('best_ms')) {
      context.handle(
        _bestMsMeta,
        bestMs.isAcceptableOrUnknown(data['best_ms']!, _bestMsMeta),
      );
    } else if (isInserting) {
      context.missing(_bestMsMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {variantId, side},
  ];
  @override
  PersonalBest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalBest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      )!,
      bestMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_ms'],
      )!,
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      ),
    );
  }

  @override
  $PersonalBestsTable createAlias(String alias) {
    return $PersonalBestsTable(attachedDatabase, alias);
  }
}

class PersonalBest extends DataClass implements Insertable<PersonalBest> {
  final int id;
  final String variantId;
  final String side;
  final int bestMs;
  final DateTime achievedAt;
  final String? sessionId;
  const PersonalBest({
    required this.id,
    required this.variantId,
    required this.side,
    required this.bestMs,
    required this.achievedAt,
    this.sessionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['variant_id'] = Variable<String>(variantId);
    map['side'] = Variable<String>(side);
    map['best_ms'] = Variable<int>(bestMs);
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    return map;
  }

  PersonalBestsCompanion toCompanion(bool nullToAbsent) {
    return PersonalBestsCompanion(
      id: Value(id),
      variantId: Value(variantId),
      side: Value(side),
      bestMs: Value(bestMs),
      achievedAt: Value(achievedAt),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
    );
  }

  factory PersonalBest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalBest(
      id: serializer.fromJson<int>(json['id']),
      variantId: serializer.fromJson<String>(json['variantId']),
      side: serializer.fromJson<String>(json['side']),
      bestMs: serializer.fromJson<int>(json['bestMs']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'variantId': serializer.toJson<String>(variantId),
      'side': serializer.toJson<String>(side),
      'bestMs': serializer.toJson<int>(bestMs),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
      'sessionId': serializer.toJson<String?>(sessionId),
    };
  }

  PersonalBest copyWith({
    int? id,
    String? variantId,
    String? side,
    int? bestMs,
    DateTime? achievedAt,
    Value<String?> sessionId = const Value.absent(),
  }) => PersonalBest(
    id: id ?? this.id,
    variantId: variantId ?? this.variantId,
    side: side ?? this.side,
    bestMs: bestMs ?? this.bestMs,
    achievedAt: achievedAt ?? this.achievedAt,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
  );
  PersonalBest copyWithCompanion(PersonalBestsCompanion data) {
    return PersonalBest(
      id: data.id.present ? data.id.value : this.id,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      side: data.side.present ? data.side.value : this.side,
      bestMs: data.bestMs.present ? data.bestMs.value : this.bestMs,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalBest(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('side: $side, ')
          ..write('bestMs: $bestMs, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('sessionId: $sessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, variantId, side, bestMs, achievedAt, sessionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalBest &&
          other.id == this.id &&
          other.variantId == this.variantId &&
          other.side == this.side &&
          other.bestMs == this.bestMs &&
          other.achievedAt == this.achievedAt &&
          other.sessionId == this.sessionId);
}

class PersonalBestsCompanion extends UpdateCompanion<PersonalBest> {
  final Value<int> id;
  final Value<String> variantId;
  final Value<String> side;
  final Value<int> bestMs;
  final Value<DateTime> achievedAt;
  final Value<String?> sessionId;
  const PersonalBestsCompanion({
    this.id = const Value.absent(),
    this.variantId = const Value.absent(),
    this.side = const Value.absent(),
    this.bestMs = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.sessionId = const Value.absent(),
  });
  PersonalBestsCompanion.insert({
    this.id = const Value.absent(),
    required String variantId,
    this.side = const Value.absent(),
    required int bestMs,
    required DateTime achievedAt,
    this.sessionId = const Value.absent(),
  }) : variantId = Value(variantId),
       bestMs = Value(bestMs),
       achievedAt = Value(achievedAt);
  static Insertable<PersonalBest> custom({
    Expression<int>? id,
    Expression<String>? variantId,
    Expression<String>? side,
    Expression<int>? bestMs,
    Expression<DateTime>? achievedAt,
    Expression<String>? sessionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (variantId != null) 'variant_id': variantId,
      if (side != null) 'side': side,
      if (bestMs != null) 'best_ms': bestMs,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (sessionId != null) 'session_id': sessionId,
    });
  }

  PersonalBestsCompanion copyWith({
    Value<int>? id,
    Value<String>? variantId,
    Value<String>? side,
    Value<int>? bestMs,
    Value<DateTime>? achievedAt,
    Value<String?>? sessionId,
  }) {
    return PersonalBestsCompanion(
      id: id ?? this.id,
      variantId: variantId ?? this.variantId,
      side: side ?? this.side,
      bestMs: bestMs ?? this.bestMs,
      achievedAt: achievedAt ?? this.achievedAt,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (bestMs.present) {
      map['best_ms'] = Variable<int>(bestMs.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalBestsCompanion(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('side: $side, ')
          ..write('bestMs: $bestMs, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('sessionId: $sessionId')
          ..write(')'))
        .toString();
  }
}

class $ProgressSnapshotsTable extends ProgressSnapshots
    with TableInfo<$ProgressSnapshotsTable, ProgressSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSessionsMeta = const VerificationMeta(
    'totalSessions',
  );
  @override
  late final GeneratedColumn<int> totalSessions = GeneratedColumn<int>(
    'total_sessions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalHoldMsMeta = const VerificationMeta(
    'totalHoldMs',
  );
  @override
  late final GeneratedColumn<int> totalHoldMs = GeneratedColumn<int>(
    'total_hold_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekSessionsMeta = const VerificationMeta(
    'weekSessions',
  );
  @override
  late final GeneratedColumn<int> weekSessions = GeneratedColumn<int>(
    'week_sessions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    capturedAt,
    totalSessions,
    totalHoldMs,
    weekSessions,
    payloadJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('total_sessions')) {
      context.handle(
        _totalSessionsMeta,
        totalSessions.isAcceptableOrUnknown(
          data['total_sessions']!,
          _totalSessionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalSessionsMeta);
    }
    if (data.containsKey('total_hold_ms')) {
      context.handle(
        _totalHoldMsMeta,
        totalHoldMs.isAcceptableOrUnknown(
          data['total_hold_ms']!,
          _totalHoldMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalHoldMsMeta);
    }
    if (data.containsKey('week_sessions')) {
      context.handle(
        _weekSessionsMeta,
        weekSessions.isAcceptableOrUnknown(
          data['week_sessions']!,
          _weekSessionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekSessionsMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
      totalSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_sessions'],
      )!,
      totalHoldMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_hold_ms'],
      )!,
      weekSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_sessions'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
    );
  }

  @override
  $ProgressSnapshotsTable createAlias(String alias) {
    return $ProgressSnapshotsTable(attachedDatabase, alias);
  }
}

class ProgressSnapshot extends DataClass
    implements Insertable<ProgressSnapshot> {
  final int id;
  final DateTime capturedAt;
  final int totalSessions;
  final int totalHoldMs;
  final int weekSessions;
  final String payloadJson;
  const ProgressSnapshot({
    required this.id,
    required this.capturedAt,
    required this.totalSessions,
    required this.totalHoldMs,
    required this.weekSessions,
    required this.payloadJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    map['total_sessions'] = Variable<int>(totalSessions);
    map['total_hold_ms'] = Variable<int>(totalHoldMs);
    map['week_sessions'] = Variable<int>(weekSessions);
    map['payload_json'] = Variable<String>(payloadJson);
    return map;
  }

  ProgressSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return ProgressSnapshotsCompanion(
      id: Value(id),
      capturedAt: Value(capturedAt),
      totalSessions: Value(totalSessions),
      totalHoldMs: Value(totalHoldMs),
      weekSessions: Value(weekSessions),
      payloadJson: Value(payloadJson),
    );
  }

  factory ProgressSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressSnapshot(
      id: serializer.fromJson<int>(json['id']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      totalSessions: serializer.fromJson<int>(json['totalSessions']),
      totalHoldMs: serializer.fromJson<int>(json['totalHoldMs']),
      weekSessions: serializer.fromJson<int>(json['weekSessions']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'totalSessions': serializer.toJson<int>(totalSessions),
      'totalHoldMs': serializer.toJson<int>(totalHoldMs),
      'weekSessions': serializer.toJson<int>(weekSessions),
      'payloadJson': serializer.toJson<String>(payloadJson),
    };
  }

  ProgressSnapshot copyWith({
    int? id,
    DateTime? capturedAt,
    int? totalSessions,
    int? totalHoldMs,
    int? weekSessions,
    String? payloadJson,
  }) => ProgressSnapshot(
    id: id ?? this.id,
    capturedAt: capturedAt ?? this.capturedAt,
    totalSessions: totalSessions ?? this.totalSessions,
    totalHoldMs: totalHoldMs ?? this.totalHoldMs,
    weekSessions: weekSessions ?? this.weekSessions,
    payloadJson: payloadJson ?? this.payloadJson,
  );
  ProgressSnapshot copyWithCompanion(ProgressSnapshotsCompanion data) {
    return ProgressSnapshot(
      id: data.id.present ? data.id.value : this.id,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      totalSessions: data.totalSessions.present
          ? data.totalSessions.value
          : this.totalSessions,
      totalHoldMs: data.totalHoldMs.present
          ? data.totalHoldMs.value
          : this.totalHoldMs,
      weekSessions: data.weekSessions.present
          ? data.weekSessions.value
          : this.weekSessions,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressSnapshot(')
          ..write('id: $id, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('totalHoldMs: $totalHoldMs, ')
          ..write('weekSessions: $weekSessions, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    capturedAt,
    totalSessions,
    totalHoldMs,
    weekSessions,
    payloadJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressSnapshot &&
          other.id == this.id &&
          other.capturedAt == this.capturedAt &&
          other.totalSessions == this.totalSessions &&
          other.totalHoldMs == this.totalHoldMs &&
          other.weekSessions == this.weekSessions &&
          other.payloadJson == this.payloadJson);
}

class ProgressSnapshotsCompanion extends UpdateCompanion<ProgressSnapshot> {
  final Value<int> id;
  final Value<DateTime> capturedAt;
  final Value<int> totalSessions;
  final Value<int> totalHoldMs;
  final Value<int> weekSessions;
  final Value<String> payloadJson;
  const ProgressSnapshotsCompanion({
    this.id = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.totalSessions = const Value.absent(),
    this.totalHoldMs = const Value.absent(),
    this.weekSessions = const Value.absent(),
    this.payloadJson = const Value.absent(),
  });
  ProgressSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime capturedAt,
    required int totalSessions,
    required int totalHoldMs,
    required int weekSessions,
    this.payloadJson = const Value.absent(),
  }) : capturedAt = Value(capturedAt),
       totalSessions = Value(totalSessions),
       totalHoldMs = Value(totalHoldMs),
       weekSessions = Value(weekSessions);
  static Insertable<ProgressSnapshot> custom({
    Expression<int>? id,
    Expression<DateTime>? capturedAt,
    Expression<int>? totalSessions,
    Expression<int>? totalHoldMs,
    Expression<int>? weekSessions,
    Expression<String>? payloadJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (totalSessions != null) 'total_sessions': totalSessions,
      if (totalHoldMs != null) 'total_hold_ms': totalHoldMs,
      if (weekSessions != null) 'week_sessions': weekSessions,
      if (payloadJson != null) 'payload_json': payloadJson,
    });
  }

  ProgressSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? capturedAt,
    Value<int>? totalSessions,
    Value<int>? totalHoldMs,
    Value<int>? weekSessions,
    Value<String>? payloadJson,
  }) {
    return ProgressSnapshotsCompanion(
      id: id ?? this.id,
      capturedAt: capturedAt ?? this.capturedAt,
      totalSessions: totalSessions ?? this.totalSessions,
      totalHoldMs: totalHoldMs ?? this.totalHoldMs,
      weekSessions: weekSessions ?? this.weekSessions,
      payloadJson: payloadJson ?? this.payloadJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (totalSessions.present) {
      map['total_sessions'] = Variable<int>(totalSessions.value);
    }
    if (totalHoldMs.present) {
      map['total_hold_ms'] = Variable<int>(totalHoldMs.value);
    }
    if (weekSessions.present) {
      map['week_sessions'] = Variable<int>(weekSessions.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('totalHoldMs: $totalHoldMs, ')
          ..write('weekSessions: $weekSessions, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }
}

class $XpEventsTable extends XpEvents with TableInfo<$XpEventsTable, XpEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceType,
    sourceId,
    amount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<XpEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  XpEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $XpEventsTable createAlias(String alias) {
    return $XpEventsTable(attachedDatabase, alias);
  }
}

class XpEvent extends DataClass implements Insertable<XpEvent> {
  final String id;
  final String sourceType;
  final String sourceId;
  final int amount;
  final DateTime createdAt;
  const XpEvent({
    required this.id,
    required this.sourceType,
    required this.sourceId,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['amount'] = Variable<int>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  XpEventsCompanion toCompanion(bool nullToAbsent) {
    return XpEventsCompanion(
      id: Value(id),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory XpEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpEvent(
      id: serializer.fromJson<String>(json['id']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      amount: serializer.fromJson<int>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'amount': serializer.toJson<int>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  XpEvent copyWith({
    String? id,
    String? sourceType,
    String? sourceId,
    int? amount,
    DateTime? createdAt,
  }) => XpEvent(
    id: id ?? this.id,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId ?? this.sourceId,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  XpEvent copyWithCompanion(XpEventsCompanion data) {
    return XpEvent(
      id: data.id.present ? data.id.value : this.id,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpEvent(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceType, sourceId, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpEvent &&
          other.id == this.id &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class XpEventsCompanion extends UpdateCompanion<XpEvent> {
  final Value<String> id;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int> amount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const XpEventsCompanion({
    this.id = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  XpEventsCompanion.insert({
    required String id,
    required String sourceType,
    required String sourceId,
    required int amount,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceType = Value(sourceType),
       sourceId = Value(sourceId),
       amount = Value(amount);
  static Insertable<XpEvent> custom({
    Expression<String>? id,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? amount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  XpEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceType,
    Value<String>? sourceId,
    Value<int>? amount,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return XpEventsCompanion(
      id: id ?? this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpEventsCompanion(')
          ..write('id: $id, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserLevelsTable extends UserLevels
    with TableInfo<$UserLevelsTable, UserLevel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLevelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, totalXp, level, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_levels';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserLevel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserLevel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLevel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserLevelsTable createAlias(String alias) {
    return $UserLevelsTable(attachedDatabase, alias);
  }
}

class UserLevel extends DataClass implements Insertable<UserLevel> {
  final int id;
  final int totalXp;
  final int level;
  final DateTime updatedAt;
  const UserLevel({
    required this.id,
    required this.totalXp,
    required this.level,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_xp'] = Variable<int>(totalXp);
    map['level'] = Variable<int>(level);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserLevelsCompanion toCompanion(bool nullToAbsent) {
    return UserLevelsCompanion(
      id: Value(id),
      totalXp: Value(totalXp),
      level: Value(level),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserLevel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLevel(
      id: serializer.fromJson<int>(json['id']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      level: serializer.fromJson<int>(json['level']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalXp': serializer.toJson<int>(totalXp),
      'level': serializer.toJson<int>(level),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserLevel copyWith({
    int? id,
    int? totalXp,
    int? level,
    DateTime? updatedAt,
  }) => UserLevel(
    id: id ?? this.id,
    totalXp: totalXp ?? this.totalXp,
    level: level ?? this.level,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserLevel copyWithCompanion(UserLevelsCompanion data) {
    return UserLevel(
      id: data.id.present ? data.id.value : this.id,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      level: data.level.present ? data.level.value : this.level,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserLevel(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalXp, level, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLevel &&
          other.id == this.id &&
          other.totalXp == this.totalXp &&
          other.level == this.level &&
          other.updatedAt == this.updatedAt);
}

class UserLevelsCompanion extends UpdateCompanion<UserLevel> {
  final Value<int> id;
  final Value<int> totalXp;
  final Value<int> level;
  final Value<DateTime> updatedAt;
  const UserLevelsCompanion({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserLevelsCompanion.insert({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserLevel> custom({
    Expression<int>? id,
    Expression<int>? totalXp,
    Expression<int>? level,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalXp != null) 'total_xp': totalXp,
      if (level != null) 'level': level,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserLevelsCompanion copyWith({
    Value<int>? id,
    Value<int>? totalXp,
    Value<int>? level,
    Value<DateTime>? updatedAt,
  }) {
    return UserLevelsCompanion(
      id: id ?? this.id,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLevelsCompanion(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final String id;
  final String name;
  final String description;
  const Achievement({
    required this.id,
    required this.name,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  Achievement copyWith({String? id, String? name, String? description}) =>
      Achievement(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String name,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description);
  static Insertable<Achievement> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementProgressTable extends AchievementProgress
    with TableInfo<$AchievementProgressTable, AchievementProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedMeta = const VerificationMeta(
    'unlocked',
  );
  @override
  late final GeneratedColumn<bool> unlocked = GeneratedColumn<bool>(
    'unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceSessionIdMeta = const VerificationMeta(
    'sourceSessionId',
  );
  @override
  late final GeneratedColumn<String> sourceSessionId = GeneratedColumn<String>(
    'source_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    achievementId,
    unlocked,
    unlockedAt,
    sourceSessionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievement_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('unlocked')) {
      context.handle(
        _unlockedMeta,
        unlocked.isAcceptableOrUnknown(data['unlocked']!, _unlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    if (data.containsKey('source_session_id')) {
      context.handle(
        _sourceSessionIdMeta,
        sourceSessionId.isAcceptableOrUnknown(
          data['source_session_id']!,
          _sourceSessionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {achievementId},
  ];
  @override
  AchievementProgressData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      achievementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_id'],
      )!,
      unlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
      sourceSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_session_id'],
      ),
    );
  }

  @override
  $AchievementProgressTable createAlias(String alias) {
    return $AchievementProgressTable(attachedDatabase, alias);
  }
}

class AchievementProgressData extends DataClass
    implements Insertable<AchievementProgressData> {
  final int id;
  final String achievementId;
  final bool unlocked;
  final DateTime? unlockedAt;
  final String? sourceSessionId;
  const AchievementProgressData({
    required this.id,
    required this.achievementId,
    required this.unlocked,
    this.unlockedAt,
    this.sourceSessionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['achievement_id'] = Variable<String>(achievementId);
    map['unlocked'] = Variable<bool>(unlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    if (!nullToAbsent || sourceSessionId != null) {
      map['source_session_id'] = Variable<String>(sourceSessionId);
    }
    return map;
  }

  AchievementProgressCompanion toCompanion(bool nullToAbsent) {
    return AchievementProgressCompanion(
      id: Value(id),
      achievementId: Value(achievementId),
      unlocked: Value(unlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
      sourceSessionId: sourceSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceSessionId),
    );
  }

  factory AchievementProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementProgressData(
      id: serializer.fromJson<int>(json['id']),
      achievementId: serializer.fromJson<String>(json['achievementId']),
      unlocked: serializer.fromJson<bool>(json['unlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
      sourceSessionId: serializer.fromJson<String?>(json['sourceSessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'achievementId': serializer.toJson<String>(achievementId),
      'unlocked': serializer.toJson<bool>(unlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
      'sourceSessionId': serializer.toJson<String?>(sourceSessionId),
    };
  }

  AchievementProgressData copyWith({
    int? id,
    String? achievementId,
    bool? unlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
    Value<String?> sourceSessionId = const Value.absent(),
  }) => AchievementProgressData(
    id: id ?? this.id,
    achievementId: achievementId ?? this.achievementId,
    unlocked: unlocked ?? this.unlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
    sourceSessionId: sourceSessionId.present
        ? sourceSessionId.value
        : this.sourceSessionId,
  );
  AchievementProgressData copyWithCompanion(AchievementProgressCompanion data) {
    return AchievementProgressData(
      id: data.id.present ? data.id.value : this.id,
      achievementId: data.achievementId.present
          ? data.achievementId.value
          : this.achievementId,
      unlocked: data.unlocked.present ? data.unlocked.value : this.unlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
      sourceSessionId: data.sourceSessionId.present
          ? data.sourceSessionId.value
          : this.sourceSessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementProgressData(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('sourceSessionId: $sourceSessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, achievementId, unlocked, unlockedAt, sourceSessionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementProgressData &&
          other.id == this.id &&
          other.achievementId == this.achievementId &&
          other.unlocked == this.unlocked &&
          other.unlockedAt == this.unlockedAt &&
          other.sourceSessionId == this.sourceSessionId);
}

class AchievementProgressCompanion
    extends UpdateCompanion<AchievementProgressData> {
  final Value<int> id;
  final Value<String> achievementId;
  final Value<bool> unlocked;
  final Value<DateTime?> unlockedAt;
  final Value<String?> sourceSessionId;
  const AchievementProgressCompanion({
    this.id = const Value.absent(),
    this.achievementId = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.sourceSessionId = const Value.absent(),
  });
  AchievementProgressCompanion.insert({
    this.id = const Value.absent(),
    required String achievementId,
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.sourceSessionId = const Value.absent(),
  }) : achievementId = Value(achievementId);
  static Insertable<AchievementProgressData> custom({
    Expression<int>? id,
    Expression<String>? achievementId,
    Expression<bool>? unlocked,
    Expression<DateTime>? unlockedAt,
    Expression<String>? sourceSessionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (achievementId != null) 'achievement_id': achievementId,
      if (unlocked != null) 'unlocked': unlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (sourceSessionId != null) 'source_session_id': sourceSessionId,
    });
  }

  AchievementProgressCompanion copyWith({
    Value<int>? id,
    Value<String>? achievementId,
    Value<bool>? unlocked,
    Value<DateTime?>? unlockedAt,
    Value<String?>? sourceSessionId,
  }) {
    return AchievementProgressCompanion(
      id: id ?? this.id,
      achievementId: achievementId ?? this.achievementId,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      sourceSessionId: sourceSessionId ?? this.sourceSessionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (unlocked.present) {
      map['unlocked'] = Variable<bool>(unlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (sourceSessionId.present) {
      map['source_session_id'] = Variable<String>(sourceSessionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementProgressCompanion(')
          ..write('id: $id, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('sourceSessionId: $sourceSessionId')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, Challenge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCountMeta = const VerificationMeta(
    'targetCount',
  );
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, targetCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Challenge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('target_count')) {
      context.handle(
        _targetCountMeta,
        targetCount.isAcceptableOrUnknown(
          data['target_count']!,
          _targetCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Challenge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Challenge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      )!,
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class Challenge extends DataClass implements Insertable<Challenge> {
  final String id;
  final String name;
  final String description;
  final int targetCount;
  const Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.targetCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['target_count'] = Variable<int>(targetCount);
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      targetCount: Value(targetCount),
    );
  }

  factory Challenge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Challenge(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'targetCount': serializer.toJson<int>(targetCount),
    };
  }

  Challenge copyWith({
    String? id,
    String? name,
    String? description,
    int? targetCount,
  }) => Challenge(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    targetCount: targetCount ?? this.targetCount,
  );
  Challenge copyWithCompanion(ChallengesCompanion data) {
    return Challenge(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Challenge(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetCount: $targetCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, targetCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Challenge &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.targetCount == this.targetCount);
}

class ChallengesCompanion extends UpdateCompanion<Challenge> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> targetCount;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String name,
    required String description,
    required int targetCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       targetCount = Value(targetCount);
  static Insertable<Challenge> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? targetCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (targetCount != null) 'target_count': targetCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? targetCount,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetCount: targetCount ?? this.targetCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetCount: $targetCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengeProgressTable extends ChallengeProgress
    with TableInfo<$ChallengeProgressTable, ChallengeProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengeProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _challengeIdMeta = const VerificationMeta(
    'challengeId',
  );
  @override
  late final GeneratedColumn<String> challengeId = GeneratedColumn<String>(
    'challenge_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentCountMeta = const VerificationMeta(
    'currentCount',
  );
  @override
  late final GeneratedColumn<int> currentCount = GeneratedColumn<int>(
    'current_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    challengeId,
    currentCount,
    completed,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenge_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengeProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('challenge_id')) {
      context.handle(
        _challengeIdMeta,
        challengeId.isAcceptableOrUnknown(
          data['challenge_id']!,
          _challengeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_challengeIdMeta);
    }
    if (data.containsKey('current_count')) {
      context.handle(
        _currentCountMeta,
        currentCount.isAcceptableOrUnknown(
          data['current_count']!,
          _currentCountMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {challengeId},
  ];
  @override
  ChallengeProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      challengeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_id'],
      )!,
      currentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_count'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ChallengeProgressTable createAlias(String alias) {
    return $ChallengeProgressTable(attachedDatabase, alias);
  }
}

class ChallengeProgressData extends DataClass
    implements Insertable<ChallengeProgressData> {
  final int id;
  final String challengeId;
  final int currentCount;
  final bool completed;
  final DateTime? completedAt;
  const ChallengeProgressData({
    required this.id,
    required this.challengeId,
    required this.currentCount,
    required this.completed,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['challenge_id'] = Variable<String>(challengeId);
    map['current_count'] = Variable<int>(currentCount);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChallengeProgressCompanion toCompanion(bool nullToAbsent) {
    return ChallengeProgressCompanion(
      id: Value(id),
      challengeId: Value(challengeId),
      currentCount: Value(currentCount),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ChallengeProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeProgressData(
      id: serializer.fromJson<int>(json['id']),
      challengeId: serializer.fromJson<String>(json['challengeId']),
      currentCount: serializer.fromJson<int>(json['currentCount']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'challengeId': serializer.toJson<String>(challengeId),
      'currentCount': serializer.toJson<int>(currentCount),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ChallengeProgressData copyWith({
    int? id,
    String? challengeId,
    int? currentCount,
    bool? completed,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ChallengeProgressData(
    id: id ?? this.id,
    challengeId: challengeId ?? this.challengeId,
    currentCount: currentCount ?? this.currentCount,
    completed: completed ?? this.completed,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ChallengeProgressData copyWithCompanion(ChallengeProgressCompanion data) {
    return ChallengeProgressData(
      id: data.id.present ? data.id.value : this.id,
      challengeId: data.challengeId.present
          ? data.challengeId.value
          : this.challengeId,
      currentCount: data.currentCount.present
          ? data.currentCount.value
          : this.currentCount,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeProgressData(')
          ..write('id: $id, ')
          ..write('challengeId: $challengeId, ')
          ..write('currentCount: $currentCount, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, challengeId, currentCount, completed, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeProgressData &&
          other.id == this.id &&
          other.challengeId == this.challengeId &&
          other.currentCount == this.currentCount &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt);
}

class ChallengeProgressCompanion
    extends UpdateCompanion<ChallengeProgressData> {
  final Value<int> id;
  final Value<String> challengeId;
  final Value<int> currentCount;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  const ChallengeProgressCompanion({
    this.id = const Value.absent(),
    this.challengeId = const Value.absent(),
    this.currentCount = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  ChallengeProgressCompanion.insert({
    this.id = const Value.absent(),
    required String challengeId,
    this.currentCount = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : challengeId = Value(challengeId);
  static Insertable<ChallengeProgressData> custom({
    Expression<int>? id,
    Expression<String>? challengeId,
    Expression<int>? currentCount,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (challengeId != null) 'challenge_id': challengeId,
      if (currentCount != null) 'current_count': currentCount,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  ChallengeProgressCompanion copyWith({
    Value<int>? id,
    Value<String>? challengeId,
    Value<int>? currentCount,
    Value<bool>? completed,
    Value<DateTime?>? completedAt,
  }) {
    return ChallengeProgressCompanion(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      currentCount: currentCount ?? this.currentCount,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (currentCount.present) {
      map['current_count'] = Variable<int>(currentCount.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeProgressCompanion(')
          ..write('id: $id, ')
          ..write('challengeId: $challengeId, ')
          ..write('currentCount: $currentCount, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $AvatarDefinitionsTable extends AvatarDefinitions
    with TableInfo<$AvatarDefinitionsTable, AvatarDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvatarDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statesJsonMeta = const VerificationMeta(
    'statesJson',
  );
  @override
  late final GeneratedColumn<String> statesJson = GeneratedColumn<String>(
    'states_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, statesJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'avatar_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvatarDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('states_json')) {
      context.handle(
        _statesJsonMeta,
        statesJson.isAcceptableOrUnknown(data['states_json']!, _statesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_statesJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvatarDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvatarDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      statesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}states_json'],
      )!,
    );
  }

  @override
  $AvatarDefinitionsTable createAlias(String alias) {
    return $AvatarDefinitionsTable(attachedDatabase, alias);
  }
}

class AvatarDefinition extends DataClass
    implements Insertable<AvatarDefinition> {
  final String id;
  final String name;
  final String description;
  final String statesJson;
  const AvatarDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.statesJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['states_json'] = Variable<String>(statesJson);
    return map;
  }

  AvatarDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return AvatarDefinitionsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      statesJson: Value(statesJson),
    );
  }

  factory AvatarDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvatarDefinition(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      statesJson: serializer.fromJson<String>(json['statesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'statesJson': serializer.toJson<String>(statesJson),
    };
  }

  AvatarDefinition copyWith({
    String? id,
    String? name,
    String? description,
    String? statesJson,
  }) => AvatarDefinition(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    statesJson: statesJson ?? this.statesJson,
  );
  AvatarDefinition copyWithCompanion(AvatarDefinitionsCompanion data) {
    return AvatarDefinition(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      statesJson: data.statesJson.present
          ? data.statesJson.value
          : this.statesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvatarDefinition(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('statesJson: $statesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, statesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvatarDefinition &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.statesJson == this.statesJson);
}

class AvatarDefinitionsCompanion extends UpdateCompanion<AvatarDefinition> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> statesJson;
  final Value<int> rowid;
  const AvatarDefinitionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.statesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AvatarDefinitionsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String statesJson,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       statesJson = Value(statesJson);
  static Insertable<AvatarDefinition> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? statesJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (statesJson != null) 'states_json': statesJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AvatarDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? statesJson,
    Value<int>? rowid,
  }) {
    return AvatarDefinitionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      statesJson: statesJson ?? this.statesJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (statesJson.present) {
      map['states_json'] = Variable<String>(statesJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvatarDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('statesJson: $statesJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AvatarItemsTable extends AvatarItems
    with TableInfo<$AvatarItemsTable, AvatarItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvatarItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarIdMeta = const VerificationMeta(
    'avatarId',
  );
  @override
  late final GeneratedColumn<String> avatarId = GeneratedColumn<String>(
    'avatar_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, avatarId, kind, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'avatar_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvatarItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('avatar_id')) {
      context.handle(
        _avatarIdMeta,
        avatarId.isAcceptableOrUnknown(data['avatar_id']!, _avatarIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvatarItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvatarItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      avatarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $AvatarItemsTable createAlias(String alias) {
    return $AvatarItemsTable(attachedDatabase, alias);
  }
}

class AvatarItem extends DataClass implements Insertable<AvatarItem> {
  final String id;
  final String? avatarId;
  final String kind;
  final String name;
  const AvatarItem({
    required this.id,
    this.avatarId,
    required this.kind,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || avatarId != null) {
      map['avatar_id'] = Variable<String>(avatarId);
    }
    map['kind'] = Variable<String>(kind);
    map['name'] = Variable<String>(name);
    return map;
  }

  AvatarItemsCompanion toCompanion(bool nullToAbsent) {
    return AvatarItemsCompanion(
      id: Value(id),
      avatarId: avatarId == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarId),
      kind: Value(kind),
      name: Value(name),
    );
  }

  factory AvatarItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvatarItem(
      id: serializer.fromJson<String>(json['id']),
      avatarId: serializer.fromJson<String?>(json['avatarId']),
      kind: serializer.fromJson<String>(json['kind']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'avatarId': serializer.toJson<String?>(avatarId),
      'kind': serializer.toJson<String>(kind),
      'name': serializer.toJson<String>(name),
    };
  }

  AvatarItem copyWith({
    String? id,
    Value<String?> avatarId = const Value.absent(),
    String? kind,
    String? name,
  }) => AvatarItem(
    id: id ?? this.id,
    avatarId: avatarId.present ? avatarId.value : this.avatarId,
    kind: kind ?? this.kind,
    name: name ?? this.name,
  );
  AvatarItem copyWithCompanion(AvatarItemsCompanion data) {
    return AvatarItem(
      id: data.id.present ? data.id.value : this.id,
      avatarId: data.avatarId.present ? data.avatarId.value : this.avatarId,
      kind: data.kind.present ? data.kind.value : this.kind,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvatarItem(')
          ..write('id: $id, ')
          ..write('avatarId: $avatarId, ')
          ..write('kind: $kind, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, avatarId, kind, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvatarItem &&
          other.id == this.id &&
          other.avatarId == this.avatarId &&
          other.kind == this.kind &&
          other.name == this.name);
}

class AvatarItemsCompanion extends UpdateCompanion<AvatarItem> {
  final Value<String> id;
  final Value<String?> avatarId;
  final Value<String> kind;
  final Value<String> name;
  final Value<int> rowid;
  const AvatarItemsCompanion({
    this.id = const Value.absent(),
    this.avatarId = const Value.absent(),
    this.kind = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AvatarItemsCompanion.insert({
    required String id,
    this.avatarId = const Value.absent(),
    required String kind,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       name = Value(name);
  static Insertable<AvatarItem> custom({
    Expression<String>? id,
    Expression<String>? avatarId,
    Expression<String>? kind,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (avatarId != null) 'avatar_id': avatarId,
      if (kind != null) 'kind': kind,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AvatarItemsCompanion copyWith({
    Value<String>? id,
    Value<String?>? avatarId,
    Value<String>? kind,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return AvatarItemsCompanion(
      id: id ?? this.id,
      avatarId: avatarId ?? this.avatarId,
      kind: kind ?? this.kind,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (avatarId.present) {
      map['avatar_id'] = Variable<String>(avatarId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvatarItemsCompanion(')
          ..write('id: $id, ')
          ..write('avatarId: $avatarId, ')
          ..write('kind: $kind, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AvatarUnlocksTable extends AvatarUnlocks
    with TableInfo<$AvatarUnlocksTable, AvatarUnlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvatarUnlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceEventIdMeta = const VerificationMeta(
    'sourceEventId',
  );
  @override
  late final GeneratedColumn<String> sourceEventId = GeneratedColumn<String>(
    'source_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, itemId, unlockedAt, sourceEventId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'avatar_unlocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvatarUnlock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    if (data.containsKey('source_event_id')) {
      context.handle(
        _sourceEventIdMeta,
        sourceEventId.isAcceptableOrUnknown(
          data['source_event_id']!,
          _sourceEventIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {itemId},
  ];
  @override
  AvatarUnlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvatarUnlock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
      sourceEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_event_id'],
      ),
    );
  }

  @override
  $AvatarUnlocksTable createAlias(String alias) {
    return $AvatarUnlocksTable(attachedDatabase, alias);
  }
}

class AvatarUnlock extends DataClass implements Insertable<AvatarUnlock> {
  final int id;
  final String itemId;
  final DateTime unlockedAt;
  final String? sourceEventId;
  const AvatarUnlock({
    required this.id,
    required this.itemId,
    required this.unlockedAt,
    this.sourceEventId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<String>(itemId);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    if (!nullToAbsent || sourceEventId != null) {
      map['source_event_id'] = Variable<String>(sourceEventId);
    }
    return map;
  }

  AvatarUnlocksCompanion toCompanion(bool nullToAbsent) {
    return AvatarUnlocksCompanion(
      id: Value(id),
      itemId: Value(itemId),
      unlockedAt: Value(unlockedAt),
      sourceEventId: sourceEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceEventId),
    );
  }

  factory AvatarUnlock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvatarUnlock(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
      sourceEventId: serializer.fromJson<String?>(json['sourceEventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<String>(itemId),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
      'sourceEventId': serializer.toJson<String?>(sourceEventId),
    };
  }

  AvatarUnlock copyWith({
    int? id,
    String? itemId,
    DateTime? unlockedAt,
    Value<String?> sourceEventId = const Value.absent(),
  }) => AvatarUnlock(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    unlockedAt: unlockedAt ?? this.unlockedAt,
    sourceEventId: sourceEventId.present
        ? sourceEventId.value
        : this.sourceEventId,
  );
  AvatarUnlock copyWithCompanion(AvatarUnlocksCompanion data) {
    return AvatarUnlock(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
      sourceEventId: data.sourceEventId.present
          ? data.sourceEventId.value
          : this.sourceEventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvatarUnlock(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('sourceEventId: $sourceEventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, unlockedAt, sourceEventId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvatarUnlock &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.unlockedAt == this.unlockedAt &&
          other.sourceEventId == this.sourceEventId);
}

class AvatarUnlocksCompanion extends UpdateCompanion<AvatarUnlock> {
  final Value<int> id;
  final Value<String> itemId;
  final Value<DateTime> unlockedAt;
  final Value<String?> sourceEventId;
  const AvatarUnlocksCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.sourceEventId = const Value.absent(),
  });
  AvatarUnlocksCompanion.insert({
    this.id = const Value.absent(),
    required String itemId,
    required DateTime unlockedAt,
    this.sourceEventId = const Value.absent(),
  }) : itemId = Value(itemId),
       unlockedAt = Value(unlockedAt);
  static Insertable<AvatarUnlock> custom({
    Expression<int>? id,
    Expression<String>? itemId,
    Expression<DateTime>? unlockedAt,
    Expression<String>? sourceEventId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (sourceEventId != null) 'source_event_id': sourceEventId,
    });
  }

  AvatarUnlocksCompanion copyWith({
    Value<int>? id,
    Value<String>? itemId,
    Value<DateTime>? unlockedAt,
    Value<String?>? sourceEventId,
  }) {
    return AvatarUnlocksCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      sourceEventId: sourceEventId ?? this.sourceEventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (sourceEventId.present) {
      map['source_event_id'] = Variable<String>(sourceEventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvatarUnlocksCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('sourceEventId: $sourceEventId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MetaEntriesTable metaEntries = $MetaEntriesTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $HealthCautionPreferencesTable healthCautionPreferences =
      $HealthCautionPreferencesTable(this);
  late final $ReminderSchedulesTable reminderSchedules =
      $ReminderSchedulesTable(this);
  late final $ExerciseCategoriesTable exerciseCategories =
      $ExerciseCategoriesTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseVariantsTable exerciseVariants = $ExerciseVariantsTable(
    this,
  );
  late final $ExerciseMediaTable exerciseMedia = $ExerciseMediaTable(this);
  late final $FormCuesTable formCues = $FormCuesTable(this);
  late final $ProgramsTable programs = $ProgramsTable(this);
  late final $ProgramWeeksTable programWeeks = $ProgramWeeksTable(this);
  late final $WorkoutTemplatesTable workoutTemplates = $WorkoutTemplatesTable(
    this,
  );
  late final $WorkoutTemplateItemsTable workoutTemplateItems =
      $WorkoutTemplateItemsTable(this);
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $HoldAttemptsTable holdAttempts = $HoldAttemptsTable(this);
  late final $SessionFeedbackTable sessionFeedback = $SessionFeedbackTable(
    this,
  );
  late final $PersonalBestsTable personalBests = $PersonalBestsTable(this);
  late final $ProgressSnapshotsTable progressSnapshots =
      $ProgressSnapshotsTable(this);
  late final $XpEventsTable xpEvents = $XpEventsTable(this);
  late final $UserLevelsTable userLevels = $UserLevelsTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $AchievementProgressTable achievementProgress =
      $AchievementProgressTable(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $ChallengeProgressTable challengeProgress =
      $ChallengeProgressTable(this);
  late final $AvatarDefinitionsTable avatarDefinitions =
      $AvatarDefinitionsTable(this);
  late final $AvatarItemsTable avatarItems = $AvatarItemsTable(this);
  late final $AvatarUnlocksTable avatarUnlocks = $AvatarUnlocksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    metaEntries,
    userProfiles,
    userPreferences,
    healthCautionPreferences,
    reminderSchedules,
    exerciseCategories,
    exercises,
    exerciseVariants,
    exerciseMedia,
    formCues,
    programs,
    programWeeks,
    workoutTemplates,
    workoutTemplateItems,
    workoutSessions,
    holdAttempts,
    sessionFeedback,
    personalBests,
    progressSnapshots,
    xpEvents,
    userLevels,
    achievements,
    achievementProgress,
    challenges,
    challengeProgress,
    avatarDefinitions,
    avatarItems,
    avatarUnlocks,
  ];
}

typedef $$MetaEntriesTableCreateCompanionBuilder =
    MetaEntriesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$MetaEntriesTableUpdateCompanionBuilder =
    MetaEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$MetaEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetaEntriesTable> {
  $$MetaEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MetaEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetaEntriesTable,
          MetaEntry,
          $$MetaEntriesTableFilterComposer,
          $$MetaEntriesTableOrderingComposer,
          $$MetaEntriesTableAnnotationComposer,
          $$MetaEntriesTableCreateCompanionBuilder,
          $$MetaEntriesTableUpdateCompanionBuilder,
          (
            MetaEntry,
            BaseReferences<_$AppDatabase, $MetaEntriesTable, MetaEntry>,
          ),
          MetaEntry,
          PrefetchHooks Function()
        > {
  $$MetaEntriesTableTableManager(_$AppDatabase db, $MetaEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaEntriesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => MetaEntriesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetaEntriesTable,
      MetaEntry,
      $$MetaEntriesTableFilterComposer,
      $$MetaEntriesTableOrderingComposer,
      $$MetaEntriesTableAnnotationComposer,
      $$MetaEntriesTableCreateCompanionBuilder,
      $$MetaEntriesTableUpdateCompanionBuilder,
      (MetaEntry, BaseReferences<_$AppDatabase, $MetaEntriesTable, MetaEntry>),
      MetaEntry,
      PrefetchHooks Function()
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String?> goal,
      Value<String> startingLevel,
      Value<int> preferredSessionMinutes,
      Value<int> weeklyWorkoutTarget,
      Value<String> selectedAvatarId,
      Value<bool> onboardingComplete,
      Value<int> onboardingStep,
      Value<bool> disclaimerAccepted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<String?> goal,
      Value<String> startingLevel,
      Value<int> preferredSessionMinutes,
      Value<int> weeklyWorkoutTarget,
      Value<String> selectedAvatarId,
      Value<bool> onboardingComplete,
      Value<int> onboardingStep,
      Value<bool> disclaimerAccepted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startingLevel => $composableBuilder(
    column: $table.startingLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredSessionMinutes => $composableBuilder(
    column: $table.preferredSessionMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyWorkoutTarget => $composableBuilder(
    column: $table.weeklyWorkoutTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedAvatarId => $composableBuilder(
    column: $table.selectedAvatarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get disclaimerAccepted => $composableBuilder(
    column: $table.disclaimerAccepted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startingLevel => $composableBuilder(
    column: $table.startingLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredSessionMinutes => $composableBuilder(
    column: $table.preferredSessionMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyWorkoutTarget => $composableBuilder(
    column: $table.weeklyWorkoutTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedAvatarId => $composableBuilder(
    column: $table.selectedAvatarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get disclaimerAccepted => $composableBuilder(
    column: $table.disclaimerAccepted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get startingLevel => $composableBuilder(
    column: $table.startingLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preferredSessionMinutes => $composableBuilder(
    column: $table.preferredSessionMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeklyWorkoutTarget => $composableBuilder(
    column: $table.weeklyWorkoutTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedAvatarId => $composableBuilder(
    column: $table.selectedAvatarId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<int> get onboardingStep => $composableBuilder(
    column: $table.onboardingStep,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get disclaimerAccepted => $composableBuilder(
    column: $table.disclaimerAccepted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String> startingLevel = const Value.absent(),
                Value<int> preferredSessionMinutes = const Value.absent(),
                Value<int> weeklyWorkoutTarget = const Value.absent(),
                Value<String> selectedAvatarId = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> onboardingStep = const Value.absent(),
                Value<bool> disclaimerAccepted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                displayName: displayName,
                goal: goal,
                startingLevel: startingLevel,
                preferredSessionMinutes: preferredSessionMinutes,
                weeklyWorkoutTarget: weeklyWorkoutTarget,
                selectedAvatarId: selectedAvatarId,
                onboardingComplete: onboardingComplete,
                onboardingStep: onboardingStep,
                disclaimerAccepted: disclaimerAccepted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String> startingLevel = const Value.absent(),
                Value<int> preferredSessionMinutes = const Value.absent(),
                Value<int> weeklyWorkoutTarget = const Value.absent(),
                Value<String> selectedAvatarId = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> onboardingStep = const Value.absent(),
                Value<bool> disclaimerAccepted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                goal: goal,
                startingLevel: startingLevel,
                preferredSessionMinutes: preferredSessionMinutes,
                weeklyWorkoutTarget: weeklyWorkoutTarget,
                selectedAvatarId: selectedAvatarId,
                onboardingComplete: onboardingComplete,
                onboardingStep: onboardingStep,
                disclaimerAccepted: disclaimerAccepted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<String> theme,
      Value<bool> audioEnabled,
      Value<bool> voiceEnabled,
      Value<bool> hapticsEnabled,
      Value<bool> reducedMotion,
      Value<DateTime> updatedAt,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<String> theme,
      Value<bool> audioEnabled,
      Value<bool> voiceEnabled,
      Value<bool> hapticsEnabled,
      Value<bool> reducedMotion,
      Value<DateTime> updatedAt,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
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

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get voiceEnabled => $composableBuilder(
    column: $table.voiceEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hapticsEnabled => $composableBuilder(
    column: $table.hapticsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
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

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get voiceEnabled => $composableBuilder(
    column: $table.voiceEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hapticsEnabled => $composableBuilder(
    column: $table.hapticsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get voiceEnabled => $composableBuilder(
    column: $table.voiceEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hapticsEnabled => $composableBuilder(
    column: $table.hapticsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreference,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreference
            >,
          ),
          UserPreference,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<bool> audioEnabled = const Value.absent(),
                Value<bool> voiceEnabled = const Value.absent(),
                Value<bool> hapticsEnabled = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesCompanion(
                id: id,
                theme: theme,
                audioEnabled: audioEnabled,
                voiceEnabled: voiceEnabled,
                hapticsEnabled: hapticsEnabled,
                reducedMotion: reducedMotion,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<bool> audioEnabled = const Value.absent(),
                Value<bool> voiceEnabled = const Value.absent(),
                Value<bool> hapticsEnabled = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                id: id,
                theme: theme,
                audioEnabled: audioEnabled,
                voiceEnabled: voiceEnabled,
                hapticsEnabled: hapticsEnabled,
                reducedMotion: reducedMotion,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreference,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>,
      ),
      UserPreference,
      PrefetchHooks Function()
    >;
typedef $$HealthCautionPreferencesTableCreateCompanionBuilder =
    HealthCautionPreferencesCompanion Function({
      Value<int> id,
      required String tag,
      Value<bool> selected,
    });
typedef $$HealthCautionPreferencesTableUpdateCompanionBuilder =
    HealthCautionPreferencesCompanion Function({
      Value<int> id,
      Value<String> tag,
      Value<bool> selected,
    });

class $$HealthCautionPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $HealthCautionPreferencesTable> {
  $$HealthCautionPreferencesTableFilterComposer({
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

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get selected => $composableBuilder(
    column: $table.selected,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthCautionPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthCautionPreferencesTable> {
  $$HealthCautionPreferencesTableOrderingComposer({
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

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get selected => $composableBuilder(
    column: $table.selected,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthCautionPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthCautionPreferencesTable> {
  $$HealthCautionPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<bool> get selected =>
      $composableBuilder(column: $table.selected, builder: (column) => column);
}

class $$HealthCautionPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthCautionPreferencesTable,
          HealthCautionPreference,
          $$HealthCautionPreferencesTableFilterComposer,
          $$HealthCautionPreferencesTableOrderingComposer,
          $$HealthCautionPreferencesTableAnnotationComposer,
          $$HealthCautionPreferencesTableCreateCompanionBuilder,
          $$HealthCautionPreferencesTableUpdateCompanionBuilder,
          (
            HealthCautionPreference,
            BaseReferences<
              _$AppDatabase,
              $HealthCautionPreferencesTable,
              HealthCautionPreference
            >,
          ),
          HealthCautionPreference,
          PrefetchHooks Function()
        > {
  $$HealthCautionPreferencesTableTableManager(
    _$AppDatabase db,
    $HealthCautionPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthCautionPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$HealthCautionPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HealthCautionPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tag = const Value.absent(),
                Value<bool> selected = const Value.absent(),
              }) => HealthCautionPreferencesCompanion(
                id: id,
                tag: tag,
                selected: selected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tag,
                Value<bool> selected = const Value.absent(),
              }) => HealthCautionPreferencesCompanion.insert(
                id: id,
                tag: tag,
                selected: selected,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthCautionPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthCautionPreferencesTable,
      HealthCautionPreference,
      $$HealthCautionPreferencesTableFilterComposer,
      $$HealthCautionPreferencesTableOrderingComposer,
      $$HealthCautionPreferencesTableAnnotationComposer,
      $$HealthCautionPreferencesTableCreateCompanionBuilder,
      $$HealthCautionPreferencesTableUpdateCompanionBuilder,
      (
        HealthCautionPreference,
        BaseReferences<
          _$AppDatabase,
          $HealthCautionPreferencesTable,
          HealthCautionPreference
        >,
      ),
      HealthCautionPreference,
      PrefetchHooks Function()
    >;
typedef $$ReminderSchedulesTableCreateCompanionBuilder =
    ReminderSchedulesCompanion Function({
      Value<int> id,
      Value<String> weekdaysCsv,
      Value<int> hour,
      Value<int> minute,
      Value<bool> enabled,
    });
typedef $$ReminderSchedulesTableUpdateCompanionBuilder =
    ReminderSchedulesCompanion Function({
      Value<int> id,
      Value<String> weekdaysCsv,
      Value<int> hour,
      Value<int> minute,
      Value<bool> enabled,
    });

class $$ReminderSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderSchedulesTable> {
  $$ReminderSchedulesTableFilterComposer({
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

  ColumnFilters<String> get weekdaysCsv => $composableBuilder(
    column: $table.weekdaysCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderSchedulesTable> {
  $$ReminderSchedulesTableOrderingComposer({
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

  ColumnOrderings<String> get weekdaysCsv => $composableBuilder(
    column: $table.weekdaysCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderSchedulesTable> {
  $$ReminderSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get weekdaysCsv => $composableBuilder(
    column: $table.weekdaysCsv,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$ReminderSchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderSchedulesTable,
          ReminderSchedule,
          $$ReminderSchedulesTableFilterComposer,
          $$ReminderSchedulesTableOrderingComposer,
          $$ReminderSchedulesTableAnnotationComposer,
          $$ReminderSchedulesTableCreateCompanionBuilder,
          $$ReminderSchedulesTableUpdateCompanionBuilder,
          (
            ReminderSchedule,
            BaseReferences<
              _$AppDatabase,
              $ReminderSchedulesTable,
              ReminderSchedule
            >,
          ),
          ReminderSchedule,
          PrefetchHooks Function()
        > {
  $$ReminderSchedulesTableTableManager(
    _$AppDatabase db,
    $ReminderSchedulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderSchedulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> weekdaysCsv = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => ReminderSchedulesCompanion(
                id: id,
                weekdaysCsv: weekdaysCsv,
                hour: hour,
                minute: minute,
                enabled: enabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> weekdaysCsv = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => ReminderSchedulesCompanion.insert(
                id: id,
                weekdaysCsv: weekdaysCsv,
                hour: hour,
                minute: minute,
                enabled: enabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderSchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderSchedulesTable,
      ReminderSchedule,
      $$ReminderSchedulesTableFilterComposer,
      $$ReminderSchedulesTableOrderingComposer,
      $$ReminderSchedulesTableAnnotationComposer,
      $$ReminderSchedulesTableCreateCompanionBuilder,
      $$ReminderSchedulesTableUpdateCompanionBuilder,
      (
        ReminderSchedule,
        BaseReferences<
          _$AppDatabase,
          $ReminderSchedulesTable,
          ReminderSchedule
        >,
      ),
      ReminderSchedule,
      PrefetchHooks Function()
    >;
typedef $$ExerciseCategoriesTableCreateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      required String id,
      required String name,
      required String colorHex,
      Value<int> rowid,
    });
typedef $$ExerciseCategoriesTableUpdateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> colorHex,
      Value<int> rowid,
    });

class $$ExerciseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);
}

class $$ExerciseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory,
          $$ExerciseCategoriesTableFilterComposer,
          $$ExerciseCategoriesTableOrderingComposer,
          $$ExerciseCategoriesTableAnnotationComposer,
          $$ExerciseCategoriesTableCreateCompanionBuilder,
          $$ExerciseCategoriesTableUpdateCompanionBuilder,
          (
            ExerciseCategory,
            BaseReferences<
              _$AppDatabase,
              $ExerciseCategoriesTable,
              ExerciseCategory
            >,
          ),
          ExerciseCategory,
          PrefetchHooks Function()
        > {
  $$ExerciseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExerciseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseCategoriesCompanion(
                id: id,
                name: name,
                colorHex: colorHex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String colorHex,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseCategoriesCompanion.insert(
                id: id,
                name: name,
                colorHex: colorHex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseCategoriesTable,
      ExerciseCategory,
      $$ExerciseCategoriesTableFilterComposer,
      $$ExerciseCategoriesTableOrderingComposer,
      $$ExerciseCategoriesTableAnnotationComposer,
      $$ExerciseCategoriesTableCreateCompanionBuilder,
      $$ExerciseCategoriesTableUpdateCompanionBuilder,
      (
        ExerciseCategory,
        BaseReferences<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory
        >,
      ),
      ExerciseCategory,
      PrefetchHooks Function()
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String categoryId,
      required String name,
      required String primaryMusclesJson,
      Value<String> secondaryMusclesJson,
      Value<int> contentVersion,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<String> name,
      Value<String> primaryMusclesJson,
      Value<String> secondaryMusclesJson,
      Value<int> contentVersion,
      Value<int> rowid,
    });

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
          Exercise,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> primaryMusclesJson = const Value.absent(),
                Value<String> secondaryMusclesJson = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                primaryMusclesJson: primaryMusclesJson,
                secondaryMusclesJson: secondaryMusclesJson,
                contentVersion: contentVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String name,
                required String primaryMusclesJson,
                Value<String> secondaryMusclesJson = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                primaryMusclesJson: primaryMusclesJson,
                secondaryMusclesJson: secondaryMusclesJson,
                contentVersion: contentVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
      Exercise,
      PrefetchHooks Function()
    >;
typedef $$ExerciseVariantsTableCreateCompanionBuilder =
    ExerciseVariantsCompanion Function({
      required String id,
      required String exerciseId,
      required String displayName,
      required int difficultyRank,
      required String categoryId,
      required String primaryMusclesJson,
      Value<String> secondaryMusclesJson,
      Value<String> equipmentJson,
      Value<String> unilateralMode,
      required int targetHoldMs,
      Value<int> setupDurationMs,
      Value<int> restDurationMs,
      Value<String?> easierVariantId,
      Value<String?> harderVariantId,
      Value<String> breathingCue,
      Value<String> commonMistakesJson,
      Value<String> safetyNotes,
      Value<String> limitationTagsJson,
      Value<String?> staticAssetId,
      Value<String?> animatedAssetId,
      Value<bool> gatedForBeginners,
      Value<String> reviewStatus,
      Value<int> contentVersion,
      Value<int> rowid,
    });
typedef $$ExerciseVariantsTableUpdateCompanionBuilder =
    ExerciseVariantsCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<String> displayName,
      Value<int> difficultyRank,
      Value<String> categoryId,
      Value<String> primaryMusclesJson,
      Value<String> secondaryMusclesJson,
      Value<String> equipmentJson,
      Value<String> unilateralMode,
      Value<int> targetHoldMs,
      Value<int> setupDurationMs,
      Value<int> restDurationMs,
      Value<String?> easierVariantId,
      Value<String?> harderVariantId,
      Value<String> breathingCue,
      Value<String> commonMistakesJson,
      Value<String> safetyNotes,
      Value<String> limitationTagsJson,
      Value<String?> staticAssetId,
      Value<String?> animatedAssetId,
      Value<bool> gatedForBeginners,
      Value<String> reviewStatus,
      Value<int> contentVersion,
      Value<int> rowid,
    });

class $$ExerciseVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseVariantsTable> {
  $$ExerciseVariantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficultyRank => $composableBuilder(
    column: $table.difficultyRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentJson => $composableBuilder(
    column: $table.equipmentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unilateralMode => $composableBuilder(
    column: $table.unilateralMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetHoldMs => $composableBuilder(
    column: $table.targetHoldMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setupDurationMs => $composableBuilder(
    column: $table.setupDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restDurationMs => $composableBuilder(
    column: $table.restDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get easierVariantId => $composableBuilder(
    column: $table.easierVariantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get harderVariantId => $composableBuilder(
    column: $table.harderVariantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breathingCue => $composableBuilder(
    column: $table.breathingCue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonMistakesJson => $composableBuilder(
    column: $table.commonMistakesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get limitationTagsJson => $composableBuilder(
    column: $table.limitationTagsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staticAssetId => $composableBuilder(
    column: $table.staticAssetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animatedAssetId => $composableBuilder(
    column: $table.animatedAssetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get gatedForBeginners => $composableBuilder(
    column: $table.gatedForBeginners,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseVariantsTable> {
  $$ExerciseVariantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficultyRank => $composableBuilder(
    column: $table.difficultyRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentJson => $composableBuilder(
    column: $table.equipmentJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unilateralMode => $composableBuilder(
    column: $table.unilateralMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetHoldMs => $composableBuilder(
    column: $table.targetHoldMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setupDurationMs => $composableBuilder(
    column: $table.setupDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restDurationMs => $composableBuilder(
    column: $table.restDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get easierVariantId => $composableBuilder(
    column: $table.easierVariantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get harderVariantId => $composableBuilder(
    column: $table.harderVariantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breathingCue => $composableBuilder(
    column: $table.breathingCue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonMistakesJson => $composableBuilder(
    column: $table.commonMistakesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get limitationTagsJson => $composableBuilder(
    column: $table.limitationTagsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staticAssetId => $composableBuilder(
    column: $table.staticAssetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animatedAssetId => $composableBuilder(
    column: $table.animatedAssetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get gatedForBeginners => $composableBuilder(
    column: $table.gatedForBeginners,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseVariantsTable> {
  $$ExerciseVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficultyRank => $composableBuilder(
    column: $table.difficultyRank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryMusclesJson => $composableBuilder(
    column: $table.primaryMusclesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMusclesJson => $composableBuilder(
    column: $table.secondaryMusclesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipmentJson => $composableBuilder(
    column: $table.equipmentJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unilateralMode => $composableBuilder(
    column: $table.unilateralMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetHoldMs => $composableBuilder(
    column: $table.targetHoldMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setupDurationMs => $composableBuilder(
    column: $table.setupDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restDurationMs => $composableBuilder(
    column: $table.restDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get easierVariantId => $composableBuilder(
    column: $table.easierVariantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get harderVariantId => $composableBuilder(
    column: $table.harderVariantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get breathingCue => $composableBuilder(
    column: $table.breathingCue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonMistakesJson => $composableBuilder(
    column: $table.commonMistakesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get safetyNotes => $composableBuilder(
    column: $table.safetyNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get limitationTagsJson => $composableBuilder(
    column: $table.limitationTagsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get staticAssetId => $composableBuilder(
    column: $table.staticAssetId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get animatedAssetId => $composableBuilder(
    column: $table.animatedAssetId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get gatedForBeginners => $composableBuilder(
    column: $table.gatedForBeginners,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );
}

class $$ExerciseVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseVariantsTable,
          ExerciseVariant,
          $$ExerciseVariantsTableFilterComposer,
          $$ExerciseVariantsTableOrderingComposer,
          $$ExerciseVariantsTableAnnotationComposer,
          $$ExerciseVariantsTableCreateCompanionBuilder,
          $$ExerciseVariantsTableUpdateCompanionBuilder,
          (
            ExerciseVariant,
            BaseReferences<
              _$AppDatabase,
              $ExerciseVariantsTable,
              ExerciseVariant
            >,
          ),
          ExerciseVariant,
          PrefetchHooks Function()
        > {
  $$ExerciseVariantsTableTableManager(
    _$AppDatabase db,
    $ExerciseVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseVariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseVariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> difficultyRank = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> primaryMusclesJson = const Value.absent(),
                Value<String> secondaryMusclesJson = const Value.absent(),
                Value<String> equipmentJson = const Value.absent(),
                Value<String> unilateralMode = const Value.absent(),
                Value<int> targetHoldMs = const Value.absent(),
                Value<int> setupDurationMs = const Value.absent(),
                Value<int> restDurationMs = const Value.absent(),
                Value<String?> easierVariantId = const Value.absent(),
                Value<String?> harderVariantId = const Value.absent(),
                Value<String> breathingCue = const Value.absent(),
                Value<String> commonMistakesJson = const Value.absent(),
                Value<String> safetyNotes = const Value.absent(),
                Value<String> limitationTagsJson = const Value.absent(),
                Value<String?> staticAssetId = const Value.absent(),
                Value<String?> animatedAssetId = const Value.absent(),
                Value<bool> gatedForBeginners = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseVariantsCompanion(
                id: id,
                exerciseId: exerciseId,
                displayName: displayName,
                difficultyRank: difficultyRank,
                categoryId: categoryId,
                primaryMusclesJson: primaryMusclesJson,
                secondaryMusclesJson: secondaryMusclesJson,
                equipmentJson: equipmentJson,
                unilateralMode: unilateralMode,
                targetHoldMs: targetHoldMs,
                setupDurationMs: setupDurationMs,
                restDurationMs: restDurationMs,
                easierVariantId: easierVariantId,
                harderVariantId: harderVariantId,
                breathingCue: breathingCue,
                commonMistakesJson: commonMistakesJson,
                safetyNotes: safetyNotes,
                limitationTagsJson: limitationTagsJson,
                staticAssetId: staticAssetId,
                animatedAssetId: animatedAssetId,
                gatedForBeginners: gatedForBeginners,
                reviewStatus: reviewStatus,
                contentVersion: contentVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required String displayName,
                required int difficultyRank,
                required String categoryId,
                required String primaryMusclesJson,
                Value<String> secondaryMusclesJson = const Value.absent(),
                Value<String> equipmentJson = const Value.absent(),
                Value<String> unilateralMode = const Value.absent(),
                required int targetHoldMs,
                Value<int> setupDurationMs = const Value.absent(),
                Value<int> restDurationMs = const Value.absent(),
                Value<String?> easierVariantId = const Value.absent(),
                Value<String?> harderVariantId = const Value.absent(),
                Value<String> breathingCue = const Value.absent(),
                Value<String> commonMistakesJson = const Value.absent(),
                Value<String> safetyNotes = const Value.absent(),
                Value<String> limitationTagsJson = const Value.absent(),
                Value<String?> staticAssetId = const Value.absent(),
                Value<String?> animatedAssetId = const Value.absent(),
                Value<bool> gatedForBeginners = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseVariantsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                displayName: displayName,
                difficultyRank: difficultyRank,
                categoryId: categoryId,
                primaryMusclesJson: primaryMusclesJson,
                secondaryMusclesJson: secondaryMusclesJson,
                equipmentJson: equipmentJson,
                unilateralMode: unilateralMode,
                targetHoldMs: targetHoldMs,
                setupDurationMs: setupDurationMs,
                restDurationMs: restDurationMs,
                easierVariantId: easierVariantId,
                harderVariantId: harderVariantId,
                breathingCue: breathingCue,
                commonMistakesJson: commonMistakesJson,
                safetyNotes: safetyNotes,
                limitationTagsJson: limitationTagsJson,
                staticAssetId: staticAssetId,
                animatedAssetId: animatedAssetId,
                gatedForBeginners: gatedForBeginners,
                reviewStatus: reviewStatus,
                contentVersion: contentVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseVariantsTable,
      ExerciseVariant,
      $$ExerciseVariantsTableFilterComposer,
      $$ExerciseVariantsTableOrderingComposer,
      $$ExerciseVariantsTableAnnotationComposer,
      $$ExerciseVariantsTableCreateCompanionBuilder,
      $$ExerciseVariantsTableUpdateCompanionBuilder,
      (
        ExerciseVariant,
        BaseReferences<_$AppDatabase, $ExerciseVariantsTable, ExerciseVariant>,
      ),
      ExerciseVariant,
      PrefetchHooks Function()
    >;
typedef $$ExerciseMediaTableCreateCompanionBuilder =
    ExerciseMediaCompanion Function({
      required String id,
      Value<String?> variantId,
      required String kind,
      required String assetPath,
      required String accessibilityLabel,
      Value<int> rowid,
    });
typedef $$ExerciseMediaTableUpdateCompanionBuilder =
    ExerciseMediaCompanion Function({
      Value<String> id,
      Value<String?> variantId,
      Value<String> kind,
      Value<String> assetPath,
      Value<String> accessibilityLabel,
      Value<int> rowid,
    });

class $$ExerciseMediaTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseMediaTable> {
  $$ExerciseMediaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessibilityLabel => $composableBuilder(
    column: $table.accessibilityLabel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseMediaTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseMediaTable> {
  $$ExerciseMediaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessibilityLabel => $composableBuilder(
    column: $table.accessibilityLabel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseMediaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseMediaTable> {
  $$ExerciseMediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  GeneratedColumn<String> get accessibilityLabel => $composableBuilder(
    column: $table.accessibilityLabel,
    builder: (column) => column,
  );
}

class $$ExerciseMediaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseMediaTable,
          ExerciseMediaData,
          $$ExerciseMediaTableFilterComposer,
          $$ExerciseMediaTableOrderingComposer,
          $$ExerciseMediaTableAnnotationComposer,
          $$ExerciseMediaTableCreateCompanionBuilder,
          $$ExerciseMediaTableUpdateCompanionBuilder,
          (
            ExerciseMediaData,
            BaseReferences<
              _$AppDatabase,
              $ExerciseMediaTable,
              ExerciseMediaData
            >,
          ),
          ExerciseMediaData,
          PrefetchHooks Function()
        > {
  $$ExerciseMediaTableTableManager(_$AppDatabase db, $ExerciseMediaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseMediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseMediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseMediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> variantId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> assetPath = const Value.absent(),
                Value<String> accessibilityLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseMediaCompanion(
                id: id,
                variantId: variantId,
                kind: kind,
                assetPath: assetPath,
                accessibilityLabel: accessibilityLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> variantId = const Value.absent(),
                required String kind,
                required String assetPath,
                required String accessibilityLabel,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseMediaCompanion.insert(
                id: id,
                variantId: variantId,
                kind: kind,
                assetPath: assetPath,
                accessibilityLabel: accessibilityLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseMediaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseMediaTable,
      ExerciseMediaData,
      $$ExerciseMediaTableFilterComposer,
      $$ExerciseMediaTableOrderingComposer,
      $$ExerciseMediaTableAnnotationComposer,
      $$ExerciseMediaTableCreateCompanionBuilder,
      $$ExerciseMediaTableUpdateCompanionBuilder,
      (
        ExerciseMediaData,
        BaseReferences<_$AppDatabase, $ExerciseMediaTable, ExerciseMediaData>,
      ),
      ExerciseMediaData,
      PrefetchHooks Function()
    >;
typedef $$FormCuesTableCreateCompanionBuilder =
    FormCuesCompanion Function({
      Value<int> id,
      required String variantId,
      Value<int> sortOrder,
      required String cue,
    });
typedef $$FormCuesTableUpdateCompanionBuilder =
    FormCuesCompanion Function({
      Value<int> id,
      Value<String> variantId,
      Value<int> sortOrder,
      Value<String> cue,
    });

class $$FormCuesTableFilterComposer
    extends Composer<_$AppDatabase, $FormCuesTable> {
  $$FormCuesTableFilterComposer({
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

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cue => $composableBuilder(
    column: $table.cue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FormCuesTableOrderingComposer
    extends Composer<_$AppDatabase, $FormCuesTable> {
  $$FormCuesTableOrderingComposer({
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

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cue => $composableBuilder(
    column: $table.cue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FormCuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormCuesTable> {
  $$FormCuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get cue =>
      $composableBuilder(column: $table.cue, builder: (column) => column);
}

class $$FormCuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FormCuesTable,
          FormCue,
          $$FormCuesTableFilterComposer,
          $$FormCuesTableOrderingComposer,
          $$FormCuesTableAnnotationComposer,
          $$FormCuesTableCreateCompanionBuilder,
          $$FormCuesTableUpdateCompanionBuilder,
          (FormCue, BaseReferences<_$AppDatabase, $FormCuesTable, FormCue>),
          FormCue,
          PrefetchHooks Function()
        > {
  $$FormCuesTableTableManager(_$AppDatabase db, $FormCuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormCuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormCuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormCuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> cue = const Value.absent(),
              }) => FormCuesCompanion(
                id: id,
                variantId: variantId,
                sortOrder: sortOrder,
                cue: cue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String variantId,
                Value<int> sortOrder = const Value.absent(),
                required String cue,
              }) => FormCuesCompanion.insert(
                id: id,
                variantId: variantId,
                sortOrder: sortOrder,
                cue: cue,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FormCuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FormCuesTable,
      FormCue,
      $$FormCuesTableFilterComposer,
      $$FormCuesTableOrderingComposer,
      $$FormCuesTableAnnotationComposer,
      $$FormCuesTableCreateCompanionBuilder,
      $$FormCuesTableUpdateCompanionBuilder,
      (FormCue, BaseReferences<_$AppDatabase, $FormCuesTable, FormCue>),
      FormCue,
      PrefetchHooks Function()
    >;
typedef $$ProgramsTableCreateCompanionBuilder =
    ProgramsCompanion Function({
      required String id,
      required String name,
      required String description,
      Value<int> weeks,
      Value<int> sessionsPerWeek,
      Value<int> estimatedMinutes,
      Value<int> rowid,
    });
typedef $$ProgramsTableUpdateCompanionBuilder =
    ProgramsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<int> weeks,
      Value<int> sessionsPerWeek,
      Value<int> estimatedMinutes,
      Value<int> rowid,
    });

class $$ProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  GeneratedColumn<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );
}

class $$ProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramsTable,
          Program,
          $$ProgramsTableFilterComposer,
          $$ProgramsTableOrderingComposer,
          $$ProgramsTableAnnotationComposer,
          $$ProgramsTableCreateCompanionBuilder,
          $$ProgramsTableUpdateCompanionBuilder,
          (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
          Program,
          PrefetchHooks Function()
        > {
  $$ProgramsTableTableManager(_$AppDatabase db, $ProgramsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> weeks = const Value.absent(),
                Value<int> sessionsPerWeek = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion(
                id: id,
                name: name,
                description: description,
                weeks: weeks,
                sessionsPerWeek: sessionsPerWeek,
                estimatedMinutes: estimatedMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                Value<int> weeks = const Value.absent(),
                Value<int> sessionsPerWeek = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion.insert(
                id: id,
                name: name,
                description: description,
                weeks: weeks,
                sessionsPerWeek: sessionsPerWeek,
                estimatedMinutes: estimatedMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramsTable,
      Program,
      $$ProgramsTableFilterComposer,
      $$ProgramsTableOrderingComposer,
      $$ProgramsTableAnnotationComposer,
      $$ProgramsTableCreateCompanionBuilder,
      $$ProgramsTableUpdateCompanionBuilder,
      (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
      Program,
      PrefetchHooks Function()
    >;
typedef $$ProgramWeeksTableCreateCompanionBuilder =
    ProgramWeeksCompanion Function({
      required String id,
      required String programId,
      required int weekNumber,
      Value<String> focus,
      Value<int> rowid,
    });
typedef $$ProgramWeeksTableUpdateCompanionBuilder =
    ProgramWeeksCompanion Function({
      Value<String> id,
      Value<String> programId,
      Value<int> weekNumber,
      Value<String> focus,
      Value<int> rowid,
    });

class $$ProgramWeeksTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramWeeksTable> {
  $$ProgramWeeksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgramWeeksTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramWeeksTable> {
  $$ProgramWeeksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramWeeksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramWeeksTable> {
  $$ProgramWeeksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get focus =>
      $composableBuilder(column: $table.focus, builder: (column) => column);
}

class $$ProgramWeeksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramWeeksTable,
          ProgramWeek,
          $$ProgramWeeksTableFilterComposer,
          $$ProgramWeeksTableOrderingComposer,
          $$ProgramWeeksTableAnnotationComposer,
          $$ProgramWeeksTableCreateCompanionBuilder,
          $$ProgramWeeksTableUpdateCompanionBuilder,
          (
            ProgramWeek,
            BaseReferences<_$AppDatabase, $ProgramWeeksTable, ProgramWeek>,
          ),
          ProgramWeek,
          PrefetchHooks Function()
        > {
  $$ProgramWeeksTableTableManager(_$AppDatabase db, $ProgramWeeksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramWeeksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramWeeksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramWeeksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> programId = const Value.absent(),
                Value<int> weekNumber = const Value.absent(),
                Value<String> focus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramWeeksCompanion(
                id: id,
                programId: programId,
                weekNumber: weekNumber,
                focus: focus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String programId,
                required int weekNumber,
                Value<String> focus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramWeeksCompanion.insert(
                id: id,
                programId: programId,
                weekNumber: weekNumber,
                focus: focus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgramWeeksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramWeeksTable,
      ProgramWeek,
      $$ProgramWeeksTableFilterComposer,
      $$ProgramWeeksTableOrderingComposer,
      $$ProgramWeeksTableAnnotationComposer,
      $$ProgramWeeksTableCreateCompanionBuilder,
      $$ProgramWeeksTableUpdateCompanionBuilder,
      (
        ProgramWeek,
        BaseReferences<_$AppDatabase, $ProgramWeeksTable, ProgramWeek>,
      ),
      ProgramWeek,
      PrefetchHooks Function()
    >;
typedef $$WorkoutTemplatesTableCreateCompanionBuilder =
    WorkoutTemplatesCompanion Function({
      required String id,
      Value<String?> programId,
      Value<String?> programWeekId,
      required String name,
      Value<int> estimatedMinutes,
      Value<bool> isQuickStart,
      Value<bool> isDefaultRecommended,
      Value<int> rowid,
    });
typedef $$WorkoutTemplatesTableUpdateCompanionBuilder =
    WorkoutTemplatesCompanion Function({
      Value<String> id,
      Value<String?> programId,
      Value<String?> programWeekId,
      Value<String> name,
      Value<int> estimatedMinutes,
      Value<bool> isQuickStart,
      Value<bool> isDefaultRecommended,
      Value<int> rowid,
    });

class $$WorkoutTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programWeekId => $composableBuilder(
    column: $table.programWeekId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isQuickStart => $composableBuilder(
    column: $table.isQuickStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefaultRecommended => $composableBuilder(
    column: $table.isDefaultRecommended,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programWeekId => $composableBuilder(
    column: $table.programWeekId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isQuickStart => $composableBuilder(
    column: $table.isQuickStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefaultRecommended => $composableBuilder(
    column: $table.isDefaultRecommended,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTable> {
  $$WorkoutTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<String> get programWeekId => $composableBuilder(
    column: $table.programWeekId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isQuickStart => $composableBuilder(
    column: $table.isQuickStart,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefaultRecommended => $composableBuilder(
    column: $table.isDefaultRecommended,
    builder: (column) => column,
  );
}

class $$WorkoutTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutTemplatesTable,
          WorkoutTemplate,
          $$WorkoutTemplatesTableFilterComposer,
          $$WorkoutTemplatesTableOrderingComposer,
          $$WorkoutTemplatesTableAnnotationComposer,
          $$WorkoutTemplatesTableCreateCompanionBuilder,
          $$WorkoutTemplatesTableUpdateCompanionBuilder,
          (
            WorkoutTemplate,
            BaseReferences<
              _$AppDatabase,
              $WorkoutTemplatesTable,
              WorkoutTemplate
            >,
          ),
          WorkoutTemplate,
          PrefetchHooks Function()
        > {
  $$WorkoutTemplatesTableTableManager(
    _$AppDatabase db,
    $WorkoutTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> programId = const Value.absent(),
                Value<String?> programWeekId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> isQuickStart = const Value.absent(),
                Value<bool> isDefaultRecommended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplatesCompanion(
                id: id,
                programId: programId,
                programWeekId: programWeekId,
                name: name,
                estimatedMinutes: estimatedMinutes,
                isQuickStart: isQuickStart,
                isDefaultRecommended: isDefaultRecommended,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> programId = const Value.absent(),
                Value<String?> programWeekId = const Value.absent(),
                required String name,
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> isQuickStart = const Value.absent(),
                Value<bool> isDefaultRecommended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplatesCompanion.insert(
                id: id,
                programId: programId,
                programWeekId: programWeekId,
                name: name,
                estimatedMinutes: estimatedMinutes,
                isQuickStart: isQuickStart,
                isDefaultRecommended: isDefaultRecommended,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutTemplatesTable,
      WorkoutTemplate,
      $$WorkoutTemplatesTableFilterComposer,
      $$WorkoutTemplatesTableOrderingComposer,
      $$WorkoutTemplatesTableAnnotationComposer,
      $$WorkoutTemplatesTableCreateCompanionBuilder,
      $$WorkoutTemplatesTableUpdateCompanionBuilder,
      (
        WorkoutTemplate,
        BaseReferences<_$AppDatabase, $WorkoutTemplatesTable, WorkoutTemplate>,
      ),
      WorkoutTemplate,
      PrefetchHooks Function()
    >;
typedef $$WorkoutTemplateItemsTableCreateCompanionBuilder =
    WorkoutTemplateItemsCompanion Function({
      Value<int> id,
      required String templateId,
      required int sortOrder,
      Value<String?> variantId,
      Value<String> itemType,
      Value<String> label,
      Value<int> durationMs,
    });
typedef $$WorkoutTemplateItemsTableUpdateCompanionBuilder =
    WorkoutTemplateItemsCompanion Function({
      Value<int> id,
      Value<String> templateId,
      Value<int> sortOrder,
      Value<String?> variantId,
      Value<String> itemType,
      Value<String> label,
      Value<int> durationMs,
    });

class $$WorkoutTemplateItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTable> {
  $$WorkoutTemplateItemsTableFilterComposer({
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

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutTemplateItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTable> {
  $$WorkoutTemplateItemsTableOrderingComposer({
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

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutTemplateItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTable> {
  $$WorkoutTemplateItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );
}

class $$WorkoutTemplateItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutTemplateItemsTable,
          WorkoutTemplateItem,
          $$WorkoutTemplateItemsTableFilterComposer,
          $$WorkoutTemplateItemsTableOrderingComposer,
          $$WorkoutTemplateItemsTableAnnotationComposer,
          $$WorkoutTemplateItemsTableCreateCompanionBuilder,
          $$WorkoutTemplateItemsTableUpdateCompanionBuilder,
          (
            WorkoutTemplateItem,
            BaseReferences<
              _$AppDatabase,
              $WorkoutTemplateItemsTable,
              WorkoutTemplateItem
            >,
          ),
          WorkoutTemplateItem,
          PrefetchHooks Function()
        > {
  $$WorkoutTemplateItemsTableTableManager(
    _$AppDatabase db,
    $WorkoutTemplateItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplateItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutTemplateItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutTemplateItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> variantId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
              }) => WorkoutTemplateItemsCompanion(
                id: id,
                templateId: templateId,
                sortOrder: sortOrder,
                variantId: variantId,
                itemType: itemType,
                label: label,
                durationMs: durationMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String templateId,
                required int sortOrder,
                Value<String?> variantId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
              }) => WorkoutTemplateItemsCompanion.insert(
                id: id,
                templateId: templateId,
                sortOrder: sortOrder,
                variantId: variantId,
                itemType: itemType,
                label: label,
                durationMs: durationMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutTemplateItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutTemplateItemsTable,
      WorkoutTemplateItem,
      $$WorkoutTemplateItemsTableFilterComposer,
      $$WorkoutTemplateItemsTableOrderingComposer,
      $$WorkoutTemplateItemsTableAnnotationComposer,
      $$WorkoutTemplateItemsTableCreateCompanionBuilder,
      $$WorkoutTemplateItemsTableUpdateCompanionBuilder,
      (
        WorkoutTemplateItem,
        BaseReferences<
          _$AppDatabase,
          $WorkoutTemplateItemsTable,
          WorkoutTemplateItem
        >,
      ),
      WorkoutTemplateItem,
      PrefetchHooks Function()
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required String status,
      Value<String?> templateId,
      Value<String?> programId,
      Value<int> plannedDurationMs,
      Value<int> actualDurationMs,
      Value<int> completedExerciseCount,
      Value<int> skippedExerciseCount,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      Value<String?> note,
      Value<String?> recoveryJson,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<String?> templateId,
      Value<String?> programId,
      Value<int> plannedDurationMs,
      Value<int> actualDurationMs,
      Value<int> completedExerciseCount,
      Value<int> skippedExerciseCount,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      Value<String?> note,
      Value<String?> recoveryJson,
      Value<int> rowid,
    });

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedDurationMs => $composableBuilder(
    column: $table.plannedDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationMs => $composableBuilder(
    column: $table.actualDurationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedExerciseCount => $composableBuilder(
    column: $table.completedExerciseCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skippedExerciseCount => $composableBuilder(
    column: $table.skippedExerciseCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryJson => $composableBuilder(
    column: $table.recoveryJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedDurationMs => $composableBuilder(
    column: $table.plannedDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationMs => $composableBuilder(
    column: $table.actualDurationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedExerciseCount => $composableBuilder(
    column: $table.completedExerciseCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skippedExerciseCount => $composableBuilder(
    column: $table.skippedExerciseCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryJson => $composableBuilder(
    column: $table.recoveryJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<int> get plannedDurationMs => $composableBuilder(
    column: $table.plannedDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationMs => $composableBuilder(
    column: $table.actualDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedExerciseCount => $composableBuilder(
    column: $table.completedExerciseCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skippedExerciseCount => $composableBuilder(
    column: $table.skippedExerciseCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get painFlag =>
      $composableBuilder(column: $table.painFlag, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get recoveryJson => $composableBuilder(
    column: $table.recoveryJson,
    builder: (column) => column,
  );
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (
            WorkoutSession,
            BaseReferences<
              _$AppDatabase,
              $WorkoutSessionsTable,
              WorkoutSession
            >,
          ),
          WorkoutSession,
          PrefetchHooks Function()
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<String?> programId = const Value.absent(),
                Value<int> plannedDurationMs = const Value.absent(),
                Value<int> actualDurationMs = const Value.absent(),
                Value<int> completedExerciseCount = const Value.absent(),
                Value<int> skippedExerciseCount = const Value.absent(),
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> recoveryJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                templateId: templateId,
                programId: programId,
                plannedDurationMs: plannedDurationMs,
                actualDurationMs: actualDurationMs,
                completedExerciseCount: completedExerciseCount,
                skippedExerciseCount: skippedExerciseCount,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                note: note,
                recoveryJson: recoveryJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String status,
                Value<String?> templateId = const Value.absent(),
                Value<String?> programId = const Value.absent(),
                Value<int> plannedDurationMs = const Value.absent(),
                Value<int> actualDurationMs = const Value.absent(),
                Value<int> completedExerciseCount = const Value.absent(),
                Value<int> skippedExerciseCount = const Value.absent(),
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> recoveryJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                templateId: templateId,
                programId: programId,
                plannedDurationMs: plannedDurationMs,
                actualDurationMs: actualDurationMs,
                completedExerciseCount: completedExerciseCount,
                skippedExerciseCount: skippedExerciseCount,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                note: note,
                recoveryJson: recoveryJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (
        WorkoutSession,
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>,
      ),
      WorkoutSession,
      PrefetchHooks Function()
    >;
typedef $$HoldAttemptsTableCreateCompanionBuilder =
    HoldAttemptsCompanion Function({
      required String id,
      required String sessionId,
      required String exerciseId,
      required String variantId,
      Value<String> side,
      Value<int> setNumber,
      required int targetMs,
      required int completedMs,
      Value<int> preparationMs,
      Value<int> restMs,
      Value<int> pauseMs,
      required String result,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      required DateTime startedAt,
      required DateTime endedAt,
      Value<int> rowid,
    });
typedef $$HoldAttemptsTableUpdateCompanionBuilder =
    HoldAttemptsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> exerciseId,
      Value<String> variantId,
      Value<String> side,
      Value<int> setNumber,
      Value<int> targetMs,
      Value<int> completedMs,
      Value<int> preparationMs,
      Value<int> restMs,
      Value<int> pauseMs,
      Value<String> result,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<int> rowid,
    });

class $$HoldAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $HoldAttemptsTable> {
  $$HoldAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMs => $composableBuilder(
    column: $table.targetMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedMs => $composableBuilder(
    column: $table.completedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preparationMs => $composableBuilder(
    column: $table.preparationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restMs => $composableBuilder(
    column: $table.restMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pauseMs => $composableBuilder(
    column: $table.pauseMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HoldAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $HoldAttemptsTable> {
  $$HoldAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMs => $composableBuilder(
    column: $table.targetMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedMs => $composableBuilder(
    column: $table.completedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preparationMs => $composableBuilder(
    column: $table.preparationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restMs => $composableBuilder(
    column: $table.restMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pauseMs => $composableBuilder(
    column: $table.pauseMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HoldAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HoldAttemptsTable> {
  $$HoldAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get targetMs =>
      $composableBuilder(column: $table.targetMs, builder: (column) => column);

  GeneratedColumn<int> get completedMs => $composableBuilder(
    column: $table.completedMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preparationMs => $composableBuilder(
    column: $table.preparationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restMs =>
      $composableBuilder(column: $table.restMs, builder: (column) => column);

  GeneratedColumn<int> get pauseMs =>
      $composableBuilder(column: $table.pauseMs, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get painFlag =>
      $composableBuilder(column: $table.painFlag, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);
}

class $$HoldAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HoldAttemptsTable,
          HoldAttempt,
          $$HoldAttemptsTableFilterComposer,
          $$HoldAttemptsTableOrderingComposer,
          $$HoldAttemptsTableAnnotationComposer,
          $$HoldAttemptsTableCreateCompanionBuilder,
          $$HoldAttemptsTableUpdateCompanionBuilder,
          (
            HoldAttempt,
            BaseReferences<_$AppDatabase, $HoldAttemptsTable, HoldAttempt>,
          ),
          HoldAttempt,
          PrefetchHooks Function()
        > {
  $$HoldAttemptsTableTableManager(_$AppDatabase db, $HoldAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HoldAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HoldAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HoldAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<String> side = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<int> targetMs = const Value.absent(),
                Value<int> completedMs = const Value.absent(),
                Value<int> preparationMs = const Value.absent(),
                Value<int> restMs = const Value.absent(),
                Value<int> pauseMs = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HoldAttemptsCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                variantId: variantId,
                side: side,
                setNumber: setNumber,
                targetMs: targetMs,
                completedMs: completedMs,
                preparationMs: preparationMs,
                restMs: restMs,
                pauseMs: pauseMs,
                result: result,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String exerciseId,
                required String variantId,
                Value<String> side = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                required int targetMs,
                required int completedMs,
                Value<int> preparationMs = const Value.absent(),
                Value<int> restMs = const Value.absent(),
                Value<int> pauseMs = const Value.absent(),
                required String result,
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                required DateTime startedAt,
                required DateTime endedAt,
                Value<int> rowid = const Value.absent(),
              }) => HoldAttemptsCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                variantId: variantId,
                side: side,
                setNumber: setNumber,
                targetMs: targetMs,
                completedMs: completedMs,
                preparationMs: preparationMs,
                restMs: restMs,
                pauseMs: pauseMs,
                result: result,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HoldAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HoldAttemptsTable,
      HoldAttempt,
      $$HoldAttemptsTableFilterComposer,
      $$HoldAttemptsTableOrderingComposer,
      $$HoldAttemptsTableAnnotationComposer,
      $$HoldAttemptsTableCreateCompanionBuilder,
      $$HoldAttemptsTableUpdateCompanionBuilder,
      (
        HoldAttempt,
        BaseReferences<_$AppDatabase, $HoldAttemptsTable, HoldAttempt>,
      ),
      HoldAttempt,
      PrefetchHooks Function()
    >;
typedef $$SessionFeedbackTableCreateCompanionBuilder =
    SessionFeedbackCompanion Function({
      Value<int> id,
      required String sessionId,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$SessionFeedbackTableUpdateCompanionBuilder =
    SessionFeedbackCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int?> perceivedEffort,
      Value<bool> painFlag,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

class $$SessionFeedbackTableFilterComposer
    extends Composer<_$AppDatabase, $SessionFeedbackTable> {
  $$SessionFeedbackTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionFeedbackTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionFeedbackTable> {
  $$SessionFeedbackTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get painFlag => $composableBuilder(
    column: $table.painFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionFeedbackTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionFeedbackTable> {
  $$SessionFeedbackTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get perceivedEffort => $composableBuilder(
    column: $table.perceivedEffort,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get painFlag =>
      $composableBuilder(column: $table.painFlag, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SessionFeedbackTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionFeedbackTable,
          SessionFeedbackData,
          $$SessionFeedbackTableFilterComposer,
          $$SessionFeedbackTableOrderingComposer,
          $$SessionFeedbackTableAnnotationComposer,
          $$SessionFeedbackTableCreateCompanionBuilder,
          $$SessionFeedbackTableUpdateCompanionBuilder,
          (
            SessionFeedbackData,
            BaseReferences<
              _$AppDatabase,
              $SessionFeedbackTable,
              SessionFeedbackData
            >,
          ),
          SessionFeedbackData,
          PrefetchHooks Function()
        > {
  $$SessionFeedbackTableTableManager(
    _$AppDatabase db,
    $SessionFeedbackTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionFeedbackTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionFeedbackTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionFeedbackTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SessionFeedbackCompanion(
                id: id,
                sessionId: sessionId,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                Value<int?> perceivedEffort = const Value.absent(),
                Value<bool> painFlag = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SessionFeedbackCompanion.insert(
                id: id,
                sessionId: sessionId,
                perceivedEffort: perceivedEffort,
                painFlag: painFlag,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionFeedbackTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionFeedbackTable,
      SessionFeedbackData,
      $$SessionFeedbackTableFilterComposer,
      $$SessionFeedbackTableOrderingComposer,
      $$SessionFeedbackTableAnnotationComposer,
      $$SessionFeedbackTableCreateCompanionBuilder,
      $$SessionFeedbackTableUpdateCompanionBuilder,
      (
        SessionFeedbackData,
        BaseReferences<
          _$AppDatabase,
          $SessionFeedbackTable,
          SessionFeedbackData
        >,
      ),
      SessionFeedbackData,
      PrefetchHooks Function()
    >;
typedef $$PersonalBestsTableCreateCompanionBuilder =
    PersonalBestsCompanion Function({
      Value<int> id,
      required String variantId,
      Value<String> side,
      required int bestMs,
      required DateTime achievedAt,
      Value<String?> sessionId,
    });
typedef $$PersonalBestsTableUpdateCompanionBuilder =
    PersonalBestsCompanion Function({
      Value<int> id,
      Value<String> variantId,
      Value<String> side,
      Value<int> bestMs,
      Value<DateTime> achievedAt,
      Value<String?> sessionId,
    });

class $$PersonalBestsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalBestsTable> {
  $$PersonalBestsTableFilterComposer({
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

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestMs => $composableBuilder(
    column: $table.bestMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalBestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalBestsTable> {
  $$PersonalBestsTableOrderingComposer({
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

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestMs => $composableBuilder(
    column: $table.bestMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalBestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalBestsTable> {
  $$PersonalBestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<int> get bestMs =>
      $composableBuilder(column: $table.bestMs, builder: (column) => column);

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);
}

class $$PersonalBestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalBestsTable,
          PersonalBest,
          $$PersonalBestsTableFilterComposer,
          $$PersonalBestsTableOrderingComposer,
          $$PersonalBestsTableAnnotationComposer,
          $$PersonalBestsTableCreateCompanionBuilder,
          $$PersonalBestsTableUpdateCompanionBuilder,
          (
            PersonalBest,
            BaseReferences<_$AppDatabase, $PersonalBestsTable, PersonalBest>,
          ),
          PersonalBest,
          PrefetchHooks Function()
        > {
  $$PersonalBestsTableTableManager(_$AppDatabase db, $PersonalBestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalBestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalBestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalBestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<String> side = const Value.absent(),
                Value<int> bestMs = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
              }) => PersonalBestsCompanion(
                id: id,
                variantId: variantId,
                side: side,
                bestMs: bestMs,
                achievedAt: achievedAt,
                sessionId: sessionId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String variantId,
                Value<String> side = const Value.absent(),
                required int bestMs,
                required DateTime achievedAt,
                Value<String?> sessionId = const Value.absent(),
              }) => PersonalBestsCompanion.insert(
                id: id,
                variantId: variantId,
                side: side,
                bestMs: bestMs,
                achievedAt: achievedAt,
                sessionId: sessionId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalBestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalBestsTable,
      PersonalBest,
      $$PersonalBestsTableFilterComposer,
      $$PersonalBestsTableOrderingComposer,
      $$PersonalBestsTableAnnotationComposer,
      $$PersonalBestsTableCreateCompanionBuilder,
      $$PersonalBestsTableUpdateCompanionBuilder,
      (
        PersonalBest,
        BaseReferences<_$AppDatabase, $PersonalBestsTable, PersonalBest>,
      ),
      PersonalBest,
      PrefetchHooks Function()
    >;
typedef $$ProgressSnapshotsTableCreateCompanionBuilder =
    ProgressSnapshotsCompanion Function({
      Value<int> id,
      required DateTime capturedAt,
      required int totalSessions,
      required int totalHoldMs,
      required int weekSessions,
      Value<String> payloadJson,
    });
typedef $$ProgressSnapshotsTableUpdateCompanionBuilder =
    ProgressSnapshotsCompanion Function({
      Value<int> id,
      Value<DateTime> capturedAt,
      Value<int> totalSessions,
      Value<int> totalHoldMs,
      Value<int> weekSessions,
      Value<String> payloadJson,
    });

class $$ProgressSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressSnapshotsTable> {
  $$ProgressSnapshotsTableFilterComposer({
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

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSessions => $composableBuilder(
    column: $table.totalSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalHoldMs => $composableBuilder(
    column: $table.totalHoldMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekSessions => $composableBuilder(
    column: $table.weekSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressSnapshotsTable> {
  $$ProgressSnapshotsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSessions => $composableBuilder(
    column: $table.totalSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalHoldMs => $composableBuilder(
    column: $table.totalHoldMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekSessions => $composableBuilder(
    column: $table.weekSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressSnapshotsTable> {
  $$ProgressSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSessions => $composableBuilder(
    column: $table.totalSessions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalHoldMs => $composableBuilder(
    column: $table.totalHoldMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekSessions => $composableBuilder(
    column: $table.weekSessions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );
}

class $$ProgressSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressSnapshotsTable,
          ProgressSnapshot,
          $$ProgressSnapshotsTableFilterComposer,
          $$ProgressSnapshotsTableOrderingComposer,
          $$ProgressSnapshotsTableAnnotationComposer,
          $$ProgressSnapshotsTableCreateCompanionBuilder,
          $$ProgressSnapshotsTableUpdateCompanionBuilder,
          (
            ProgressSnapshot,
            BaseReferences<
              _$AppDatabase,
              $ProgressSnapshotsTable,
              ProgressSnapshot
            >,
          ),
          ProgressSnapshot,
          PrefetchHooks Function()
        > {
  $$ProgressSnapshotsTableTableManager(
    _$AppDatabase db,
    $ProgressSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<int> totalSessions = const Value.absent(),
                Value<int> totalHoldMs = const Value.absent(),
                Value<int> weekSessions = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
              }) => ProgressSnapshotsCompanion(
                id: id,
                capturedAt: capturedAt,
                totalSessions: totalSessions,
                totalHoldMs: totalHoldMs,
                weekSessions: weekSessions,
                payloadJson: payloadJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime capturedAt,
                required int totalSessions,
                required int totalHoldMs,
                required int weekSessions,
                Value<String> payloadJson = const Value.absent(),
              }) => ProgressSnapshotsCompanion.insert(
                id: id,
                capturedAt: capturedAt,
                totalSessions: totalSessions,
                totalHoldMs: totalHoldMs,
                weekSessions: weekSessions,
                payloadJson: payloadJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressSnapshotsTable,
      ProgressSnapshot,
      $$ProgressSnapshotsTableFilterComposer,
      $$ProgressSnapshotsTableOrderingComposer,
      $$ProgressSnapshotsTableAnnotationComposer,
      $$ProgressSnapshotsTableCreateCompanionBuilder,
      $$ProgressSnapshotsTableUpdateCompanionBuilder,
      (
        ProgressSnapshot,
        BaseReferences<
          _$AppDatabase,
          $ProgressSnapshotsTable,
          ProgressSnapshot
        >,
      ),
      ProgressSnapshot,
      PrefetchHooks Function()
    >;
typedef $$XpEventsTableCreateCompanionBuilder =
    XpEventsCompanion Function({
      required String id,
      required String sourceType,
      required String sourceId,
      required int amount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$XpEventsTableUpdateCompanionBuilder =
    XpEventsCompanion Function({
      Value<String> id,
      Value<String> sourceType,
      Value<String> sourceId,
      Value<int> amount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$XpEventsTableFilterComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$XpEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$XpEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$XpEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $XpEventsTable,
          XpEvent,
          $$XpEventsTableFilterComposer,
          $$XpEventsTableOrderingComposer,
          $$XpEventsTableAnnotationComposer,
          $$XpEventsTableCreateCompanionBuilder,
          $$XpEventsTableUpdateCompanionBuilder,
          (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
          XpEvent,
          PrefetchHooks Function()
        > {
  $$XpEventsTableTableManager(_$AppDatabase db, $XpEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => XpEventsCompanion(
                id: id,
                sourceType: sourceType,
                sourceId: sourceId,
                amount: amount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceType,
                required String sourceId,
                required int amount,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => XpEventsCompanion.insert(
                id: id,
                sourceType: sourceType,
                sourceId: sourceId,
                amount: amount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$XpEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $XpEventsTable,
      XpEvent,
      $$XpEventsTableFilterComposer,
      $$XpEventsTableOrderingComposer,
      $$XpEventsTableAnnotationComposer,
      $$XpEventsTableCreateCompanionBuilder,
      $$XpEventsTableUpdateCompanionBuilder,
      (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
      XpEvent,
      PrefetchHooks Function()
    >;
typedef $$UserLevelsTableCreateCompanionBuilder =
    UserLevelsCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> level,
      Value<DateTime> updatedAt,
    });
typedef $$UserLevelsTableUpdateCompanionBuilder =
    UserLevelsCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> level,
      Value<DateTime> updatedAt,
    });

class $$UserLevelsTableFilterComposer
    extends Composer<_$AppDatabase, $UserLevelsTable> {
  $$UserLevelsTableFilterComposer({
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

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserLevelsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserLevelsTable> {
  $$UserLevelsTableOrderingComposer({
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

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserLevelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserLevelsTable> {
  $$UserLevelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserLevelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserLevelsTable,
          UserLevel,
          $$UserLevelsTableFilterComposer,
          $$UserLevelsTableOrderingComposer,
          $$UserLevelsTableAnnotationComposer,
          $$UserLevelsTableCreateCompanionBuilder,
          $$UserLevelsTableUpdateCompanionBuilder,
          (
            UserLevel,
            BaseReferences<_$AppDatabase, $UserLevelsTable, UserLevel>,
          ),
          UserLevel,
          PrefetchHooks Function()
        > {
  $$UserLevelsTableTableManager(_$AppDatabase db, $UserLevelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserLevelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserLevelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserLevelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserLevelsCompanion(
                id: id,
                totalXp: totalXp,
                level: level,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserLevelsCompanion.insert(
                id: id,
                totalXp: totalXp,
                level: level,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserLevelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserLevelsTable,
      UserLevel,
      $$UserLevelsTableFilterComposer,
      $$UserLevelsTableOrderingComposer,
      $$UserLevelsTableAnnotationComposer,
      $$UserLevelsTableCreateCompanionBuilder,
      $$UserLevelsTableUpdateCompanionBuilder,
      (UserLevel, BaseReferences<_$AppDatabase, $UserLevelsTable, UserLevel>),
      UserLevel,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required String name,
      required String description,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<int> rowid,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            Achievement,
            BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
          ),
          Achievement,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                name: name,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                name: name,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        Achievement,
        BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
      ),
      Achievement,
      PrefetchHooks Function()
    >;
typedef $$AchievementProgressTableCreateCompanionBuilder =
    AchievementProgressCompanion Function({
      Value<int> id,
      required String achievementId,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<String?> sourceSessionId,
    });
typedef $$AchievementProgressTableUpdateCompanionBuilder =
    AchievementProgressCompanion Function({
      Value<int> id,
      Value<String> achievementId,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<String?> sourceSessionId,
    });

class $$AchievementProgressTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementProgressTable> {
  $$AchievementProgressTableFilterComposer({
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

  ColumnFilters<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceSessionId => $composableBuilder(
    column: $table.sourceSessionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementProgressTable> {
  $$AchievementProgressTableOrderingComposer({
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

  ColumnOrderings<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceSessionId => $composableBuilder(
    column: $table.sourceSessionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementProgressTable> {
  $$AchievementProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get unlocked =>
      $composableBuilder(column: $table.unlocked, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceSessionId => $composableBuilder(
    column: $table.sourceSessionId,
    builder: (column) => column,
  );
}

class $$AchievementProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementProgressTable,
          AchievementProgressData,
          $$AchievementProgressTableFilterComposer,
          $$AchievementProgressTableOrderingComposer,
          $$AchievementProgressTableAnnotationComposer,
          $$AchievementProgressTableCreateCompanionBuilder,
          $$AchievementProgressTableUpdateCompanionBuilder,
          (
            AchievementProgressData,
            BaseReferences<
              _$AppDatabase,
              $AchievementProgressTable,
              AchievementProgressData
            >,
          ),
          AchievementProgressData,
          PrefetchHooks Function()
        > {
  $$AchievementProgressTableTableManager(
    _$AppDatabase db,
    $AchievementProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementProgressTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AchievementProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> achievementId = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<String?> sourceSessionId = const Value.absent(),
              }) => AchievementProgressCompanion(
                id: id,
                achievementId: achievementId,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                sourceSessionId: sourceSessionId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String achievementId,
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<String?> sourceSessionId = const Value.absent(),
              }) => AchievementProgressCompanion.insert(
                id: id,
                achievementId: achievementId,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                sourceSessionId: sourceSessionId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementProgressTable,
      AchievementProgressData,
      $$AchievementProgressTableFilterComposer,
      $$AchievementProgressTableOrderingComposer,
      $$AchievementProgressTableAnnotationComposer,
      $$AchievementProgressTableCreateCompanionBuilder,
      $$AchievementProgressTableUpdateCompanionBuilder,
      (
        AchievementProgressData,
        BaseReferences<
          _$AppDatabase,
          $AchievementProgressTable,
          AchievementProgressData
        >,
      ),
      AchievementProgressData,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableCreateCompanionBuilder =
    ChallengesCompanion Function({
      required String id,
      required String name,
      required String description,
      required int targetCount,
      Value<int> rowid,
    });
typedef $$ChallengesTableUpdateCompanionBuilder =
    ChallengesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<int> targetCount,
      Value<int> rowid,
    });

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => column,
  );
}

class $$ChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTable,
          Challenge,
          $$ChallengesTableFilterComposer,
          $$ChallengesTableOrderingComposer,
          $$ChallengesTableAnnotationComposer,
          $$ChallengesTableCreateCompanionBuilder,
          $$ChallengesTableUpdateCompanionBuilder,
          (
            Challenge,
            BaseReferences<_$AppDatabase, $ChallengesTable, Challenge>,
          ),
          Challenge,
          PrefetchHooks Function()
        > {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> targetCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                name: name,
                description: description,
                targetCount: targetCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required int targetCount,
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                name: name,
                description: description,
                targetCount: targetCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTable,
      Challenge,
      $$ChallengesTableFilterComposer,
      $$ChallengesTableOrderingComposer,
      $$ChallengesTableAnnotationComposer,
      $$ChallengesTableCreateCompanionBuilder,
      $$ChallengesTableUpdateCompanionBuilder,
      (Challenge, BaseReferences<_$AppDatabase, $ChallengesTable, Challenge>),
      Challenge,
      PrefetchHooks Function()
    >;
typedef $$ChallengeProgressTableCreateCompanionBuilder =
    ChallengeProgressCompanion Function({
      Value<int> id,
      required String challengeId,
      Value<int> currentCount,
      Value<bool> completed,
      Value<DateTime?> completedAt,
    });
typedef $$ChallengeProgressTableUpdateCompanionBuilder =
    ChallengeProgressCompanion Function({
      Value<int> id,
      Value<String> challengeId,
      Value<int> currentCount,
      Value<bool> completed,
      Value<DateTime?> completedAt,
    });

class $$ChallengeProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableFilterComposer({
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

  ColumnFilters<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentCount => $composableBuilder(
    column: $table.currentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengeProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableOrderingComposer({
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

  ColumnOrderings<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentCount => $composableBuilder(
    column: $table.currentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengeProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentCount => $composableBuilder(
    column: $table.currentCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$ChallengeProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengeProgressTable,
          ChallengeProgressData,
          $$ChallengeProgressTableFilterComposer,
          $$ChallengeProgressTableOrderingComposer,
          $$ChallengeProgressTableAnnotationComposer,
          $$ChallengeProgressTableCreateCompanionBuilder,
          $$ChallengeProgressTableUpdateCompanionBuilder,
          (
            ChallengeProgressData,
            BaseReferences<
              _$AppDatabase,
              $ChallengeProgressTable,
              ChallengeProgressData
            >,
          ),
          ChallengeProgressData,
          PrefetchHooks Function()
        > {
  $$ChallengeProgressTableTableManager(
    _$AppDatabase db,
    $ChallengeProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengeProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengeProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengeProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> challengeId = const Value.absent(),
                Value<int> currentCount = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ChallengeProgressCompanion(
                id: id,
                challengeId: challengeId,
                currentCount: currentCount,
                completed: completed,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String challengeId,
                Value<int> currentCount = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ChallengeProgressCompanion.insert(
                id: id,
                challengeId: challengeId,
                currentCount: currentCount,
                completed: completed,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengeProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengeProgressTable,
      ChallengeProgressData,
      $$ChallengeProgressTableFilterComposer,
      $$ChallengeProgressTableOrderingComposer,
      $$ChallengeProgressTableAnnotationComposer,
      $$ChallengeProgressTableCreateCompanionBuilder,
      $$ChallengeProgressTableUpdateCompanionBuilder,
      (
        ChallengeProgressData,
        BaseReferences<
          _$AppDatabase,
          $ChallengeProgressTable,
          ChallengeProgressData
        >,
      ),
      ChallengeProgressData,
      PrefetchHooks Function()
    >;
typedef $$AvatarDefinitionsTableCreateCompanionBuilder =
    AvatarDefinitionsCompanion Function({
      required String id,
      required String name,
      required String description,
      required String statesJson,
      Value<int> rowid,
    });
typedef $$AvatarDefinitionsTableUpdateCompanionBuilder =
    AvatarDefinitionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> statesJson,
      Value<int> rowid,
    });

class $$AvatarDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $AvatarDefinitionsTable> {
  $$AvatarDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statesJson => $composableBuilder(
    column: $table.statesJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AvatarDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AvatarDefinitionsTable> {
  $$AvatarDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statesJson => $composableBuilder(
    column: $table.statesJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvatarDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvatarDefinitionsTable> {
  $$AvatarDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statesJson => $composableBuilder(
    column: $table.statesJson,
    builder: (column) => column,
  );
}

class $$AvatarDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvatarDefinitionsTable,
          AvatarDefinition,
          $$AvatarDefinitionsTableFilterComposer,
          $$AvatarDefinitionsTableOrderingComposer,
          $$AvatarDefinitionsTableAnnotationComposer,
          $$AvatarDefinitionsTableCreateCompanionBuilder,
          $$AvatarDefinitionsTableUpdateCompanionBuilder,
          (
            AvatarDefinition,
            BaseReferences<
              _$AppDatabase,
              $AvatarDefinitionsTable,
              AvatarDefinition
            >,
          ),
          AvatarDefinition,
          PrefetchHooks Function()
        > {
  $$AvatarDefinitionsTableTableManager(
    _$AppDatabase db,
    $AvatarDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvatarDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvatarDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvatarDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> statesJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AvatarDefinitionsCompanion(
                id: id,
                name: name,
                description: description,
                statesJson: statesJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required String statesJson,
                Value<int> rowid = const Value.absent(),
              }) => AvatarDefinitionsCompanion.insert(
                id: id,
                name: name,
                description: description,
                statesJson: statesJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AvatarDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvatarDefinitionsTable,
      AvatarDefinition,
      $$AvatarDefinitionsTableFilterComposer,
      $$AvatarDefinitionsTableOrderingComposer,
      $$AvatarDefinitionsTableAnnotationComposer,
      $$AvatarDefinitionsTableCreateCompanionBuilder,
      $$AvatarDefinitionsTableUpdateCompanionBuilder,
      (
        AvatarDefinition,
        BaseReferences<
          _$AppDatabase,
          $AvatarDefinitionsTable,
          AvatarDefinition
        >,
      ),
      AvatarDefinition,
      PrefetchHooks Function()
    >;
typedef $$AvatarItemsTableCreateCompanionBuilder =
    AvatarItemsCompanion Function({
      required String id,
      Value<String?> avatarId,
      required String kind,
      required String name,
      Value<int> rowid,
    });
typedef $$AvatarItemsTableUpdateCompanionBuilder =
    AvatarItemsCompanion Function({
      Value<String> id,
      Value<String?> avatarId,
      Value<String> kind,
      Value<String> name,
      Value<int> rowid,
    });

class $$AvatarItemsTableFilterComposer
    extends Composer<_$AppDatabase, $AvatarItemsTable> {
  $$AvatarItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarId => $composableBuilder(
    column: $table.avatarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AvatarItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $AvatarItemsTable> {
  $$AvatarItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarId => $composableBuilder(
    column: $table.avatarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvatarItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvatarItemsTable> {
  $$AvatarItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get avatarId =>
      $composableBuilder(column: $table.avatarId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$AvatarItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvatarItemsTable,
          AvatarItem,
          $$AvatarItemsTableFilterComposer,
          $$AvatarItemsTableOrderingComposer,
          $$AvatarItemsTableAnnotationComposer,
          $$AvatarItemsTableCreateCompanionBuilder,
          $$AvatarItemsTableUpdateCompanionBuilder,
          (
            AvatarItem,
            BaseReferences<_$AppDatabase, $AvatarItemsTable, AvatarItem>,
          ),
          AvatarItem,
          PrefetchHooks Function()
        > {
  $$AvatarItemsTableTableManager(_$AppDatabase db, $AvatarItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvatarItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvatarItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvatarItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> avatarId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AvatarItemsCompanion(
                id: id,
                avatarId: avatarId,
                kind: kind,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> avatarId = const Value.absent(),
                required String kind,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => AvatarItemsCompanion.insert(
                id: id,
                avatarId: avatarId,
                kind: kind,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AvatarItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvatarItemsTable,
      AvatarItem,
      $$AvatarItemsTableFilterComposer,
      $$AvatarItemsTableOrderingComposer,
      $$AvatarItemsTableAnnotationComposer,
      $$AvatarItemsTableCreateCompanionBuilder,
      $$AvatarItemsTableUpdateCompanionBuilder,
      (
        AvatarItem,
        BaseReferences<_$AppDatabase, $AvatarItemsTable, AvatarItem>,
      ),
      AvatarItem,
      PrefetchHooks Function()
    >;
typedef $$AvatarUnlocksTableCreateCompanionBuilder =
    AvatarUnlocksCompanion Function({
      Value<int> id,
      required String itemId,
      required DateTime unlockedAt,
      Value<String?> sourceEventId,
    });
typedef $$AvatarUnlocksTableUpdateCompanionBuilder =
    AvatarUnlocksCompanion Function({
      Value<int> id,
      Value<String> itemId,
      Value<DateTime> unlockedAt,
      Value<String?> sourceEventId,
    });

class $$AvatarUnlocksTableFilterComposer
    extends Composer<_$AppDatabase, $AvatarUnlocksTable> {
  $$AvatarUnlocksTableFilterComposer({
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

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceEventId => $composableBuilder(
    column: $table.sourceEventId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AvatarUnlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $AvatarUnlocksTable> {
  $$AvatarUnlocksTableOrderingComposer({
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

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceEventId => $composableBuilder(
    column: $table.sourceEventId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvatarUnlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvatarUnlocksTable> {
  $$AvatarUnlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceEventId => $composableBuilder(
    column: $table.sourceEventId,
    builder: (column) => column,
  );
}

class $$AvatarUnlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvatarUnlocksTable,
          AvatarUnlock,
          $$AvatarUnlocksTableFilterComposer,
          $$AvatarUnlocksTableOrderingComposer,
          $$AvatarUnlocksTableAnnotationComposer,
          $$AvatarUnlocksTableCreateCompanionBuilder,
          $$AvatarUnlocksTableUpdateCompanionBuilder,
          (
            AvatarUnlock,
            BaseReferences<_$AppDatabase, $AvatarUnlocksTable, AvatarUnlock>,
          ),
          AvatarUnlock,
          PrefetchHooks Function()
        > {
  $$AvatarUnlocksTableTableManager(_$AppDatabase db, $AvatarUnlocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvatarUnlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvatarUnlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvatarUnlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<String?> sourceEventId = const Value.absent(),
              }) => AvatarUnlocksCompanion(
                id: id,
                itemId: itemId,
                unlockedAt: unlockedAt,
                sourceEventId: sourceEventId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String itemId,
                required DateTime unlockedAt,
                Value<String?> sourceEventId = const Value.absent(),
              }) => AvatarUnlocksCompanion.insert(
                id: id,
                itemId: itemId,
                unlockedAt: unlockedAt,
                sourceEventId: sourceEventId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AvatarUnlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvatarUnlocksTable,
      AvatarUnlock,
      $$AvatarUnlocksTableFilterComposer,
      $$AvatarUnlocksTableOrderingComposer,
      $$AvatarUnlocksTableAnnotationComposer,
      $$AvatarUnlocksTableCreateCompanionBuilder,
      $$AvatarUnlocksTableUpdateCompanionBuilder,
      (
        AvatarUnlock,
        BaseReferences<_$AppDatabase, $AvatarUnlocksTable, AvatarUnlock>,
      ),
      AvatarUnlock,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MetaEntriesTableTableManager get metaEntries =>
      $$MetaEntriesTableTableManager(_db, _db.metaEntries);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$HealthCautionPreferencesTableTableManager get healthCautionPreferences =>
      $$HealthCautionPreferencesTableTableManager(
        _db,
        _db.healthCautionPreferences,
      );
  $$ReminderSchedulesTableTableManager get reminderSchedules =>
      $$ReminderSchedulesTableTableManager(_db, _db.reminderSchedules);
  $$ExerciseCategoriesTableTableManager get exerciseCategories =>
      $$ExerciseCategoriesTableTableManager(_db, _db.exerciseCategories);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseVariantsTableTableManager get exerciseVariants =>
      $$ExerciseVariantsTableTableManager(_db, _db.exerciseVariants);
  $$ExerciseMediaTableTableManager get exerciseMedia =>
      $$ExerciseMediaTableTableManager(_db, _db.exerciseMedia);
  $$FormCuesTableTableManager get formCues =>
      $$FormCuesTableTableManager(_db, _db.formCues);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db, _db.programs);
  $$ProgramWeeksTableTableManager get programWeeks =>
      $$ProgramWeeksTableTableManager(_db, _db.programWeeks);
  $$WorkoutTemplatesTableTableManager get workoutTemplates =>
      $$WorkoutTemplatesTableTableManager(_db, _db.workoutTemplates);
  $$WorkoutTemplateItemsTableTableManager get workoutTemplateItems =>
      $$WorkoutTemplateItemsTableTableManager(_db, _db.workoutTemplateItems);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$HoldAttemptsTableTableManager get holdAttempts =>
      $$HoldAttemptsTableTableManager(_db, _db.holdAttempts);
  $$SessionFeedbackTableTableManager get sessionFeedback =>
      $$SessionFeedbackTableTableManager(_db, _db.sessionFeedback);
  $$PersonalBestsTableTableManager get personalBests =>
      $$PersonalBestsTableTableManager(_db, _db.personalBests);
  $$ProgressSnapshotsTableTableManager get progressSnapshots =>
      $$ProgressSnapshotsTableTableManager(_db, _db.progressSnapshots);
  $$XpEventsTableTableManager get xpEvents =>
      $$XpEventsTableTableManager(_db, _db.xpEvents);
  $$UserLevelsTableTableManager get userLevels =>
      $$UserLevelsTableTableManager(_db, _db.userLevels);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$AchievementProgressTableTableManager get achievementProgress =>
      $$AchievementProgressTableTableManager(_db, _db.achievementProgress);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$ChallengeProgressTableTableManager get challengeProgress =>
      $$ChallengeProgressTableTableManager(_db, _db.challengeProgress);
  $$AvatarDefinitionsTableTableManager get avatarDefinitions =>
      $$AvatarDefinitionsTableTableManager(_db, _db.avatarDefinitions);
  $$AvatarItemsTableTableManager get avatarItems =>
      $$AvatarItemsTableTableManager(_db, _db.avatarItems);
  $$AvatarUnlocksTableTableManager get avatarUnlocks =>
      $$AvatarUnlocksTableTableManager(_db, _db.avatarUnlocks);
}
