import 'package:equatable/equatable.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';

abstract class ArchivedShoppingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingLists extends ArchivedShoppingListState {
  @override
  String toString() => "Shopping list loading state";
}

class ListsLoaded extends ArchivedShoppingListState {
  final List<ShoppingList> shoppingList;
  ListsLoaded(this.shoppingList);

  @override
  List<Object?> get props => [shoppingList];

  @override
  String toString() => "Shopping list loaded state";
}