import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/routes/navigator_service.dart';
import 'add_delete_shopping_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDeleteShoppingListBloc extends Cubit<AddDeleteShoppingListState> {
  AddDeleteShoppingListBloc() : super(InitState());
  var _shoppingListRepository = injection<ShoppingListRepository>();

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
    var cancelDeleting = false;
    emit(DeletingShoppingList());
    await ScaffoldMessenger.of(injection<NavigationService>().navKey.currentState!.context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Are you sure you want to delete ${shoppingList.name}?'),
          action: SnackBarAction(
            label: AppLocalizations.of(injection<NavigationService>().navKey.currentState!.context)!.dismiss,
            onPressed: () {
              ScaffoldMessenger.of(injection<NavigationService>().navKey.currentState!.context)
                  .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
            },
          ),
        )
    ).closed.then((reason) {
      if (reason == SnackBarClosedReason.dismiss) {
        cancelDeleting = true;
        print('dismissed');
      } else
        print('other');
    });

    if (!cancelDeleting)
        await _shoppingListRepository.deleteShoppingList(shoppingList);

    emit(ShoppingListDeleted());
  }
}
