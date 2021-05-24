import 'package:app/models/transacion_model.dart';
import 'package:app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Transaction Form tem como responsabilidade
/// o cadastramento de novas despesas pessoais.
///
/// @author Rodrigo Andrade
class TransactionForm extends StatefulWidget {
  final void Function({String title, double value, DateTime dateTime})
      onAddedExpense;

  TransactionForm({this.onAddedExpense});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Map to keep traking Form values
  final Map<String, Object> _formMap = {
    'title': '',
    'value': '',
    'dateTime': DateTime.now(),
  };

  final _formKey = GlobalKey<FormState>();

  // Focus Node to pass to value Field
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  // When the form is submited, call the callback function
  void _onSubmitted() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onAddedExpense(
        title: _formMap['title'],
        value: _formMap['value'],
        dateTime: _formMap['dateTime'],
      );
      _formKey.currentState.reset();
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 395),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 1),
      ),
    ).then((value) {
      setState(() => _formMap['dateTime'] = value);
      _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              initialValue: '',
              decoration: InputDecoration(labelText: Messages.LABEL_TITLE),
              onSaved: (String value) => _formMap['title'] = value,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                _focusNode.requestFocus();
              },
              validator: (String value) {
                if (value == null || value.isEmpty)
                  return Messages.ERROR_EMPTY_FIELD;
                else
                  return null;
              },
            ),
            TextFormField(
              initialValue: '',
              focusNode: _focusNode,
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: Messages.LABEL_VALUE,
                prefix: Text(Messages.PREFIX_REAL),
              ),
              onSaved: (String value) =>
                  _formMap['value'] = double.parse(value),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                _focusNode.unfocus();
                _onSubmitted();
              },
              validator: (String value) {
                if (value == null || value.isEmpty)
                  return Messages.ERROR_INVALID_NUMBER;
                else
                  return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FormField(
                builder: (state) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: state.hasError
                          ? Text(
                              state.errorText,
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : state.isValid
                              ? Text(
                                  '${Messages.LABEL_DATA_SELECTED}: ${DateFormat('dd/MM/y').format(_formMap['dateTime'])}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  Messages.LABEL_NO_DATA_SELECTED,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(Messages.BUTTON_ADD_DATE),
                    )
                  ],
                ),
                validator: (_) {
                  if (_formMap['dateTime'] == null)
                    return 'Selecione uma data por favor.';
                  else
                    return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _onSubmitted,
                    child: Text(Messages.BUTTON_ADD_EXPENSES),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
