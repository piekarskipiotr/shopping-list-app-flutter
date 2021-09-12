import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_list_app_flutter/network/network_bloc.dart';
import 'package:shopping_list_app_flutter/routes/app_routes.dart';
import 'package:shopping_list_app_flutter/routes/routes_handler.dart';
import 'di/injection.dart';
import 'feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'feature/home/bloc/archived_shopping_list_bloc.dart';
import 'feature/home/bloc/shopping_list_bloc.dart';
import 'l10n/l10n.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddDeleteShoppingListBloc addDeleteShoppingListBloc = AddDeleteShoppingListBloc();
    final ShoppingListBloc _shoppingListBloc = ShoppingListBloc(
        addDeleteShoppingListBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _shoppingListBloc),
        BlocProvider.value(value: addDeleteShoppingListBloc),
        BlocProvider(create: (_) => ArchivedShoppingListBloc()),
        BlocProvider(create: (_) => NetworkBloc())
      ],
      child: MaterialApp(
        title: 'ShoppingListApp',
        debugShowCheckedModeBanner: false,

        //localization
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],

        //theme
        themeMode: ThemeMode.system,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,

        //routes
        initialRoute: AppRoutes.home,
        onGenerateRoute: RoutesHandler().getRoute,
      ),
    );
  }
}
