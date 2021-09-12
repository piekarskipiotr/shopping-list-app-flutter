import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list_app_flutter/core/validators/amount_validation.dart';
import 'package:shopping_list_app_flutter/core/validators/name_validation.dart';
import 'package:shopping_list_app_flutter/feature/details/bloc/add_edit_delete_grocery_bloc.dart';

class GroceryForm extends StatefulWidget {
  const GroceryForm({Key? key, required this.shoppingListId}) : super(key: key);
  final int shoppingListId;

  @override
  _GroceryFormState createState() => _GroceryFormState();
}

class _GroceryFormState extends State<GroceryForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _amount;
  late final String _errorNameMessage;
  late final String _errorAmountMessage;
  late final AddEditDeleteGroceryBloc _bloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _errorNameMessage = AppLocalizations.of(context)!.name_error_message;
      _errorAmountMessage = AppLocalizations.of(context)!.amount_error_message;
    });

    _bloc = BlocProvider.of<AddEditDeleteGroceryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(),
          _buildNameInputField(),
          SizedBox(
            height: 20.0,
          ),
          _buildAmountInputField(),
          _buildSubmitButton()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(
          AppLocalizations.of(context)!.grocery_adding_dialog_title,
          style: TextStyle(fontSize: 20.0)),
    ));
  }

  Widget _buildNameInputField() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            NameValidation.validate(value) ? null : _errorNameMessage,
        onSaved: (value) => _name = value,
        maxLength: 18,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          errorMaxLines: 5,
          labelText: AppLocalizations.of(context)!.grocery_name,
          contentPadding:
              EdgeInsets.only(left: 15.0, top: 18.0, right: 15.0, bottom: 18.0),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildAmountInputField() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            AmountValidation.validate(value) ? null : _errorAmountMessage,
        onSaved: (value) => _amount = int.parse(value!),
        maxLength: 4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorMaxLines: 5,
          labelText: AppLocalizations.of(context)!.grocery_amount,
          contentPadding:
              EdgeInsets.only(left: 15.0, top: 18.0, right: 15.0, bottom: 18.0),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _bloc.addGrocery(_name!, _amount!, widget.shoppingListId);
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ))),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )));
  }
}
