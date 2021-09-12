import 'package:equatable/equatable.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';

abstract class AddDeleteShoppingListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends AddDeleteShoppingListState {}

class AddingShoppingList extends AddDeleteShoppingListState {
  @override
  String toString() => 'AddingShoppingList';
}

class ShoppingListAdded extends AddDeleteShoppingListState {
  final ShoppingList shoppingList;
  ShoppingListAdded(this.shoppingList);

  @override
  List<Object?> get props => [shoppingList];

  @override
  String toString() => 'ShoppingListAdded';
}

class DeletingShoppingList extends AddDeleteShoppingListState {
  @override
  String toString() => 'DeletingShoppingList';
}

class ShoppingListDeleted extends AddDeleteShoppingListState {
  @override
  String toString() => 'ShoppingListDeleted';
}