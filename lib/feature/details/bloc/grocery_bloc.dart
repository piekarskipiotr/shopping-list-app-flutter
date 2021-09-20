import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/repositories/grocery_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_state.dart';
import 'grocery_state.dart';

class GroceryBloc extends Cubit<GroceryState> {
  final AddEditDeleteGroceryBloc addEditDeleteGroceryBloc;
  late StreamSubscription addEditDeleteBlocSubscription;
  var _groceryRepository = injection<GroceryRepository>();

  GroceryBloc(this.addEditDeleteGroceryBloc) : super(LoadingLists()) {
    addEditDeleteBlocSubscription = addEditDeleteGroceryBloc.stream.listen((addEditDeleteState) {
      if (addEditDeleteState is GroceryAdded)
        getGroceryLists(addEditDeleteState.shoppingListId);
      else if (addEditDeleteState is GroceryDeleted)
        getGroceryLists(addEditDeleteState.shoppingListId);
      else if (addEditDeleteState is GroceryStatusChanged)
        getGroceryLists(addEditDeleteState.grocery.shoppingListId);
    });
  }

  Future<void> getGroceryLists(int shoppingListId) async {
    emit(LoadingLists());
    final groceryList = await _groceryRepository.getGroceryForShoppingList(shoppingListId);
    emit(ListsLoaded(groceryList));
  }

  @override
  Future<void> close() {
    addEditDeleteBlocSubscription.cancel();
    return super.close();
  }

  @override
  void onChange(Change<GroceryState> change) {
    log('$change', name: '$runtimeType');
    super.onChange(change);
  }
}