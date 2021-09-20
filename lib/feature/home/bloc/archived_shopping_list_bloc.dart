import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';
import 'package:shopping_list_app_flutter/di/injection.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_bloc.dart';
import 'archived_shopping_list_state.dart';

class ArchivedShoppingListBloc extends Cubit<ArchivedShoppingListState> {
  final ShoppingListBloc _shoppingListBloc;
  late StreamSubscription _shoppingListBlocSubscription;
  final _shoppingListRepository = injection<ShoppingListRepository>();

  ArchivedShoppingListBloc(this._shoppingListBloc) : super(LoadingLists()) {
    _shoppingListBlocSubscription = _shoppingListBloc.stream.listen((shoppingListState) {
      if (shoppingListState is LoadingLists)
        emit(LoadingLists());
    });
  }


  Future<void> getShoppingLists() async {
    emit(LoadingLists());
    final shoppingLists = await _shoppingListRepository.getShoppingListByArchivedStatus(true);
    emit(ListsLoaded(shoppingLists));
  }

  @override
  Future<void> close() {
    _shoppingListBlocSubscription.cancel();
    return super.close();
  }

  @override
  void onChange(Change<ArchivedShoppingListState> change) {
    log('$change', name: '$runtimeType');
    super.onChange(change);
  }
}