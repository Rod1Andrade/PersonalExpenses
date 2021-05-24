import 'package:app/models/transacion_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget Responsavel por renderizar a lista de
/// transacoes monetarias.
///
/// @author Rodrigo Andrade
/// @since 21/05/2021
class TransactionList extends StatelessWidget {
  final List<TransactionModel> transctionModeList;
  final void Function(String id) toDelete;

  TransactionList({this.transctionModeList, this.toDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transctionModeList.length,
        itemBuilder: (context, index) {
          final transaction = transctionModeList[index];
          return Card(
            elevation: 4.0,
            child: ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => toDelete(transaction.id),
              ),
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                      child:
                          Text('R\$${transaction.value.toStringAsFixed(2)}')),
                ),
              ),
              title: Text(transaction.title),
              subtitle: Text(DateFormat('d/MM/y').format(transaction.date)),
            ),
          );
        });
  }
}
