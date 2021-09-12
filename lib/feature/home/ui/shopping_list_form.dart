import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list_app_flutter/core/validators/name_validation.dart';
import 'package:shopping_list_app_flutter/feature/home/bloc/add_delete_shopping_list_bloc.dart';

class ShoppingListForm extends StatefulWidget {
  const ShoppingListForm({Key? key}) : super(key: key);

  @override
  _ShoppingListFormState createState() => _ShoppingListFormState();
}

class _ShoppingListFormState extends State<ShoppingListForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  late final String _errorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _errorMessage = AppLocalizations.of(context)!.name_error_message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildTitle(), _buildInputField(), _buildSubmitButton()],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Text(AppLocalizations.of(context)!.shopping_list_adding_dialog_title, style: TextStyle(fontSize: 20.0)),
    ));
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            NameValidation.validate(value) ? null : _errorMessage,
        onSaved: (value) => _name = value,
        maxLength: 18,
        decoration: InputDecoration(
          errorMaxLines: 5,
          labelText: AppLocalizations.of(context)!.shopping_list_name,
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
                  BlocProvider.of<AddDeleteShoppingListBloc>(context).addShoppingList(_name!);
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