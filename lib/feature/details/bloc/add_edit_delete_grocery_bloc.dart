import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';
import 'package:shopping_list_app_flutter/data/repositories/grocery_repository.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'add_edit_delete_grocery_state.dart';

class AddEditDeleteGroceryBloc extends Cubit<AddEditDeleteGroceryState> {
  var _groceryRepository = injection<GroceryRepository>();
  var _shoppingListRepository = injection<ShoppingListRepository>();
  AddEditDeleteGroceryBloc() : super(InitState());

  Future<void> addGrocery(String name, int amount, int shoppingListId) async {
    emit(AddingGrocery());
    final grocery = Grocery(name: name, amount: amount, isDone: false, shoppingListId: shoppingListId);
    await _groceryRepository.insertGrocery(grocery);
    await _shoppingListRepository.increaseShoppingListGroceriesAmount(shoppingListId);
    emit(GroceryAdded(shoppingListId));
  }

  Future<void> changeGroceryStatus(Grocery grocery) async {
    emit(ChangingGroceryStatus(grocery));
    grocery = grocery.copyWith(isDone: !grocery.isDone);
    await _groceryRepository.updateGrocery(grocery);

    if (grocery.isDone)
      await _shoppingListRepository.increaseShoppingListGroceriesDoneAmount(grocery.shoppingListId);
    else
      await _shoppingListRepository.decreaseShoppingListGroceriesDoneAmount(grocery.shoppingListId);

    emit(GroceryStatusChanged(grocery));
  }

  Future<void> deleteGrocery(Grocery grocery) async {
    emit(DeletingGrocery());
    await _groceryRepository.deleteGrocery(grocery);
    if (grocery.isDone)
      _shoppingListRepository.decreaseShoppingListGroceriesDoneAmount(grocery.shoppingListId);
    await _shoppingListRepository.decreaseShoppingListGroceriesAmount(grocery.shoppingListId);
    emit(GroceryDeleted(grocery.shoppingListId));
  }
}