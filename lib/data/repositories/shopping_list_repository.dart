import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/network/api_service.dart';
import '../app_database.dart';

class ShoppingListRepository {
  AppDatabase _database;
  ShoppingListRepository(this._database);

  Future<List<ShoppingList>> getShoppingListById(int id) async {
    return await _database.shoppingListDao.getShoppingListById(id);
  }

  Future<List<ShoppingList>> getShoppingListByArchivedStatus(bool isArchived) async {
    return await _database.shoppingListDao.getShoppingListByArchivedStatus(isArchived);
    // return ApiService().fetchShoppingList();
  }

  Future<void> increaseShoppingListGroceriesAmount(int id) async {
    await _database.shoppingListDao.increaseShoppingListGroceriesAmount(id);
  }

  Future<void> decreaseShoppingListGroceriesAmount(int id) async {
    await _database.shoppingListDao.decreaseShoppingListGroceriesAmount(id);
  }

  Future<void> increaseShoppingListGroceriesDoneAmount(int id) async {
    await _database.shoppingListDao.increaseShoppingListGroceriesDoneAmount(id);
  }

  Future<void> decreaseShoppingListGroceriesDoneAmount(int id) async {
    await _database.shoppingListDao.decreaseShoppingListGroceriesDoneAmount(id);
  }

  Future<void> insertShoppingList(ShoppingList shoppingList) async {
    await _database.shoppingListDao.insertShoppingList(shoppingList);
  }

  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    await _database.shoppingListDao.updateShoppingList(shoppingList);
  }

  Future<void> deleteShoppingList(ShoppingList shoppingList) async {
    await _database.shoppingListDao.deleteShoppingList(shoppingList);
  }
}