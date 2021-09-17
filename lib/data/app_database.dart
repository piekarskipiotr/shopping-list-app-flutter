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
abstract class AppDatabase extends FloorDatabase {
  ShoppingListDao get shoppingListDao;
  GroceryDao get groceryDao;
}
