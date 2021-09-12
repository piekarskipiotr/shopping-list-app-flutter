import 'package:get_it/get_it.dart';
import 'package:shopping_list_app_flutter/data/app_database.dart';
import 'package:shopping_list_app_flutter/data/repositories/grocery_repository.dart';
import 'package:shopping_list_app_flutter/data/repositories/shopping_list_repository.dart';

//global var
final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase
      .databaseBuilder('shopping_list_app_db')
      .build();

  injection.registerSingleton<AppDatabase>(database);

  injection.registerSingleton<ShoppingListRepository>(
      ShoppingListRepository(database)
  );

  injection.registerSingleton<GroceryRepository>(
      GroceryRepository(database)
  );
}