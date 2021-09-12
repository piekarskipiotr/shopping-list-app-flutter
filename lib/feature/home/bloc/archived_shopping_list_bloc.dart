import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'archived_shopping_list_state.dart';

class ArchivedShoppingListBloc extends Cubit<ArchivedShoppingListState> {
  ArchivedShoppingListBloc() : super(LoadingLists());
  final _shoppingListRepository = injection<ShoppingListRepository>();

  Future<void> getShoppingLists() async {
    emit(LoadingLists());
    final shoppingLists = await _shoppingListRepository.getShoppingListByArchivedStatus(true);
    emit(ListsLoaded(shoppingLists));
  }
}