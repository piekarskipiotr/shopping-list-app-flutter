import 'package:equatable/equatable.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';

abstract class ShoppingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingLists extends ShoppingListState {
  @override
  String toString() => "Shopping list loading state";
}

class ListsLoaded extends ShoppingListState {
  final List<ShoppingList> shoppingList;
  ListsLoaded(this.shoppingList);

  @override
  List<Object?> get props => [shoppingList];

  @override
  String toString() => "Shopping list loaded state";
}