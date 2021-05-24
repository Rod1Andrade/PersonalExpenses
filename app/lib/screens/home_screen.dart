import 'package:app/models/transacion_model.dart';
import 'package:app/widgets/chart.dart';
import 'package:app/widgets/transaction_form.dart';
import 'package:app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/messages.dart';

/// Home Screen - tela inicial da aplicação.
///
/// @author Rodrigo Andrade
/// @since 20/05/2021
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TransactionModel> _transactionList = <TransactionModel>[];

  /// Retorna as transacoes dos ultimos 7 dias
  List<TransactionModel> get _recentTransaction {
    return _transactionList
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  /// Adiciona Transaction
  void _addTransaction({String title, double value, DateTime dateTime}) {
    setState(() {
      _transactionList.add(TransactionModel(
        id: '${DateTime.now().millisecond}',
        title: title,
        value: value,
        date: dateTime,
      ));
    });

    // Close the bottom Sheet Modal after submit Transaction.
    Navigator.of(context).pop();
  }

  /// Remove um Transaction da lista de Transactions
  ///
  /// @param String id - Id da transaction
  void _removeTransaction(String id) {
    setState(() {
      _transactionList
          .removeWhere((transaction) => transaction.id.compareTo(id) == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.APP_TITLE),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _transactionList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    Chart(_recentTransaction),
                    TransactionList(
                      transctionModeList: _transactionList,
                      toDelete: _removeTransaction,
                    )
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/teen-walking.gif',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Messages.TITLE_NO_EXPENSES,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                    child: TransactionForm(onAddedExpense: _addTransaction));
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
