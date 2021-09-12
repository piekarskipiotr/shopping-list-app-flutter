import 'package:equatable/equatable.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';

abstract class GroceryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingLists extends GroceryState {
  @override
  String toString() => "LoadingGroceryLists";
}

class ListsLoaded extends GroceryState {
  final List<Grocery> grocery;
  ListsLoaded(this.grocery);

  @override
  List<Object?> get props => [grocery];

  @override
  String toString() => "GroceryListsLoaded";
}