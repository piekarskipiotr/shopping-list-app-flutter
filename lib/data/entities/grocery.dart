import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_list_app_flutter/core/my_parser.dart';
part 'grocery.g.dart';

@entity
@JsonSerializable()
class Grocery extends Equatable {
  @PrimaryKey(autoGenerate: true)
  @JsonKey(fromJson: MyParser.parseString)
  final int? id;
  final String name;
  @JsonKey(fromJson: MyParser.parseString)
  final int amount;
  @JsonKey(name: 'is_done')
  final bool isDone;
  @JsonKey(name: 'shopping_list_id', fromJson: MyParser.parseString)
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

  factory Grocery.fromJson(Map<String, dynamic> json) => _$GroceryFromJson(json);
  Map<String, dynamic> toJson() => _$GroceryToJson(this);

  @override
  List<Object?> get props => [id, name, amount, isDone, shoppingListId];
}
