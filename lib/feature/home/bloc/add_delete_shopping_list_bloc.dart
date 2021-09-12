import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'add_delete_shopping_list_state.dart';

class AddDeleteShoppingListBloc extends Cubit<AddDeleteShoppingListState> {
  AddDeleteShoppingListBloc() : super(InitState());
  final _shoppingListRepository = injection<ShoppingListRepository>();

  Future<void> addShoppingList(String name) async {
    emit(AddingShoppingList());
    var _shoppingList = ShoppingList(name: name, isArchived: false, amountOfAllGroceries: 0, amountOfDoneGroceries: 0);
    await _shoppingListRepository.insertShoppingList(_shoppingList);
    emit(ShoppingListAdded(_shoppingList));
  }

  Future<void> deleteShoppingList(ShoppingList shoppingList) async {
    emit(DeletingShoppingList());
    await _shoppingListRepository.deleteShoppingList(shoppingList);
    emit(ShoppingListDeleted());
  }
}