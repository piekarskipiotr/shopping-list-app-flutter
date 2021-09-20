import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/core/app_localizations_helper.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/routes/navigator_service.dart';
import 'add_delete_shopping_list_state.dart';

class AddDeleteShoppingListBloc extends Cubit<AddDeleteShoppingListState> {
  AddDeleteShoppingListBloc() : super(InitState());
  final _shoppingListRepository = injection<ShoppingListRepository>();

  Future<void> addShoppingList(String name) async {
    emit(AddingShoppingList());
    var _shoppingList = ShoppingList(
        name: name,
        isArchived: false,
        amountOfAllGroceries: 0,
        amountOfDoneGroceries: 0);
    await _shoppingListRepository.insertShoppingList(_shoppingList);
    emit(ShoppingListAdded(_shoppingList));
  }

  Future<void> deleteShoppingList(ShoppingList shoppingList) async {
    var context = injection<NavigationService>().navKey.currentState!.context;
    var cancelDeleting = false;

    emit(DeletingShoppingList());
    await ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(getString(context).delete_message(shoppingList.name)),
          action: SnackBarAction(
            label: getString(context).cancel,
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
            },
          ),
        )
    ).closed.then((reason) {
      if (reason == SnackBarClosedReason.dismiss) {
        cancelDeleting = true;
        log('dismissed');
      } else
        log('other');
    });

    if (!cancelDeleting)
        await _shoppingListRepository.deleteShoppingList(shoppingList);

    emit(ShoppingListDeleted());
  }

  @override
  void onChange(Change<AddDeleteShoppingListState> change) {
    log('$change', name: '$runtimeType');
    super.onChange(change);
  }
}
