import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/data/repositories/grocery_repository.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_state.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_state.dart';
import 'package:shopping_list_app_flutter/network/api_service.dart';

class ShoppingListBloc extends Cubit<ShoppingListState> {
  final _shoppingListRepository = injection<ShoppingListRepository>();
  final _groceryRepository = injection<GroceryRepository>();

  final AddDeleteShoppingListBloc addDeleteBloc;
  late StreamSubscription addDeleteBlocSubscription;

  ShoppingListBloc(this.addDeleteBloc) : super(LoadingLists()) {
    addDeleteBlocSubscription = addDeleteBloc.stream.listen((addDeleteState) {
      if (addDeleteState is ShoppingListDeleted)
        getShoppingLists();
      else if (addDeleteState is ShoppingListAdded) getShoppingLists();
    });
  }

  Future<void> getShoppingLists() async {
    emit(LoadingLists());
    final shoppingLists =
        await _shoppingListRepository.getShoppingListByArchivedStatus(false);
    emit(ListsLoaded(shoppingLists));
  }

  Future<void> getShoppingListsFromApi() async {
    emit(LoadingLists());
    await ApiService().fetchShoppingList().then((value) {
      if (value != null) emit(ListsLoaded(value));

    });
  }

  Future<void> checkIfGroceriesDone() async {
    final shoppingLists =
        await _shoppingListRepository.getShoppingListByArchivedStatus(false);
    for (ShoppingList e in shoppingLists) {
      if (e.amountOfAllGroceries == e.amountOfDoneGroceries &&
          e.amountOfAllGroceries > 0) {
        e = e.copyWith(isArchived: true);
        _shoppingListRepository.updateShoppingList(e);
      }
    }

    getShoppingLists();
  }

  Future<void> deleteShoppingListAndGroceries(ShoppingList shoppingList) async {
    await _groceryRepository.deleteGroceryByShoppingListId(shoppingList.id!);
    await _shoppingListRepository.deleteShoppingList(shoppingList);
    getShoppingLists();
  }

  @override
  Future<void> close() {
    addDeleteBlocSubscription.cancel();
    return super.close();
  }
}
