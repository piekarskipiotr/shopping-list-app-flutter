import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/details_screen.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/home_screen.dart';
import 'app_routes.dart';

class RoutesHandler {
  final AddEditDeleteGroceryBloc _addEditDeleteGroceryBloc = AddEditDeleteGroceryBloc();
  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(
            HomeScreen(),
            settings: settings
        );
      case AppRoutes.details:
        return buildRoute(
            MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => GroceryBloc(_addEditDeleteGroceryBloc)),
                  BlocProvider.value(value: _addEditDeleteGroceryBloc),
                ],
                child: DetailsScreen()
        ), settings: settings);
    }
  }

  MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => child,
    );
  }
}
