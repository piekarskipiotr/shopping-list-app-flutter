import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/grocery_form.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/grocery_list.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/theme/app_theme.dart';

class DetailsScreen extends StatelessWidget {
  late final ShoppingListBloc _bloc;

  @override
  Widget build(BuildContext context) {
    var shoppingList = ModalRoute.of(context)!.settings.arguments as ShoppingList;
    _bloc = BlocProvider.of<ShoppingListBloc>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: GroceryList(
        shoppingListId: shoppingList.id!,
        isArchived: shoppingList.isArchived,
      ),
      floatingActionButton: shoppingList.isArchived ? null : _buildFloatingActionButton(context, shoppingList.id!),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            _bloc.checkIfGroceriesDone();
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_outlined)),
      title: Text(
        AppLocalizations.of(context)!.shopping_lists,
        style: AppThemes.appBarTitleStyle,
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, int shoppingListId) {
    var _addEditDeleteGroceryBloc = BlocProvider.of<AddEditDeleteGroceryBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 30.0),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.0),
                    topLeft: Radius.circular(14.0)),
              ),
              builder: (context) => SingleChildScrollView(
                    child: BlocProvider.value(
                      value: _addEditDeleteGroceryBloc,
                      child: GroceryForm(shoppingListId: shoppingListId),
                    ),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  )
          );
        },
        tooltip: 'Add new grocery',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
