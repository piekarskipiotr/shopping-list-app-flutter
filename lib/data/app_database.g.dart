// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  ShoppingListDao? _shoppingListDaoInstance;

  GroceryDao? _groceryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `ShoppingList` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `amountOfDoneGroceries` INTEGER NOT NULL, `amountOfAllGroceries` INTEGER NOT NULL, `isArchived` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Grocery` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `amount` INTEGER NOT NULL, `isDone` INTEGER NOT NULL, `shoppingListId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ShoppingListDao get shoppingListDao {
    return _shoppingListDaoInstance ??=
        _$ShoppingListDao(database, changeListener);
  }

  @override
  GroceryDao get groceryDao {
    return _groceryDaoInstance ??= _$GroceryDao(database, changeListener);
  }
}

class _$ShoppingListDao extends ShoppingListDao {
  _$ShoppingListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _shoppingListInsertionAdapter = InsertionAdapter(
            database,
            'ShoppingList',
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amountOfDoneGroceries': item.amountOfDoneGroceries,
                  'amountOfAllGroceries': item.amountOfAllGroceries,
                  'isArchived': item.isArchived ? 1 : 0
                }),
        _shoppingListUpdateAdapter = UpdateAdapter(
            database,
            'ShoppingList',
            ['id'],
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amountOfDoneGroceries': item.amountOfDoneGroceries,
                  'amountOfAllGroceries': item.amountOfAllGroceries,
                  'isArchived': item.isArchived ? 1 : 0
                }),
        _shoppingListDeletionAdapter = DeletionAdapter(
            database,
            'ShoppingList',
            ['id'],
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amountOfDoneGroceries': item.amountOfDoneGroceries,
                  'amountOfAllGroceries': item.amountOfAllGroceries,
                  'isArchived': item.isArchived ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShoppingList> _shoppingListInsertionAdapter;

  final UpdateAdapter<ShoppingList> _shoppingListUpdateAdapter;

  final DeletionAdapter<ShoppingList> _shoppingListDeletionAdapter;

  @override
  Future<List<ShoppingList>> getShoppingListById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM shoppingList WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ShoppingList(
            id: row['id'] as int?,
            name: row['name'] as String,
            amountOfDoneGroceries: row['amountOfDoneGroceries'] as int,
            amountOfAllGroceries: row['amountOfAllGroceries'] as int,
            isArchived: (row['isArchived'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<ShoppingList>> getShoppingListByArchivedStatus(
      bool isArchived) async {
    return _queryAdapter.queryList(
        'SELECT * FROM shoppingList WHERE isArchived = ?1',
        mapper: (Map<String, Object?> row) => ShoppingList(
            id: row['id'] as int?,
            name: row['name'] as String,
            amountOfDoneGroceries: row['amountOfDoneGroceries'] as int,
            amountOfAllGroceries: row['amountOfAllGroceries'] as int,
            isArchived: (row['isArchived'] as int) != 0),
        arguments: [isArchived ? 1 : 0]);
  }

  @override
  Future<void> increaseShoppingListGroceriesAmount(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE shoppingList SET amountOfAllGroceries = (amountOfAllGroceries + 1) WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> decreaseShoppingListGroceriesAmount(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE shoppingList SET amountOfAllGroceries = (amountOfAllGroceries - 1) WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> increaseShoppingListGroceriesDoneAmount(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE shoppingList SET amountOfDoneGroceries = (amountOfDoneGroceries + 1) WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> decreaseShoppingListGroceriesDoneAmount(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE shoppingList SET amountOfDoneGroceries = (amountOfDoneGroceries - 1) WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertShoppingList(ShoppingList shoppingList) async {
    await _shoppingListInsertionAdapter.insert(
        shoppingList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    await _shoppingListUpdateAdapter.update(
        shoppingList, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteShoppingList(ShoppingList shoppingList) async {
    await _shoppingListDeletionAdapter.delete(shoppingList);
  }
}

class _$GroceryDao extends GroceryDao {
  _$GroceryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _groceryInsertionAdapter = InsertionAdapter(
            database,
            'Grocery',
            (Grocery item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'isDone': item.isDone ? 1 : 0,
                  'shoppingListId': item.shoppingListId
                }),
        _groceryUpdateAdapter = UpdateAdapter(
            database,
            'Grocery',
            ['id'],
            (Grocery item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'isDone': item.isDone ? 1 : 0,
                  'shoppingListId': item.shoppingListId
                }),
        _groceryDeletionAdapter = DeletionAdapter(
            database,
            'Grocery',
            ['id'],
            (Grocery item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'isDone': item.isDone ? 1 : 0,
                  'shoppingListId': item.shoppingListId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Grocery> _groceryInsertionAdapter;

  final UpdateAdapter<Grocery> _groceryUpdateAdapter;

  final DeletionAdapter<Grocery> _groceryDeletionAdapter;

  @override
  Future<List<Grocery>> getGroceryForShoppingList(int shoppingListId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grocery WHERE shoppingListId = ?1',
        mapper: (Map<String, Object?> row) => Grocery(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as int,
            isDone: (row['isDone'] as int) != 0,
            shoppingListId: row['shoppingListId'] as int),
        arguments: [shoppingListId]);
  }

  @override
  Future<void> changeStatus(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE grocery SET isDone = NOT isDone WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteGroceryByShoppingListId(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM grocery WHERE shoppingListId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertGrocery(Grocery grocery) async {
    await _groceryInsertionAdapter.insert(grocery, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGrocery(Grocery grocery) async {
    await _groceryUpdateAdapter.update(grocery, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGrocery(Grocery grocery) async {
    await _groceryDeletionAdapter.delete(grocery);
  }
}
