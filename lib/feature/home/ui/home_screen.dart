import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/core/app_localizations_helper.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/archived_shopping_lists.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/shopping_list_form.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/shopping_lists.dart';
import 'package:shopping_list_app_flutter/network/network_listener.dart';
import 'package:shopping_list_app_flutter/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkListener(context);
    BlocProvider.of<ShoppingListBloc>(context).getShoppingLists();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildTabViews(),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        getString(context).shopping_lists,
        style: AppThemes.appBarTitleStyle,
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(
              text: getString(context).shopping_lists,
              icon: Icon(Icons.list)
          ),
          Tab(
              text: getString(context).archived_shopping_lists,
              icon: Icon(Icons.archive)
          ),
        ],
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      children: [
        ShoppingLists(),
        ArchivedShoppingLists(),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
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
                value: BlocProvider.of<AddDeleteShoppingListBloc>(context),
                child: ShoppingListForm(),
              ),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            ));
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}