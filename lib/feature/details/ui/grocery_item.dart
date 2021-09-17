import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_state.dart';
import 'package:shopping_list_app_flutter/theme/app_colors.dart';

class GroceryItem extends StatelessWidget {
  GroceryItem({Key? key, required this.grocery, required this.isArchived})
      : super(key: key);
  final Grocery grocery;
  final bool isArchived;

  late final AddEditDeleteGroceryBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc =  BlocProvider.of<AddEditDeleteGroceryBloc>(context);

    return BlocBuilder<AddEditDeleteGroceryBloc, AddEditDeleteGroceryState>(
      bloc: AddEditDeleteGroceryBloc(),
      builder: (context, state) {
        if (state is GroceryStatusChanged) {
          return _buildItem(context, state.grocery);
        } else
          return _buildItem(context, grocery);
      },
    );
  }

  Widget _buildItem(BuildContext context, Grocery grocery) {
    return Dismissible(
      key: UniqueKey(),
      direction: isArchived ? DismissDirection.none : DismissDirection.endToStart,
      onDismissed: (direction) => _bloc.deleteGrocery(grocery),
      background: Container(
        alignment: Alignment.centerRight,
        color: AppColors.RED,
        padding: EdgeInsets.only(right: 25.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
        child: ListTile(
          onTap: () {
            if (!isArchived)
              _bloc.changeGroceryStatus(grocery);
          },
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_basket, color: Colors.green, size: 28.0)
              ]),
          title: Text(grocery.name,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration:
                  grocery.isDone ? TextDecoration.lineThrough : null)),
          subtitle: Text(
            'X${grocery.amount}',
            style: TextStyle(
                decoration: grocery.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Icon(
              grocery.isDone
                  ? Icons.check_circle
                  : Icons.check_circle_outline_rounded,
              color: Theme.of(context).primaryColor),
        ),
    );
  }
}