import 'package:flutter/material.dart';
import 'package:shopping_list_app_flutter/core/app_localizations_helper.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  Future<void>? navigateTo(String routeName) {
    return navKey.currentState?.pushNamed(routeName);
  }

  Future<void>? navigateToWithArgs(String routeName, String args) {
    return navKey.currentState?.pushNamed(routeName, arguments: args);
  }

  Future<void> showDeleteDialog(String shoppingListName) async {
    ScaffoldMessenger.of(navKey.currentState!.context).showSnackBar(
        SnackBar(
          content: Text(getString(navKey.currentState!.context).delete_message(shoppingListName)),
          action: SnackBarAction(
            label: getString(navKey.currentState!.context).cancel,
            onPressed: () {
            },
          ),
        )
    );
  }

  Future<void> openDialog() async {
    // ScaffoldMessenger.of(navKey.currentState!.context).showMaterialBanner(
    //   MaterialBanner(
    //     content: Padding(
    //       padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    //       child: const Text('Hello, I am a Material Banner'),
    //     ),
    //     leading: const Icon(Icons.info),
    //     actions: [
    //       TextButton(
    //         child: const Text('Dismiss'),
    //         onPressed: () => ScaffoldMessenger.of(navKey.currentState!.context)
    //             .hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.dismiss),
    //       ),
    //     ],
    //   ),
    // ).closed.then((reason) => print('------------ $reason'));
  }
}
