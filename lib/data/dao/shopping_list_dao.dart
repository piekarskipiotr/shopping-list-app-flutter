import 'package:floor/floor.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';

@dao
abstract class ShoppingListDao {
  @Query('SELECT * FROM shoppingList WHERE id = :id')
  Future<List<ShoppingList>> getShoppingListById(int id);

  @Query('SELECT * FROM shoppingList WHERE isArchived = :isArchived')
  Future<List<ShoppingList>> getShoppingListByArchivedStatus(bool isArchived);

  @Query('UPDATE shoppingList SET amountOfAllGroceries = (amountOfAllGroceries + 1) WHERE id = :id')
  Future<void> increaseShoppingListGroceriesAmount(int id);

  @Query('UPDATE shoppingList SET amountOfAllGroceries = (amountOfAllGroceries - 1) WHERE id = :id')
  Future<void> decreaseShoppingListGroceriesAmount(int id);

  @Query('UPDATE shoppingList SET amountOfDoneGroceries = (amountOfDoneGroceries + 1) WHERE id = :id')
  Future<void> increaseShoppingListGroceriesDoneAmount(int id);

  @Query('UPDATE shoppingList SET amountOfDoneGroceries = (amountOfDoneGroceries - 1) WHERE id = :id')
  Future<void> decreaseShoppingListGroceriesDoneAmount(int id);

  @insert
  Future<void> insertShoppingList(ShoppingList shoppingList);

  @update
  Future<void> updateShoppingList(ShoppingList shoppingList);

  @delete
  Future<void> deleteShoppingList(ShoppingList shoppingList);
}