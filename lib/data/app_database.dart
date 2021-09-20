import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:shopping_list_app_flutter/data/dao/grocery_dao.dart';
import 'package:shopping_list_app_flutter/data/dao/shopping_list_dao.dart';
import 'entities/grocery.dart';
import 'entities/shopping_list.dart';

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [ShoppingList, Grocery])
@singleton
abstract class AppDatabase extends FloorDatabase {
  ShoppingListDao get shoppingListDao;
  GroceryDao get groceryDao;

  @factoryMethod
  static Future<AppDatabase> createDatabase() async {
    return await $FloorAppDatabase.databaseBuilder('shopping_list_database').build();
  }
}
