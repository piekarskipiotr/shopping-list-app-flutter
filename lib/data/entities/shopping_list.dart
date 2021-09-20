import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_list_app_flutter/core/my_parser.dart';
part 'shopping_list.g.dart';

@entity
@JsonSerializable()
class ShoppingList extends Equatable {
  @PrimaryKey(autoGenerate: true)
  @JsonKey(fromJson: MyParser.parseString)
  final int? id;
  final String name;
  @JsonKey(name: 'amount_of_done_groceries', fromJson: MyParser.parseString)
  final int amountOfDoneGroceries;
  @JsonKey(name: 'amount_of_all_groceries', fromJson: MyParser.parseString)
  final int amountOfAllGroceries;
  @JsonKey(name: 'is_archived')
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

  factory ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingListToJson(this);

  @override
  List<Object?> get props =>
      [id, name, amountOfDoneGroceries, amountOfAllGroceries];
}
