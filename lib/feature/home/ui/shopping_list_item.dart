import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/routes/app_routes.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({Key? key, required this.shoppingList}) : super(key: key);
  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          if (!shoppingList.isArchived)
            IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  BlocProvider.of<AddDeleteShoppingListBloc>(context).deleteShoppingList(shoppingList);
                }
            )
        ],
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, AppRoutes.details, arguments: shoppingList),
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: Colors.green, size: 28.0)
              ]),
          title: Text(shoppingList.name,
              style: TextStyle(fontWeight: FontWeight.w500)),
          subtitle:
          Text('Groceries ${shoppingList.amountOfDoneGroceries}/${shoppingList.amountOfAllGroceries}'),
        )
    );
  }
}
