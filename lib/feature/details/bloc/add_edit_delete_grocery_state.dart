import 'package:equatable/equatable.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';

abstract class AddEditDeleteGroceryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends AddEditDeleteGroceryState {
  @override
  String toString() => "InitState";
}

class AddingGrocery extends AddEditDeleteGroceryState {
  @override
  String toString() => "AddingGrocery";
}

class GroceryAdded extends AddEditDeleteGroceryState {
  final int shoppingListId;
  GroceryAdded(this.shoppingListId);

  @override
  String toString() => "GroceryAdded";
}

class DeletingGrocery extends AddEditDeleteGroceryState {
  @override
  String toString() => "DeletingGrocery";
}

class GroceryDeleted extends AddEditDeleteGroceryState {
  final int shoppingListId;
  GroceryDeleted(this.shoppingListId);

  @override
  String toString() => "GroceryDeleted";
}

class ChangingGroceryStatus extends AddEditDeleteGroceryState {
  final Grocery grocery;
  ChangingGroceryStatus(this.grocery);

  @override
  List<Object?> get props => [grocery];

  @override
  String toString() => "ChangingGroceryStatus";
}

class GroceryStatusChanged extends AddEditDeleteGroceryState {
  final Grocery grocery;
  GroceryStatusChanged(this.grocery);

  @override
  List<Object?> get props => [grocery];

  @override
  String toString() => "GroceryStatusChanged";
}