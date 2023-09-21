// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NotesDao? _notesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `description` TEXT NOT NULL, `date` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotesDao get notesDao {
    return _notesDaoInstance ??= _$NotesDao(database, changeListener);
  }
}

class _$NotesDao extends NotesDao {
  _$NotesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _noteEntityInsertionAdapter = InsertionAdapter(
            database,
            'NoteEntity',
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date
                },
            changeListener),
        _noteEntityUpdateAdapter = UpdateAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date
                },
            changeListener),
        _noteEntityDeletionAdapter = DeletionAdapter(
            database,
            'NoteEntity',
            ['id'],
            (NoteEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date': item.date
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteEntity> _noteEntityInsertionAdapter;

  final UpdateAdapter<NoteEntity> _noteEntityUpdateAdapter;

  final DeletionAdapter<NoteEntity> _noteEntityDeletionAdapter;

  @override
  Stream<List<NoteEntity>> findAllNotes() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM NoteEntity ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String,
            date: row['date'] as int),
        queryableName: 'NoteEntity',
        isView: false);
  }

  @override
  Future<List<NoteEntity>> findAllNotesFuture() async {
    return _queryAdapter.queryList(
        'SELECT * FROM NoteEntity ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => NoteEntity(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String,
            date: row['date'] as int));
  }

  @override
  Future<int?> deleteNote(int id) async {
    return _queryAdapter.query('DELETE FROM NoteEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<int?> eraseAllNotes() async {
    return _queryAdapter.query('DELETE FROM NoteEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> deleteSelectedNotes(int id) async {
    return _queryAdapter.query('DELETE * FROM NoteEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<int> insertNote(NoteEntity note) {
    return _noteEntityInsertionAdapter.insertAndReturnId(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNote(NoteEntity note) {
    return _noteEntityUpdateAdapter.updateAndReturnChangedRows(
        note, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAll(List<NoteEntity> list) {
    return _noteEntityDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
