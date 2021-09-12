import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class ShoppingList extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int amountOfDoneGroceries;
  final int amountOfAllGroceries;
  final bool isArchived;

  ShoppingList({
    this.id,
    required this.name,
    required this.amountOfDoneGroceries,
    required this.amountOfAllGroceries,
    required this.isArchived,
  });

  ShoppingList copyWith(
          {int? id,
          String? name,
          int? amountOfDoneGroceries,
          int? amountOfAllGroceries,
          bool? isArchived}) =>
      ShoppingList(
          id: id ?? this.id,
          name: name ?? this.name,
          amountOfDoneGroceries: amountOfDoneGroceries ?? this.amountOfDoneGroceries,
          amountOfAllGroceries: amountOfAllGroceries ?? this.amountOfAllGroceries,
          isArchived: isArchived ?? this.isArchived);

  static ShoppingList fromJson(json) => ShoppingList(
    id: int.parse(json["id"]),
    name: json["name"],
    amountOfDoneGroceries: int.parse(json["amount_of_done_groceries"]),
    amountOfAllGroceries: int.parse(json["amount_of_all_groceries"]),
    isArchived: json["is_archived"]
  );

  Map toJson() => {
    "id": id,
    "name": name,
    "amount_of_done_groceries": amountOfDoneGroceries,
    "amount_of_all_groceries": amountOfAllGroceries,
    "is_archived": isArchived
  };

  @override
  List<Object?> get props =>
      [id, name, amountOfDoneGroceries, amountOfAllGroceries];
}
