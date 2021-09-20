import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/routes/app_routes.dart';
import 'package:shopping_list_app_flutter/theme/app_colors.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({Key? key, required this.shoppingList})
      : super(key: key);
  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) BlocProvider.of<AddDeleteShoppingListBloc>(context).deleteShoppingList(shoppingList);
        },
        background: Container(
          alignment: Alignment.centerRight,
          color: AppColors.RED,
          padding: EdgeInsets.only(right: 25.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
        direction: shoppingList.isArchived ? DismissDirection.none : DismissDirection.endToStart,
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, AppRoutes.details,
              arguments: shoppingList),
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: Colors.green, size: 28.0)
              ]),
          title: Text(shoppingList.name,
              style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text(
              'Groceries ${shoppingList.amountOfDoneGroceries}/${shoppingList.amountOfAllGroceries}'),
        ));
  }
}