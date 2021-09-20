import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_list_app_flutter/core/app_localizations_helper.dart';
import 'package:shopping_list_app_flutter/data/entities/grocery.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/grocery_bloc.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/grocery_state.dart';
import 'package:shopping_list_app_flutter/feature/details/ui/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList(
      {Key? key, required this.shoppingListId, required this.isArchived})
      : super(key: key);
  final int shoppingListId;
  final bool isArchived;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroceryBloc>(context).getGroceryLists(shoppingListId);
    return Container(
      child: BlocBuilder<GroceryBloc, GroceryState>(
        builder: (context, state) {
          if (state is LoadingLists) {
            return _buildLoadingView();
          } else if (state is ListsLoaded) {
            final groceryList = state.grocery;

            if (groceryList.isNotEmpty)
              return _buildListView(groceryList, context);
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
              child: SvgPicture.asset("assets/images/empty_image.svg")),
          Text(getString(context).empty_list_message, style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );
  }


  Widget _buildListView(List<Grocery> data, BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GroceryItem(grocery: data[index], isArchived: isArchived);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1.0,
        );
      },
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
          Text(getString(context).error_list_message, style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );
  }
}