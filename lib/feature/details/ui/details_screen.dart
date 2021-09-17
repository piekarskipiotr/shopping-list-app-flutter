import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/grocery_form.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/grocery_list.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/theme/app_theme.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final ShoppingListBloc _bloc;

  Future<bool> _onWillPop(int shoppingListId) async {
    _bloc.checkIfGroceriesDone(shoppingListId);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var shoppingList = ModalRoute.of(context)!.settings.arguments as ShoppingList;
    _bloc = BlocProvider.of<ShoppingListBloc>(context);

    return WillPopScope(
      onWillPop: () => _onWillPop(shoppingList.id!),
      child: Scaffold(
        appBar: _buildAppBar(context, shoppingList.id!),
        body: GroceryList(
          shoppingListId: shoppingList.id!,
          isArchived: shoppingList.isArchived,
        ),
        floatingActionButton: shoppingList.isArchived ? null : _buildFloatingActionButton(context, shoppingList.id!),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, int shoppingListId) {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            _bloc.checkIfGroceriesDone(shoppingListId);
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

    return FloatingActionButton(
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
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
