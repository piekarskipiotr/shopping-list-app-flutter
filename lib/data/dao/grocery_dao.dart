import 'package:floor/floor.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';

@dao
abstract class GroceryDao {
  @Query('SELECT * FROM grocery WHERE shoppingListId = :shoppingListId')
  Future<List<Grocery>> getGroceryForShoppingList(int shoppingListId);

  @insert
  Future<void> insertGrocery(Grocery grocery);

  @update
  Future<void> updateGrocery(Grocery grocery);

  @Query('UPDATE grocery SET isDone = NOT isDone WHERE id = :id')
  Future<void> changeStatus(int id);

  @delete
  Future<void> deleteGrocery(Grocery grocery);

  @Query('DELETE FROM grocery WHERE shoppingListId = :id')
  Future<void> deleteGroceryByShoppingListId(int id);
}