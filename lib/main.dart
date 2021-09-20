import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_list_app_flutter/network/bloc/network_bloc.dart';
import 'package:shopping_list_app_flutter/routes/app_routes.dart';
import 'package:shopping_list_app_flutter/routes/navigator_service.dart';
import 'package:shopping_list_app_flutter/routes/routes_handler.dart';
import 'di/injection.dart';
import 'feature/home/bloc/add_delete_shopping_list_bloc.dart';
import 'feature/home/bloc/archived_shopping_list_bloc.dart';
import 'feature/home/bloc/shopping_list_bloc.dart';
import 'l10n/l10n.dart';
import 'network/bloc/network_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  //init
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    final AddDeleteShoppingListBloc addDeleteShoppingListBloc = AddDeleteShoppingListBloc();
    final ShoppingListBloc _shoppingListBloc = ShoppingListBloc(addDeleteShoppingListBloc);
    final ArchivedShoppingListBloc archivedShoppingListBloc = ArchivedShoppingListBloc(_shoppingListBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: addDeleteShoppingListBloc),
        BlocProvider.value(value: archivedShoppingListBloc),
        BlocProvider(create: (_) => NetworkBloc()),
        BlocProvider.value(value: _shoppingListBloc),
      ],
      child: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is StateChanged) {
            switch (state.source.keys.toList()[0]) {
              case ConnectivityResult.mobile:
                log('Mobile: Online', name: 'NetworkConnection');
                break;
              case ConnectivityResult.wifi:
                log('WiFi: Online', name: 'NetworkConnection');
                break;
              case ConnectivityResult.none:
              default:
                log('Offline', name: 'NetworkConnection');
            }
          }
        },
        child: MaterialApp(
          title: 'ShoppingListApp',
          debugShowCheckedModeBanner: false,
          navigatorKey: injection<NavigationService>().navKey,

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
      ),
    );
  }
}
