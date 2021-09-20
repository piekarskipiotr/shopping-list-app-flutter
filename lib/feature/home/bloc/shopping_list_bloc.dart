import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/data/repositories/grocery_repository.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_state.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_state.dart';
import 'dart:developer';

class ShoppingListBloc extends Cubit<ShoppingListState> {
  final _shoppingListRepository = injection<ShoppingListRepository>();
  final _groceryRepository = injection<GroceryRepository>();

  final AddDeleteShoppingListBloc addDeleteBloc;
  late StreamSubscription addDeleteBlocSubscription;

  ShoppingListBloc(this.addDeleteBloc) : super(ShoppingListBlocInitState()) {
    addDeleteBlocSubscription = addDeleteBloc.stream.listen((addDeleteState) {
      if (addDeleteState is ShoppingListDeleted)
        getShoppingLists();
      else if (addDeleteState is ShoppingListAdded) getShoppingLists();
    });
  }

  Future<void> getShoppingLists() async {
    emit(LoadingLists());
    final shoppingLists = await _shoppingListRepository.getShoppingListByArchivedStatus(false);
    emit(ListsLoaded(shoppingLists));
  }

  // Future<void> getShoppingListsFromApi() async {
  //   emit(LoadingLists());
  //   await ApiService().fetchShoppingList().then((value) {
  //     emit(ListsLoaded(value));
  //   });
  // }

  Future<void> checkIfGroceriesDone(int shoppingListId) async {
    ShoppingList? shoppingList =
        await _shoppingListRepository.getShoppingListById(shoppingListId);
    if (shoppingList != null) {
      if (shoppingList.amountOfAllGroceries ==
              shoppingList.amountOfDoneGroceries &&
          shoppingList.amountOfAllGroceries > 0) {
        shoppingList = shoppingList.copyWith(isArchived: true);
        await _shoppingListRepository.updateShoppingList(shoppingList);
      }

      getShoppingLists();
    }
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

  @override
  void onChange(Change<ShoppingListState> change) {
    log('$change', name: '$runtimeType');
    super.onChange(change);
  }
}
