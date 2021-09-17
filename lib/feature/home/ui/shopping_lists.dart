import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_list_app_flutter/data/entities/shopping_list.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_bloc.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/shopping_list_state.dart';
import 'package:shopping_list_app_flutter/feature/home/ui/shopping_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingLists extends StatefulWidget {

  @override
  _ShoppingListsState createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingLists> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<ShoppingListBloc>(context);
    return Container(
      child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          super.build(context);
          if (state is LoadingLists) {
            _bloc.getShoppingLists();
            return _buildLoadingView();
          } else if (state is ListsLoaded) {
            final shoppingLists = state.shoppingList;

            if (shoppingLists.isNotEmpty)
              return _buildListView(shoppingLists, _bloc);
            else
              return _buildEmptyListView(context);

          } else {
            return _buildErrorView(context);
          }
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyListView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 256,
              height: 256,
              child: SvgPicture.asset("assets/images/empty_image.svg")
          ),
          Text(AppLocalizations.of(context)!.empty_list_message, style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );
  }

  Widget _buildListView(List<ShoppingList> data, ShoppingListBloc bloc) {
    return BlocProvider.value(
      value: bloc,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ShoppingListItem(
            shoppingList: data[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 256,
              height: 256,
              child: SvgPicture.asset("assets/images/error_image.svg")),
          Text(AppLocalizations.of(context)!.error_list_message, style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );
  }
}
