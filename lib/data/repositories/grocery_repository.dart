import 'package:shopping_list_app_flutter/data/entities/grocery.dart';
import '../app_database.dart';

class GroceryRepository {
  AppDatabase _database;
  GroceryRepository(this._database);

  Future<List<Grocery>> getGroceryForShoppingList(int id) async {
    return await _database.groceryDao.getGroceryForShoppingList(id);
  }

  Future<void> insertGrocery(Grocery grocery) async {
    await _database.groceryDao.insertGrocery(grocery);
  }

  Future<void> updateGrocery(Grocery grocery) async {
    await _database.groceryDao.updateGrocery(grocery);
  }

  Future<void> changeStatus(int id) async {
    await _database.groceryDao.changeStatus(id);
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    await _database.groceryDao.deleteGrocery(grocery);
  }

  Future<void> deleteGroceryByShoppingListId(int shoppingListId) async {
    await _database.groceryDao.deleteGroceryByShoppingListId(shoppingListId);
  }
}