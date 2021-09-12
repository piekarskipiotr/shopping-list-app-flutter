import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Grocery extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int amount;
  final bool isDone;
  final int shoppingListId;

  Grocery({
    this.id,
    required this.name,
    required this.amount,
    required this.isDone,
    required this.shoppingListId,
  });

  Grocery copyWith(
          {int? id,
          String? name,
          int? amount,
          bool? isDone,
          int? shoppingListId}) =>
      Grocery(
          id: id ?? this.id,
          name: name ?? this.name,
          amount: amount ?? this.amount,
          isDone: isDone ?? this.isDone,
          shoppingListId: shoppingListId ?? this.shoppingListId);

  static Grocery fromJson(json) => Grocery(
      id: int.parse(json["id"]),
      name: json["name"],
      amount: int.parse(json["amount"]),
      isDone: json["is_done"],
      shoppingListId: json["shopping_list_id"]
  );

  Map toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "is_done": isDone,
    "shopping_list_id": shoppingListId
  };

  @override
  List<Object?> get props => [id, name, amount, isDone, shoppingListId];
}
